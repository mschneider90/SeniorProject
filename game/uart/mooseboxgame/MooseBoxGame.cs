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
        static MooseBoxFrame framebuffer_1;
        static MooseBoxFrame framebuffer_2;

        static MooseBoxBackgroundAudio backgroundAudio;

        // Images
        static MooseBoxBackgroundImage loadingScreen;
        static MooseBoxBackgroundImage titleScreen;
        static MooseBoxBackgroundImage titleScreen2;
        static MooseBoxBackgroundImage backgroundImage_1;
        static MooseBoxBackgroundImage backgroundImage_2;

        // Points to the next available memory
        static uint freeMemoryPointer;

        // The beginning of the main memory space
        const uint MEMORY_START = 0x1050;

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

            // Init the background threads
            backgroundAudio = new MooseBoxBackgroundAudio(uart, "audiotest9.p2f");
            keyboard = new MooseBoxKeyboard(uart);
            framebuffer_1 = new MooseBoxFrame(uart, MEMORY_START);
            framebuffer_2 = new MooseBoxFrame(uart, MEMORY_START);

            // Init free memory pointer
            freeMemoryPointer = MEMORY_START;

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

            framebuffer_1.setBackground(backgroundImage_1);
            framebuffer_2.setBackground(backgroundImage_2);
            //framebuffer_2.scrollBackground(-8);
            MooseBoxSprite sprite = new MooseBoxSprite("test_sprite.bmp", new MooseBoxPosition(100, 100));
            bool framebuffer_sel = true;
            while (true)
            {
                // Clear the screen
                if (framebuffer_sel)
                {
                    framebuffer_1.clear();
                }
                else
                {
                    framebuffer_2.clear();
                }

                // Update the sprite position based on player input
                if (keyboard.isKeyPressed(Key.A))
                {
                    if (sprite.position.x > 0)
                    {
                        sprite.move(Direction.left);
                    }
                }
                else if (keyboard.isKeyPressed(Key.D))
                {
                    if (sprite.position.x < 320 - sprite.width - 20)
                    {
                        sprite.move(Direction.right);
                    }
                }

                // Draw the frame
                if (framebuffer_sel)
                {
                    //framebuffer_1.scrollBackground(-8);
                    framebuffer_1.draw(sprite);
                    framebuffer_1.write(); // Write the other framebuffer
                    framebuffer_1.showFrame();
                }
                else
                {
                    //framebuffer_2.scrollBackground(-8);
                    framebuffer_2.draw(sprite);
                    framebuffer_2.write(); // Write the other framebuffer
                    framebuffer_2.showFrame();
                }

                framebuffer_sel = !framebuffer_sel;
                Thread.Sleep(15);

                //Console.ReadLine()
            }
        }

        /// <summary>
        /// Loads game data while playing some music in the background
        /// </summary>
        static void loadGameData() 
        {
            Console.Write("- > Load image data (y/n)? ");
            String input = Console.ReadLine();
            bool load = false;
            if (input.Equals("y"))
            {
                load = true;
            }

            // Load loading screen
            Console.Write("- > Initializing, please wait...");
            loadingScreen = new MooseBoxBackgroundImage(uart, "loading.bmp", freeMemoryPointer);
            if (load)
            {
                loadingScreen.write();
            }
            freeMemoryPointer += loadingScreen.size;
            Console.WriteLine("Done!");

            // Display loading screen and music while the rest loads
            framebuffer_1.setBackground(loadingScreen);
            backgroundAudio.start();

            // Load main screen
            Console.Write("- > Loading title screen...");
            titleScreen = new MooseBoxBackgroundImage(uart, "SPACEDEMO2.bmp", freeMemoryPointer);
            freeMemoryPointer += titleScreen.size;
            if (load)
            {
                titleScreen.write();
            }

            titleScreen2 = new MooseBoxBackgroundImage(uart, "SPACEDEMO3.bmp", freeMemoryPointer);
            if (load)
            {
                titleScreen2.write();
            }
            freeMemoryPointer += titleScreen.size;
            Console.WriteLine("Done!"); 

            // Load background image
            Console.Write("- > Loading background image...");
            backgroundImage_1 = new MooseBoxBackgroundImage(uart, "starry_background_short.bmp", freeMemoryPointer);
            if (load)
            {
                backgroundImage_1.write();
            }
            freeMemoryPointer += backgroundImage_1.size;

            backgroundImage_2 = new MooseBoxBackgroundImage(uart, "starry_background_short.bmp", freeMemoryPointer);
            if (load)
            {
                backgroundImage_2.write();
            }
            freeMemoryPointer += backgroundImage_2.size;
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
            framebuffer_1.setBackground(titleScreen);
            bool title2 = false;
            while (true)
            {
                // wait until the SPACE key is pressed
                if (keyboard.isKeyPressed(Key.SPACE))
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
                    framebuffer_1.setBackground(titleScreen2);
                }
                else
                {
                    framebuffer_1.setBackground(titleScreen);
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


