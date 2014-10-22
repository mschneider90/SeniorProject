using System;
using System.IO;
using System.IO.Ports;
using System.Globalization;

namespace MooseboxSerial
{
    class MooseSerial
    {
        public static void Main()
        {
            Console.WriteLine("MooseBox Serial Communicator MK.I");
            Console.WriteLine("Enter the name of a serial port from the list below");
            string[] portNames = SerialPort.GetPortNames();
            for (int i = 0; i < portNames.Length; i++)
            {
                Console.WriteLine("  {0}", portNames[i]);
            }
            Console.Write("> ");

            String portName = Console.ReadLine();

            // UART settings. These must match the UART transceiver module (uart.v)
            const int baudRate = 9600;
            const Parity parity = Parity.None;
            const int dataBits = 8;
            const StopBits stopBits = StopBits.One;
           
            SerialPort serial = new SerialPort(portName, baudRate, parity, dataBits, stopBits);
            if (!openSerialPort(serial))
            {
                return; //Failed to open serial
            }

            bool exit = false;
            String input;
            while (!exit)
            {
                Console.Clear();
                Console.WriteLine("MooseBox Serial Communicator MK.I");
                Console.WriteLine("Enter a command, or type 'help'");
                Console.Write("> ");
                input = Console.ReadLine();
                if (input.Equals("help"))
                {
                    Console.WriteLine("List of commands");
                    Console.WriteLine("   read (Reads a single byte)");
                    Console.WriteLine("   write (Writes a single byte)");
                    Console.WriteLine("   file (Writes an entire file)");
                    Console.WriteLine("   exit (Exits Moosebox Serial Communicator)");
                }
                else if (input.Equals("read"))
                {
                    Console.WriteLine("Enter address to read from");
                    Console.Write("> ");

                    int addr = int.Parse(Console.ReadLine(), NumberStyles.AllowHexSpecifier);
                    int rxData;

                    serial.DiscardInBuffer();

                    try
                    {
                        rxData = serialRead(serial, addr);
                    } catch (TimeoutException)
                    {
                        Console.WriteLine("ERROR: read timed out");
                        break;
                    }

                    Console.WriteLine("Received data: {0:X}", rxData);
                }
                else if (input.Equals("write"))
                {
                    Console.WriteLine("Enter address to write to");
                    Console.Write("> ");

                    int addr = int.Parse(Console.ReadLine(), NumberStyles.AllowHexSpecifier);

                    Console.WriteLine("Enter data to write");
                    Console.Write("> ");

                    int data = int.Parse(Console.ReadLine(), NumberStyles.AllowHexSpecifier);

                    if (serialWrite(serial, addr, data))
                    {
                        Console.WriteLine("Write completed successfully");
                    }
                    else
                    {
                        Console.WriteLine("ERROR: Write failed");
                    }
                    
                }
                else if (input.Equals("file"))
                {
                    // TODO
                    Console.WriteLine("Not yet implemented");
                }
                else if (input.Equals("exit"))
                {
                    serial.Close();
                    exit = true;
                }
                else
                {
                    Console.WriteLine("Invalid command!");
                }

                if (!exit)
                {
                    Console.WriteLine("Press enter to continue");
                    Console.ReadLine();
                }
            }
        }

        static int serialRead(SerialPort serial, int addr)
        {
            // Must match the value in uartInterface.v
            byte[] READ_COMMAND = {0x55};

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

            return toInt(rx_data_bytes);
        }

        static bool serialWrite(SerialPort serial, int addr, int data)
        {
            // Must match the value in uartInterface.v
            byte[] WRITE_COMMAND = { 0x56 };

            serial.Write(WRITE_COMMAND, 0, 1);
            serial.Write(toByteArray(addr), 0, 4);
            serial.Write(toByteArray(data), 0, 4);

            // Check that value was successfully written by reading it back
            serial.DiscardInBuffer();
            if (data == serialRead(serial, addr))
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        static byte[] toByteArray(int val)
        {
            byte[] arr = new byte[4];
            arr[0] = (byte)val;
            arr[1] = (byte)(val >> 8);
            arr[2] = (byte)(val >> 16);
            arr[3] = (byte)(val >> 24);

            return arr;
        }

        static int toInt(byte[] arr)
        {
            int val = 0;
            val += arr[0];
            val += arr[1] << 8;
            val += arr[2] << 16;
            val += arr[3] << 24;

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


