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

        // Images
        static MooseBoxBackgroundImage loadingScreen;
        static MooseBoxBackgroundImage titleScreen;
        static MooseBoxBackgroundImage titleScreen2;
        static MooseBoxBackgroundImage backgroundImage;

        // Points to the next available memory
        static uint freeMemoryPointer;

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

            // Init free memory pointer
            freeMemoryPointer = 0x1050;

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
                            playGame();
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
        /// Plays the game
        /// </summary>
        static void playGame()
        {
            backgroundAudio.start();

            framebuffer.setBackground(backgroundImage);
            MooseBoxSprite sprite = new MooseBoxSprite(uart, "test_sprite.bmp", 0, 0); // TODO
            while (true)
            {
                framebuffer.clear();
                framebuffer.scrollBackground(-8);
                framebuffer.draw(sprite);
                framebuffer.write();
                Thread.Sleep(33);
            }
        }

        /// <summary>
        /// Loads game data while playing some music in the background
        /// </summary>
        static void loadGameData() 
        {
            Console.Write("- > Initializing, please wait...");

            // Put the screen in the pretty colors
            const int INIT_SPACE = 0x1050;
            framebuffer.setFramePosition(INIT_SPACE);

            Console.Write("- > Load image data? (y/n)");
            String input = Console.ReadLine();
            if (input.Equals("n"))
            {
                return;
            }

            // Load loading screen
            loadingScreen = new MooseBoxBackgroundImage(uart, "loading.bmp", freeMemoryPointer);
            loadingScreen.write();
            freeMemoryPointer += loadingScreen.size;
            Console.WriteLine("Done!");

            // Display loading screen and music while the rest loads
            framebuffer.setBackground(loadingScreen);
            backgroundAudio.start();

            // Load main screen
            Console.Write("- > Loading title screen...");
            titleScreen = new MooseBoxBackgroundImage(uart, "SPACEDEMO2.bmp", freeMemoryPointer);
            freeMemoryPointer += titleScreen.size;
            titleScreen.write();

            titleScreen2 = new MooseBoxBackgroundImage(uart, "SPACEDEMO3.bmp", freeMemoryPointer);
            titleScreen2.write();
            freeMemoryPointer += titleScreen.size;
            Console.WriteLine("Done!"); 

            // Load background image
            Console.Write("- > Loading background image...");
            backgroundImage = new MooseBoxBackgroundImage(uart, "starry_background.bmp", freeMemoryPointer);
            backgroundImage.write();
            freeMemoryPointer += backgroundImage.size;
            Console.WriteLine("Done!");
            
            backgroundAudio.stop();
        }

        /// <summary>
        /// Displays the start menu until the user presses space
        /// </summary>
        static void displayStartMenu()
        {
            int menuTimeOut = 0;
            backgroundAudio.start();

            // Switch to title screen
            framebuffer.setBackground(titleScreen);
            bool title2 = false;
            while (true)
            {
                // wait until the SPACE key is pressed
                if (keyboard.isKeyPressed(keyEnum.SPACE))
                {
                    break;
                }
                // or until timeout
                if (menuTimeOut == 20)
                {
                    break;
                }

                // Make the start text blink
                title2 = !title2;
                if (title2)
                {
                    framebuffer.setBackground(titleScreen2);
                }
                else
                {
                    framebuffer.setBackground(titleScreen);
                }

                menuTimeOut++;
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


