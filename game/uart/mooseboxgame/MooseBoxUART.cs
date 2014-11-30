using System;
using System.IO;
using System.IO.Ports;
using System.Globalization;
using System.Security;
using System.Threading;

namespace MooseBoxGame
{
    /// <summary>
    /// Wraps the SerialPort class, for usage with the MooseBox FPGA Arcade System.
    /// This class provides thread safe access to the serial hardware on the host side.
    /// </summary>
    public class MooseBoxUART
    {
        // UART settings. These must match the UART transceiver module (uart.v)
        const int BAUD_RATE = 115200;
        Parity PARITY_BITS = Parity.None;
        int DATA_BITS = 8;
        StopBits STOP_BITS = StopBits.One;

        // Read timeout 500ms
        const int READ_TIMEOUT = 500;
        const int WRITE_TIMEOUT = 500;

        SerialPort serial;

        // Control access to the SerialPort r/w functions
        Mutex uart_mutex;

        /// <summary>
        /// Creates a new SerialPort with the given portname and the parameters above
        /// </summary>
        /// <param name="portName">The name of the COM port to use</param>
        public MooseBoxUART(String portName)
        {
            serial = new SerialPort(portName, BAUD_RATE, PARITY_BITS, DATA_BITS, STOP_BITS);
            serial.ReadTimeout = READ_TIMEOUT;
            serial.WriteTimeout = WRITE_TIMEOUT;

            uart_mutex = new Mutex();
        }

        /// <summary>
        /// Opens the port
        /// </summary>
        /// <exception cref="IOException">The port could not be opened</exception>
        public void open()
        {
            try
            {
                serial.Open();
            }
            catch (Exception ex)
            {
                throw new IOException();
            }
        }

        /// <summary>
        /// Closes the port
        /// </summary>
        public void close()
        {
            serial.Close();
        }

        /// <summary>
        /// Reads a 32-bit word from the specified address. Thread safe.
        /// </summary>
        /// <param name="addr">The address to read from</param>
        /// <returns>The 32-bit data read from the specified address</returns>
        public uint read(uint addr)
        {
            serial.DiscardInBuffer();

            // Must match the value in uartInterface.v
            byte[] READ_COMMAND = { 0x55 };

            uart_mutex.WaitOne();
            serial.Write(READ_COMMAND, 0, 1);
            serial.Write(toByteArray(addr), 0, 4);

            byte[] rx_data_bytes = new byte[4];
            for (int i = 0; i < 4; i++)
            {
                try
                {
                    rx_data_bytes[i] = (byte)serial.ReadByte();
                }
                catch (TimeoutException)
                {
                    throw new TimeoutException();
                }
            }

            uart_mutex.ReleaseMutex();

            return toInt(rx_data_bytes);
        }

        /// <summary>
        /// Writes a 32-bit word to the specified address. Thread safe.
        /// </summary>
        /// <param name="addr">The address to write to</param>
        /// <param name="data">The data to write</param>
        /// <param name="verifyWrite">Perform a verification read after the write</param>
        /// <returns>True if the write was successfully verified OR if verifyWrite is false; false otherwise</returns>
        public bool write(uint addr, uint data, bool verifyWrite = false)
        {
            // Must match the value in uartInterface.v
            byte[] WRITE_COMMAND = { 0x56 };

            // Block until we can get access to this section
            uart_mutex.WaitOne();

            serial.Write(WRITE_COMMAND, 0, 1);
            serial.Write(toByteArray(addr), 0, 4);
            serial.Write(toByteArray(data), 0, 4);

            if (verifyWrite)
            {
                // Check that value was successfully written by reading it back
                try
                {
                    if (data == read(addr))
                    {
                        return true;
                    }
                    else
                    {
                        Console.WriteLine("- WRITE > ERROR: Verification read did not match");
                        return false;
                    }
                }
                catch (TimeoutException)
                {
                    Console.WriteLine("- WRITE > ERROR: Verification read timed out");
                    return false;
                }
            }

            uart_mutex.ReleaseMutex();

            return true;
        }

        /// <summary>
        /// Write a file starting at the specified address. Thread safe.
        /// </summary>
        /// <param name="startingAddr">The address to start writing the file</param>
        /// <param name="data">The file, in hex format with two bytes per line</param>
        /// <param name="verifyWrite">Verify the written contents</param>
        /// <returns>True if the write was successfully verified OR if verifyWrite is false; false otherwise</returns>
        public bool write(uint startingAddr, String[] data, bool verifyWrite = false)
        {
            bool success = true;
            for (uint i = 0; i < data.Length; i++)
            {
                uint addr = startingAddr + i;
                uint line = uint.Parse(data[i], NumberStyles.AllowHexSpecifier);
                if (!write(addr, line, verifyWrite))
                {
                    success = false;
                    break;
                }
            }
            return success;
        }

        /// <summary>
        /// Get a list of names of available ports
        /// </summary>
        /// <returns>A list of names of available ports</returns>
        public static String[] getPorts()
        {
            return SerialPort.GetPortNames();
        }

        /// <summary>
        /// Converts a 32-bit word into a byte array
        /// </summary>
        /// <param name="val">The 32-bit word</param>
        /// <returns>A 32-bit byte array (4x8b) representation of the word</returns>
        private static byte[] toByteArray(uint val)
        {
            byte[] arr = new byte[4];
            arr[0] = (byte)val;
            arr[1] = (byte)(val >> 8);
            arr[2] = (byte)(val >> 16);
            arr[3] = (byte)(val >> 24);

            return arr;
        }

        /// <summary>
        /// Converts a 32-bit byte array (4x8b) to a 32-bit word
        /// </summary>
        /// <param name="arr">The byte array</param>
        /// <returns>A 32-bit word representation of the byte array</returns>
        /// <exception cref="ArgumentException">The array was not 4 bytes long</exception>
        private static uint toInt(byte[] arr)
        {
            if (arr.Length != 4)
            {
                throw new ArgumentException();
            }

            uint val = 0;
            val += arr[0];
            val += (uint)(arr[1] << 8);
            val += (uint)(arr[2] << 16);
            val += (uint)(arr[3] << 24);

            return val;
        }
    }
}
