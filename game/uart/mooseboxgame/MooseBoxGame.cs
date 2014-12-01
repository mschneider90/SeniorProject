using System;
using System.IO;
using System.IO.Ports;
using System.Globalization;
using System.Security;
using System.Threading;
using System.Collections.Generic;

namespace MooseBoxGame
{
    class MooseBoxGame
    {
        enum gameStateEnum { LOADING, START_MENU, PLAYING, END_MENU };

        static gameStateEnum gameState;

        static MooseBoxUART uart;
        static MooseBoxKeyboard keyboard;
        static MooseBoxFrame[] framebuffer;

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
            backgroundAudio = new MooseBoxBackgroundAudio(uart, "audiotest8.paf");
            keyboard = new MooseBoxKeyboard(uart);

            // Double buffer intitialization
            framebuffer = new MooseBoxFrame[2];
            framebuffer[0] = new MooseBoxFrame(uart, MEMORY_START);
            framebuffer[1] = new MooseBoxFrame(uart, MEMORY_START);

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
            // Play combat music
            backgroundAudio.loadSong("audiotest9.p2f");
            backgroundAudio.start();

            // Double buffer
            framebuffer[0].setBackground(backgroundImage_1);
            framebuffer[1].setBackground(backgroundImage_2);
            framebuffer[1].scrollBackground(-4); // Offset the second framebuffer to make scrolling smoother
            int framebuffer_sel = 0;

            // Holds all of the game objects for the purposes of collision detection
            List<MooseBoxSprite> gameObjects = new List<MooseBoxSprite>();

            // Instantiate the game objects
            MooseBoxShip playerShip = new MooseBoxShip(keyboard);
            gameObjects.Add(playerShip);

            MooseBoxAsteroid asteroid = new MooseBoxAsteroid(new MooseBoxPosition(100, 20), gameObjects);
            gameObjects.Add(asteroid);

            while (true)
            {
                // Clear the screen
                framebuffer[framebuffer_sel].clear();

                // Add an asteroid if one isn't already active
                if (!gameObjects.Contains(asteroid))
                {
                    asteroid = new MooseBoxAsteroid(new MooseBoxPosition(100, 20), gameObjects);
                    gameObjects.Add(asteroid);
                }

                // Update the the game objects
                foreach (MooseBoxSprite sprite in gameObjects)
                {
                    if (sprite is Inputable)
                    {
                        ((Inputable)sprite).handleInput();
                    }
                    if (sprite is Updateable)
                    {
                        ((Updateable)sprite).update();
                    }
                    if (sprite is Collideable)
                    {
                        // collision detection goes here
                    }
                }

                // Draw the frame
                framebuffer[framebuffer_sel].scrollBackground(-8);
                foreach (MooseBoxSprite sprite in gameObjects)
                {
                    framebuffer[framebuffer_sel].draw(sprite);
                }
                framebuffer[framebuffer_sel].write(); 
                framebuffer[framebuffer_sel].showFrame();

                // Switch the framebuffer
                framebuffer_sel = (framebuffer_sel == 0) ? 1 : 0;
                Thread.Sleep(5);
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
            framebuffer[0].setBackground(loadingScreen);
            //backgroundAudio.start();

            // Load main screen
            Console.Write("- > Loading title screen...");
            titleScreen = new MooseBoxBackgroundImage(uart, "space5.bmp", freeMemoryPointer);
            freeMemoryPointer += titleScreen.size;
            if (load)
            {
                titleScreen.write();
            }

            titleScreen2 = new MooseBoxBackgroundImage(uart, "space5b.bmp", freeMemoryPointer);
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
            framebuffer[0].setBackground(titleScreen);
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
                    framebuffer[0].setBackground(titleScreen2);
                }
                else
                {
                    framebuffer[0].setBackground(titleScreen);
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

            // Initialize by doing some writes in case the program left the UART hardware in a bad state
            bool initialized = false;
            while (!initialized)
            {
                try
                {
                    uart.write(1050, 0);
                    initialized = true;
                }
                catch (TimeoutException e)
                {
                    initialized = false;
                }
            }
        }
    }
}


