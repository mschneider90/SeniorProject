using System;
using System.IO;
using System.IO.Ports;
using System.Globalization;
using System.Security;
using System.Threading;

namespace MooseBoxGame
{
    class MooseBoxGame
    {
        public static void Main()
        {
            Console.WriteLine("- > MooseBoxGame Mk.I");
            Console.WriteLine("- > Enter the name of a serial port from the list below");

            string[] portNames = SerialPort.GetPortNames();
            if (portNames.Length == 0)
            {
                Console.WriteLine("- > ERROR: No serial ports found. Press enter to exit");
            }

            for (int i = 0; i < portNames.Length; i++)
            {
                Console.WriteLine("    {0}", portNames[i]);
            }
            Console.Write("- > ");

            String portName = Console.ReadLine();

            // UART settings. These must match the UART transceiver module (uart.v)
            int baudRate = 115200;
            Parity parityBits = Parity.None;
            int dataBits = 8;
            StopBits stopBits = StopBits.One;
            int sleepBetweenNotes = 104;

            // Read timeout 500ms
            const int READ_TIMEOUT = 500;
            const int WRITE_TIMEOUT = 500;

            SerialPort serial = new SerialPort(portName, baudRate, parityBits, dataBits, stopBits);
            serial.ReadTimeout = READ_TIMEOUT;
            serial.WriteTimeout = WRITE_TIMEOUT;
            if (!openSerialPort(serial))
            {
                Console.WriteLine("Failed to open serial port. Press enter to exit");
            }
            Console.WriteLine("- > Serial port opened successfully");
            Console.WriteLine("- > Current UART settings");
            Console.WriteLine("    BAUD: {0}", baudRate);
            Console.WriteLine("    Parity: {0}", parityBits);
            Console.WriteLine("    Data bits: {0}", dataBits);
            Console.WriteLine("    Stop bits: {0}", stopBits);

            int line = 839;
            uint pos = 40;
            while (true)
            {
                // Clear previous position
                //serialWrite(serial, (uint)(0x1050 + ((line + 40) * 80 + pos)), (uint)(0),false);

                if (line == 0)
                {
                    line = 839;
                }
                else
                {
                    line--;
                }
                //serialWrite(serial, (uint)0x20, (uint)(0x1050 + (line * 80)), false);

                uint a = serialRead(serial, (uint)(0x12));
                uint d = serialRead(serial, (uint)(0x14));

                if (a == 1)
                {
                    Console.WriteLine("a pressed");
                    if (pos > 0)
                    {
                        pos--;
                    }
                }
                if (d == 1)
                {
                    Console.WriteLine("d pressed");
                    if (pos < 80)
                    {
                        pos++;
                    }
                }

                //serialWrite(serial, (uint)(0x1050 + ((line + 40) * 80 + pos)), (uint)(0xE0), false);

                //Thread.Sleep(33);
            }
        }

        static void loadGameData() { }
 
        static string[] readFile(string filePath)
        {
            string[] lines;
            try
            {
                lines = System.IO.File.ReadAllLines(filePath);
            }
            catch (ArgumentException)
            {
                Console.WriteLine("- FILE > Invalid pathname");
                throw new IOException();
            }
            catch (FileNotFoundException)
            {
                Console.WriteLine("- FILE > Can't find file");
                throw new IOException();
            }
            catch (IOException)
            {
                Console.WriteLine("- FILE > IO failed in reading this file");
                throw new IOException();
            }

            return lines;
        }

        static uint serialRead(SerialPort serial, uint addr)
        {
            // Must match the value in uartInterface.v
            byte[] READ_COMMAND = { 0x55 };

            serial.Write(READ_COMMAND, 0, 1);
            Thread.Sleep(1);
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

            return toInt(rx_data_bytes);
        }

        static bool serialWrite(SerialPort serial, uint addr, uint data, bool verifyWrite)
        {
            // Must match the value in uartInterface.v
            byte[] WRITE_COMMAND = { 0x56 };

            serial.Write(WRITE_COMMAND, 0, 1);
            Thread.Sleep(1);
            serial.Write(toByteArray(addr), 0, 4);
            Thread.Sleep(1);
            serial.Write(toByteArray(data), 0, 4);

            if (verifyWrite)
            {
                Thread.Sleep(1);
                // Check that value was successfully written by reading it back
                serial.DiscardInBuffer();
                try
                {
                    if (data == serialRead(serial, addr))
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

            return true;
        }

        static byte[] toByteArray(uint val)
        {
            byte[] arr = new byte[4];
            arr[0] = (byte)val;
            arr[1] = (byte)(val >> 8);
            arr[2] = (byte)(val >> 16);
            arr[3] = (byte)(val >> 24);

            return arr;
        }

        static uint toInt(byte[] arr)
        {
            uint val = 0;
            val += arr[0];
            val += (uint)(arr[1] << 8);
            val += (uint)(arr[2] << 16);
            val += (uint)(arr[3] << 24);

            return val;
        }

        static bool openSerialPort(SerialPort serial)
        {
            try
            {
                serial.Open();
            }
            catch (UnauthorizedAccessException)
            {
                Console.WriteLine("ERROR: Access to port denied. Press enter to exit");
                Console.ReadLine();
                return false;
            }
            catch (ArgumentOutOfRangeException)
            {
                Console.WriteLine("ERROR: Bad UART settings. Press enter to exit");
                Console.ReadLine();
                return false;
            }
            catch (ArgumentException)
            {
                Console.WriteLine("ERROR: Bad port name. Press enter to exit");
                Console.ReadLine();
                return false;
            }
            catch (IOException)
            {
                Console.WriteLine("ERROR: Invalid port state. Press enter to exit");
                Console.ReadLine();
                return false;
            }
            catch (InvalidOperationException)
            {
                Console.WriteLine("ERROR: Port already open. Press enter to exit");
                Console.ReadLine();
                return false;
            }

            return true;
        }
    }
}


