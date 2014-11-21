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
            Console.WriteLine("- > MooseBox Serial Communicator Mk.II");
            Console.WriteLine("- > Enter the name of a serial port from the list below");

            string[] portNames = SerialPort.GetPortNames();
            if (portNames.Length == 0)
            {
                Console.WriteLine("- > ERROR: No serial ports found. Press enter to exit");
                if (!Console.ReadLine().Equals("moose"))
                {
                    return;
                }
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
                if (!Console.ReadLine().Equals("moose")) //backdoor
                {
                    return;
                }
            }
            Console.WriteLine("- > Serial port opened successfully");
            Console.WriteLine("- > Current UART settings");
            Console.WriteLine("    BAUD: {0}", baudRate);
            Console.WriteLine("    Parity: {0}", parityBits);
            Console.WriteLine("    Data bits: {0}", dataBits);
            Console.WriteLine("    Stop bits: {0}", stopBits);

            bool exit = false;
            String[] input;
            while (!exit)
            {
                Console.WriteLine("- > Enter a command, or type 'help'");
                Console.Write("- > ");
                input = Console.ReadLine().Split(' ');

                if (input[0].Equals("help"))
                {
                    doHelpCommand();
                }
                else if (input[0].Equals("read"))
                {
                    doReadCommand(serial, input);
                }
                else if (input[0].Equals("write"))
                {
                    doWriteCommand(serial, input);
                }
                else if (input[0].Equals("file"))
                {
                    doFileCommand(serial, input);
                }
                else if (input[0].Equals("dump"))
                {
                    doDumpCommand(serial, input);
                }
                else if (input[0].Equals("music"))
                {
                    doMusicCommand(serial, input, sleepBetweenNotes);
                }
                else if (input[0].Equals("music2"))
                {
                    doMusic2Command(serial, input, sleepBetweenNotes);
                }
                else if (input[0].Equals("program"))
                {
                    doProgramCommand(serial, input);
                }
                else if (input[0].Equals("settings"))
                {
                    doSettingsCommand(serial, input, ref baudRate, ref sleepBetweenNotes);
                }
                else if (input[0].Equals("exit"))
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

        static void doReadCommand(SerialPort serial, string[] input)
        {
            if (input.Length != 2)
            {
                Console.WriteLine("- READ > ERROR: bad arguments");
                return;
            }
            uint addr = uint.Parse(input[1], NumberStyles.AllowHexSpecifier);
            uint rxData;

            serial.DiscardInBuffer();

            try
            {
                rxData = serialRead(serial, addr);
            }
            catch (TimeoutException)
            {
                Console.WriteLine("- READ > ERROR: read timed out");
                return;
            }

            Console.WriteLine("- READ > Received data: {0:X}", rxData);
        }

        static void doWriteCommand(SerialPort serial, string[] input)
        {
            if (input.Length != 3 && input.Length != 4)
            {
                Console.WriteLine("- WRITE > ERROR: bad arguments");
                return;
            }

            bool verifyWrite = true;
            if (input.Length == 4)
            {
                if (input[3] == "-noverify")
                {
                    verifyWrite = false;
                }
            }

            uint addr = uint.Parse(input[1], NumberStyles.AllowHexSpecifier);
            uint data = uint.Parse(input[2], NumberStyles.AllowHexSpecifier);

            if (serialWrite(serial, addr, data, verifyWrite))
            {
                Console.WriteLine("- WRITE > Write completed successfully");
            }
            else
            {
                Console.WriteLine("- WRITE > ERROR: Write failed");
            }
        }

        static void doFileCommand(SerialPort serial, string[] input)
        {
            if (input.Length != 3 && input.Length != 4)
            {
                Console.WriteLine("- FILE > ERROR: bad arguments");
                return;
            }

            bool verifyWrite = true;
            if (input.Length == 4)
            {
                if (input[3] == "-noverify")
                {
                    verifyWrite = false;
                }
            }

            string filePath = input[1];
            uint startingAddr = uint.Parse(input[2], NumberStyles.AllowHexSpecifier);

            string[] lines;
            try
            {
                lines = readFile(filePath);
            }
            catch (IOException)
            {
                Console.WriteLine("- FILE > Failed to open file");
                return;
            }

            bool failed = false;
            for (uint i = 0; i < lines.Length; i++)
            {
                uint addr = startingAddr + i;
                uint data = uint.Parse(lines[i], NumberStyles.AllowHexSpecifier);

                Console.WriteLine("- FILE > Writing {0:X} to address {1:X}...", data, addr);
                if (!serialWrite(serial, addr, data, verifyWrite))
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

        static void doMusicCommand(SerialPort serial, string[] input, int sleepBetweenNotes)
        {
            if (input.Length != 2)
            {
                Console.WriteLine("- MUSIC > ERROR: bad arguments");
                return;
            }

            string filePath = input[1];

            string[] lines;
            try
            {
                lines = readFile(filePath);
            }
            catch (IOException)
            {
                Console.WriteLine("- MUSIC > Failed to open file");
                return;
            }

            for (int i = 0; i < lines.Length; i++)
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
                    else //write garbage to one of the unused ACP registers
                    {
                        serialWrite(serial, 0xF, 0, false);
                    }
                }

                Thread.Sleep(sleepBetweenNotes);
            }
        }

        static void doMusic2Command(SerialPort serial, string[] input, int sleepBetweenNotes)
        {
            if (input.Length != 2)
            {
                Console.WriteLine("- MUSIC2 > ERROR: bad arguments");
                return;
            }

            string filePath = input[1];

            string[] lines;
            try
            {
                lines = readFile(filePath);
            }
            catch (IOException)
            {
                Console.WriteLine("- MUSIC2 > Failed to open file");
                return;
            }

            for (int i = 0; i < lines.Length; i++)
            {
                Console.WriteLine("line {0}",i);
                String[] bytes = lines[i].Split('\t');
                for (uint j = 2; j < bytes.Length; j += 4) // Write effects registers
                {
                    uint fx_high = (uint.Parse(bytes[j], NumberStyles.AllowHexSpecifier) << 8);
                    uint fx_low = uint.Parse(bytes[j + 1], NumberStyles.AllowHexSpecifier);
                    uint fx = fx_high + fx_low;

                    Console.WriteLine("fx {0}: {1:X}", (j -2)/ 2 + 1, fx);
                    serialWrite(serial, (j - 2) / 4 + 1, fx, false);
                }

                for (uint j = 0; j < bytes.Length; j += 4) // Write note registers
                {
                    uint note_high = (uint.Parse(bytes[j], NumberStyles.AllowHexSpecifier) << 8);
                    uint note_low = uint.Parse(bytes[j+1], NumberStyles.AllowHexSpecifier);
                    uint note = note_high + note_low;
                    Console.WriteLine("note {0}: {1:X}", j / 2 , note);
                    if (note != 0) // Only write note regs if they are non-zero
                    {
                        serialWrite(serial, j / 2, note, false);
                    }
                    else //write garbage to one of the unused ACP registers
                    {
                        serialWrite(serial, 0xF, 0, false);
                    }
                }

                Thread.Sleep(sleepBetweenNotes);
            }
        }

        static void doProgramCommand(SerialPort serial, String[] input)
        {
            if (input.Length != 2)
            {
                Console.WriteLine("- PROGRAM > ERROR: bad arguments");
            }

            string filePath = input[1];

            string[] lines;
            try
            {
                lines = readFile(filePath);
            }
            catch (IOException)
            {
                Console.WriteLine("- PROGRAM > Failed to open file");
                return;
            }

            const uint CPU_IMEM_SIZE = 4096;
            const uint CPU_IMEM_BASE_ADDR = 0x30;
            const uint MIPS_NO_OP = 0x20080000;

            for (uint i = 0; i < CPU_IMEM_SIZE; i++)
            {
                uint addr = CPU_IMEM_BASE_ADDR + i;
                if (i < lines.Length)
                {
                    uint data = uint.Parse(lines[i], NumberStyles.AllowHexSpecifier);

                    Console.WriteLine("- PROGRAM > Writing {0:X} to address {1:X}...", data, addr);
                    if (!serialWrite(serial, addr, data, true))
                    {
                        Console.WriteLine("- PROGRAM > CPU programming failed (is it reset?)");
                        return;
                    }
                }
                else
                {
                    Console.WriteLine("- PROGRAM > Writing no-op to address {0:X}", addr);
                    if (!serialWrite(serial, CPU_IMEM_BASE_ADDR + i, MIPS_NO_OP, true))
                    {
                        Console.WriteLine("- PROGRAM > CPU programming failed (is it reset?)");
                        return;
                    }
                }
            }
            Console.WriteLine("- PROGRAM > CPU programmed successfully");
        }

        static void doSettingsCommand(SerialPort serial, String[] input, ref int baud, ref int sleep)
        {
            if (input.Length != 3)
            {
                Console.WriteLine("- MUSIC > ERROR: bad arguments");
                return;
            }

            if (input[1].Equals("baud"))
            {
                baud = int.Parse(input[2]);
                serial.BaudRate = baud;
            }
            else if (input[1].Equals("delay"))
            {
                sleep = int.Parse(input[2]);
            }
            else
            {
                Console.WriteLine("- SETTINGS > Not a valid setting");
            }
        }

        static void doDumpCommand(SerialPort serial, string[] input)
        {
            Console.WriteLine("- DUMP > Not yet implemented");
        }

        static void doHelpCommand()
        {
            Console.WriteLine("- HELP > List of commands. Note that the format for all addresses/data is hex");
            Console.WriteLine("         read <addr>");
            Console.WriteLine("            Reads a single byte from the specified address");
            Console.WriteLine("         write <addr> <data> [-noverify]");
            Console.WriteLine("            Writes a single byte to the specified address");
            Console.WriteLine("         file  <file_name> <starting_addr> [-noverify]");
            Console.WriteLine("            Writes an entire file of bytes starting at the specified address.");
            Console.WriteLine("            Bytes should be separated with a newline");
            Console.WriteLine("         dump  <addr> <length> <file_name>");
            Console.WriteLine("            Reads data starting from address into the specified file");
            Console.WriteLine("         music <audio_file.paf>");
            Console.WriteLine("            Plays music from a .paf audio file");
            Console.WriteLine("         music2 <audio_file.p2f>");
            Console.WriteLine("            Plays music from a .p2f audio file");
            Console.WriteLine("         program <program_file>");
            Console.WriteLine("            Program CPU from a file of assembled MIPS instructions");
            Console.WriteLine("         settings <setting_name> <value>");
            Console.WriteLine("            Changes one of the program settings below (default)");
            Console.WriteLine("            baud (115200), delay (104)");
            Console.WriteLine("         exit ");
            Console.WriteLine("            Exits MooseBox Serial Communicator");
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


