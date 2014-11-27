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
        const uint INIT_SCREEN = 0xC000;
        const uint LOADING_SCREEN = 0x1500;
        const uint MAIN_MENU = 0x4000;
        const uint MAIN_MENU_2 = 0x7000;

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

            // Init the different modules
            backgroundAudio = new MooseBoxBackgroundAudio(uart, "audiotest9.p2f");
            keyboard = new MooseBoxKeyboard(uart);
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
            MooseBoxImage loadingScreen = new MooseBoxImage("loading.bmp", uart, LOADING_SCREEN);
            loadingScreen.write();
            Console.WriteLine("Done!");

            // Display loading screen and music while the rest loads
            framebuffer.setFramePosition(LOADING_SCREEN);
            backgroundAudio.start();

            // Load main screen
            Console.Write("- > Loading title screen...");
            MooseBoxImage titleScreen = new MooseBoxImage("space_title.bmp", uart, MAIN_MENU);
            titleScreen.write();

            MooseBoxImage titleScreen2 = new MooseBoxImage("space_title_2.bmp", uart, MAIN_MENU_2);
            titleScreen2.write();
            Console.WriteLine("Done!");

            // Load background image
            Console.Write("- > Loading background image...");
            MooseBoxImage backgroundImage = new MooseBoxImage("star_background.bmp", uart, 0x6500);
            backgroundImage.write();
            Console.WriteLine("Done!");

            backgroundAudio.stop();
        }

        /// <summary>
        /// Displays the start menu until the user presses space
        /// </summary>
        static void displayStartMenu()
        {
            backgroundAudio.start();
            // Switch to title screen
            framebuffer.setFramePosition(MAIN_MENU + 1);
            bool title2 = false;
            while (true)
            {
                // wait until the SPACE key is pressed
                if (keyboard.isKeyPressed(keyEnum.SPACE))
                {
                    break;
                }

                // Make the start text blink
                title2 = !title2;
                if (title2)
                {
                    framebuffer.setFramePosition(MAIN_MENU_2 + 1);
                }
                else
                {
                    framebuffer.setFramePosition(MAIN_MENU + 1);
                }

                Thread.Sleep(1000);
            }
            backgroundAudio.stop();
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
    }
}


