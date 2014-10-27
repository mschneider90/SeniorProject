using System;
using System.IO;
using System.IO.Ports;
using System.Globalization;
using System.Security;
using System.Threading;

namespace MooseboxSerial
{
    class MooseSerial
    {
        public static void Main()
        {
            Console.WriteLine("- > MooseBox Serial Communicator MK.I");
            Console.WriteLine("- > Enter the name of a serial port from the list below");

            string[] portNames = SerialPort.GetPortNames();
            if (portNames.Length == 0)
            {
                Console.WriteLine("- > ERROR: No serial ports found. Press enter to exit");
                Console.ReadLine();
                return;
            }

            for (int i = 0; i < portNames.Length; i++)
            {
                Console.WriteLine("    {0}", portNames[i]);
            }
            Console.Write("- > ");

            String portName = Console.ReadLine();

            // UART settings. These must match the UART transceiver module (uart.v)
            const int BAUD_RATE = 38400;
            const Parity PARITY = Parity.None;
            const int DATA_BITS = 8;
            const StopBits STOP_BITS = StopBits.One;

            // Read timeout 500ms
            const int READ_TIMEOUT = 500;
           
            SerialPort serial = new SerialPort(portName, BAUD_RATE, PARITY, DATA_BITS, STOP_BITS);
            serial.ReadTimeout = READ_TIMEOUT;
            if (!openSerialPort(serial))
            {
                Console.WriteLine("Failed to open serial port. Press enter to exit");
                Console.ReadLine();
                return;
            }
            Console.WriteLine("- > Serial port opened successfully");

            bool exit = false;
            String input;
            while (!exit)
            {
                Console.WriteLine("- > Enter a command, or type 'help'");
                Console.Write("- > ");
                input = Console.ReadLine();
                if (input.Equals("help"))
                {
                    printHelpText();
                    
                }
                else if (input.Equals("read"))
                {
                    Console.Write("- READ > Enter address to read from: ");

                    uint addr = uint.Parse(Console.ReadLine(), NumberStyles.AllowHexSpecifier);
                    uint rxData;

                    serial.DiscardInBuffer();

                    try
                    {
                        rxData = serialRead(serial, addr);
                    } catch (TimeoutException)
                    {
                        Console.WriteLine("- READ > ERROR: read timed out");
                        continue;
                    }

                    Console.WriteLine("- READ > Received data: {0:X}", rxData);
                }
                else if (input.Equals("write"))
                {
                    Console.Write("- WRITE > Enter address to write to: ");
                    uint addr = uint.Parse(Console.ReadLine(), NumberStyles.AllowHexSpecifier);

                    Console.Write("- WRITE > Enter data to write: ");
                    uint data = uint.Parse(Console.ReadLine(), NumberStyles.AllowHexSpecifier);

                    if (serialWrite(serial, addr, data, true))
                    {
                        Console.WriteLine("- WRITE > Write completed successfully");
                    }
                    else
                    {
                        Console.WriteLine("- WRITE > ERROR: Write failed");
                    }
                    
                }
                else if (input.Equals("file"))
                {
                    Console.Write("- FILE > Enter name of file to write from: ");
                    string filePath = Console.ReadLine();

                    Console.Write("- FILE > Enter starting address: ");
                    uint startingAddr = uint.Parse(Console.ReadLine(), NumberStyles.AllowHexSpecifier);

                    string[] lines;
                    try
                    {
                        lines = readFile(filePath);
                    }
                    catch (IOException)
                    {
                        Console.WriteLine("- FILE > Failed to open file");
                        continue;
                    }

                    bool failed = false;
                    for (uint i = 0; i < lines.Length; i++)
                    {
                        uint addr = startingAddr + i;
                        uint data = uint.Parse(lines[i], NumberStyles.AllowHexSpecifier);

                        Console.WriteLine("- FILE > Writing {0:X} to address {1:X}...", data, addr); 
                        if (!serialWrite(serial, addr, data, true))
                        {
                            Console.WriteLine("- FILE > File write failed");
                            failed = true;
                            break;
                        }
                        Thread.Sleep(5);
                    }
                    if (!failed)
                    {
                        Console.WriteLine("- FILE > File write completed successfully");
                    }
                }
                else if (input.Equals("dump"))
                {
                    Console.WriteLine("- DUMP > Not yet implemented");
                }
                else if (input.Equals("music"))
                {
                    Console.Write("- MUSIC > Enter name of music file: ");
                    string filePath = Console.ReadLine();

                    string[] lines;
                    try
                    {
                        lines = readFile(filePath);
                    }
                    catch (IOException)
                    {
                        Console.WriteLine("- MUSIC > Failed to open file");
                        continue;
                    }

                    for (int i = 0; i < lines.Length; i++ )
                    {
                        String[] regs = lines[i].Split(',');
                        for (uint j = 1; j < regs.Length; j += 2) // Write effects registers
                        {
                            uint fx = uint.Parse(regs[j], NumberStyles.AllowHexSpecifier);
                            
                            serialWrite(serial, j, fx, false);
                        }

                        for (uint j = 0; j < regs.Length; j += 2) // Write note registers
                        {
                            uint note = uint.Parse(regs[j], NumberStyles.AllowHexSpecifier);

                            if (note != 0) // Only write note regs if they are non-zero
                            {
                                serialWrite(serial, j, note, false);
                            }
                        }

                        Thread.Sleep(104);
                    }
                }
                else if (input.Equals("exit"))
                {
                    serial.Close();
                    exit = true;
                }
                else
                {
                    Console.WriteLine("- > Invalid command!");
                }
            }
        }

        static void printHelpText()
        {
            Console.WriteLine("- HELP > List of commands");
            Console.WriteLine("         read  (Reads a single byte)");
            Console.WriteLine("         write (Writes a single byte)");
            Console.WriteLine("         file  (Writes an entire file)");
            Console.WriteLine("         dump  (Reads a set of locations into a file");
            Console.WriteLine("         music (Creates some beeps)");
            Console.WriteLine("         exit  (Exits Moosebox Serial Communicator)");
        }

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
            catch (PathTooLongException)
            {
                Console.WriteLine("- FILE > Path too long");
                throw new IOException();
            }
            catch (DirectoryNotFoundException)
            {
                Console.WriteLine("- FILE > Can't find directory");
                throw new IOException();
            }
            catch (UnauthorizedAccessException)
            {
                Console.WriteLine("- FILE > Do not have permission to read this file");
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
            catch (NotSupportedException)
            {
                Console.WriteLine("- FILE > Path is in an invalid format");
                throw new IOException();
            }
            catch (SecurityException)
            {
                Console.WriteLine("- FILE > Do not have permission to read this file");
                throw new IOException();
            }

            return lines;
        }

        static uint serialRead(SerialPort serial, uint addr)
        {
            // Must match the value in uartInterface.v
            byte[] READ_COMMAND = {0x55};

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


