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
        enum gameStateEnum { LOADING, START_MENU, PLAYING, END_MENU };

        static gameStateEnum gameState;

        static MooseBoxUART uart;
        static MooseBoxKeyboard keyboard;
        static MooseBoxFrame framebuffer;

        static MooseBoxBackgroundAudio backgroundAudio;
        static Thread backgroundAudioThread;

        const uint FRAMEBUFFER = 0x20;
        const uint INIT_SCREEN = 0x8000;
        const uint LOADING_SCREEN = 0x1500;
        const uint MAIN_MENU = 0x4000;

        public static void Main()
        {
            try
            {
                initializeUART();
            }
            catch (IOException e)
            {
                Console.WriteLine("Failed to open serial port. Press enter to exit");
                Console.ReadLine();
                return;
            }

            // Setup the background audio thread
            backgroundAudio = new MooseBoxBackgroundAudio(uart, "audiotest9.p2f");
            backgroundAudioThread = new Thread(new ThreadStart(backgroundAudio.playAudio));
            backgroundAudioThread.Start();

            // Init the keyboard
            keyboard = new MooseBoxKeyboard(uart);

            // Init the framebuffer
            framebuffer = new MooseBoxFrame(uart);

            gameState = gameStateEnum.LOADING;
            while (true)
            {
                switch (gameState)
                {
                    case gameStateEnum.LOADING:
                        {
                            loadGameData();
                            gameState = gameStateEnum.START_MENU;
                            break;
                        }
                    case gameStateEnum.START_MENU:
                        {
                            displayStartMenu();
                            gameState = gameStateEnum.PLAYING;
                            break;
                        }
                    case gameStateEnum.PLAYING:
                        {
                            backgroundAudio.start();
                            break;
                        }
                    case gameStateEnum.END_MENU:
                        {
                            break;
                        }
                }
            } 

            // Cleanup
            uart.close();
            backgroundAudioThread.Abort();

            /*
            int line = 839;
            uint pos = 40;
            while (true)
            {
                // Clear previous position
                uart.write((int)(0x1050 + ((line + 40) * 80 + pos)), 0);

                if (line == 0)
                {
                    line = 839;
                }
                else
                {
                    line--;
                }
                uart.write(0x20, (0x1050 + (line * 80)));
                uint a = uart.read(0x12);
                uint d = uart.read(0x14);

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

                uart.write((uint)(0x1050 + ((line + 40) * 80 + pos)), (uint)(0xE0), false);

                Thread.Sleep(33);
            } */
        }

        /// <summary>
        /// Initializes UART object and opens the port
        /// </summary>
        static void initializeUART()
        {
            Console.WriteLine("                         MooseBoxGame Mk.I");
            Console.WriteLine("- > Enter the name of a serial port from the list below");

            string[] portNames = MooseBoxUART.getPorts();
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

            uart = new MooseBoxUART(portName);
            uart.open();
        }

        /// <summary>
        /// Loads game data while playing some music in the background
        /// </summary>
        static void loadGameData() 
        {
            Console.Write("- > Initializing, please wait...");

            // Put the screen in the pretty colors
            framebuffer.setFramePosition(INIT_SCREEN);

            // Load loading screen
            MooseBoxImage loadingScreen = new MooseBoxImage("loading.bmp");
            uart.write(LOADING_SCREEN, loadingScreen);
            Console.WriteLine("Done!");

            // Display loading screen and music while the rest loads
            framebuffer.setFramePosition(LOADING_SCREEN);
            backgroundAudio.start();

            // Load main screen
            Console.Write("- > Loading title screen...");
            MooseBoxImage titleScreen = new MooseBoxImage("title.bmp");
            uart.write(MAIN_MENU, titleScreen);
            Console.WriteLine("Done!");

            // Load background image
            Console.Write("- > Loading background image...");
            MooseBoxImage backgroundImage = new MooseBoxImage("star_background.bmp");
           // uart.write(0x6500, backgroundImage);
            Console.WriteLine("Done!");

            backgroundAudio.stop();
        }

        /// <summary>
        /// Displays the start menu until the user presses space
        /// </summary>
        static void displayStartMenu()
        {
            // Switch to title screen
            framebuffer.setFramePosition(MAIN_MENU);

            while (true)
            {
                // wait until the SPACE key is pressed
                if (keyboard.isKeyPressed(keyEnum.SPACE))
                {
                    break;
                }
            }
        }
    }
}


