using System;
using System.IO;
using System.IO.Ports;

namespace MooseboxSerial
{
    class MooseSerial
    {
        public static void Main()
        {
            Console.WriteLine("MooseBox Serial Communicator MK.I");
            Console.WriteLine("Enter name of serial port");
            Console.Write("> ");

            String portName = Console.ReadLine();

            // UART settings. These must match the UART transceiver module
            const int baudRate = 9600;
            const Parity parity = Parity.None;
            const int dataBits = 8;
            const StopBits stopBits = StopBits.One;

            // UART protocol constants
            byte[] WRITE_COMMAND = { 0x0F };
            byte[] READ_COMMAND = { 0xF5 };

            SerialPort serial = new SerialPort(portName, baudRate, parity, dataBits, stopBits);
            try
            {
                serial.Open();
            }
            catch (UnauthorizedAccessException)
            {
                Console.WriteLine("ERROR: Access to port denied. Press enter to exit");
                Console.ReadLine();
                return;
            }
            catch (ArgumentOutOfRangeException)
            {
                Console.WriteLine("ERROR: Bad UART settings. Press enter to exit");
                Console.ReadLine();
                return;
            }
            catch (ArgumentException)
            {
                Console.WriteLine("ERROR: Bad port name. Press enter to exit");
                Console.ReadLine();
                return;
            }
            catch (IOException)
            {
                Console.WriteLine("ERROR: Invalid port state. Press enter to exit");
                Console.ReadLine();
                return;
            }
            catch (InvalidOperationException)
            {
                Console.WriteLine("ERROR: Port already open. Press enter to exit");
                Console.ReadLine();
                return;
            }

            bool exit = false;
            String input;
            while (!exit)
            {
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

                    int addr = Convert.ToInt32(Console.ReadLine());

                    serial.Write(READ_COMMAND, 0 , 1);
                    //serial.Write(toByteArray(addr), 0, 4);
                }
                else if (input.Equals("write"))
                {
                    Console.WriteLine("Enter address to write to");
                    Console.Write("> ");

                    int addr = Convert.ToInt32(Console.ReadLine());

                    Console.WriteLine("Enter data to write");
                    Console.Write("> ");

                    int data = Convert.ToInt32(Console.ReadLine());

                    serial.Write(WRITE_COMMAND, 0, 1);
                    //serial.Write(toByteArray(addr), 0, 4);
                    //serial.Write(toByteArray(data), 0, 4);
                }
                else if (input.Equals("file"))
                {
                    // TODO
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
            }
        }
    }
}
