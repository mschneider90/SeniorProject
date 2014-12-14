using System;
using System.IO;
using System.IO.Ports;
using System.Globalization;
using System.Security;
using System.Threading;
using System.Linq;
using System.Collections.Generic;

namespace MooseBoxGame
{
    class MooseBoxGame
    {
        const String LOADING_SCREEN = "loading.bmp";
        const String MAIN_MENU_A = "space_title_a.bmp";
        const String MAIN_MENU_B = "space_title_b.bmp";
        const String BACKGROUND = "starry_background_short.bmp";
        const String MAIN_MENU_SONG = "main_menu_song.paf";
        const String GAME_SONG = "game_song.p2f";

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

        // Frame limiter
        //Stopwatch timer;

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
            backgroundAudio = new MooseBoxBackgroundAudio(uart, "main_menu_song.paf");
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
                            gameState = gameStateEnum.START_MENU;
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
            backgroundAudio.loadSong(GAME_SONG);
            backgroundAudio.start();

            // Double buffer
            framebuffer[0].setBackground(backgroundImage_1);
            framebuffer[1].setBackground(backgroundImage_2);
            framebuffer[1].scrollBackground(-1); // Offset the second framebuffer to make scrolling smoother
            int framebuffer_sel = 0;

            // Random number generator for the asteroid position
            Random rand = new Random();

            // Go back to the main menu after 30 asteroids
            const int MAX_ASTEROIDS = 30;
            int asteroidCount = 0;

            // Holds all of the game objects for the purposes of collision detection
            List<MooseBoxSprite> gameObjects = new List<MooseBoxSprite>();

            // Instantiate the game objects
            MooseBoxShip playerShip = new MooseBoxShip(keyboard, uart);
            gameObjects.Add(playerShip);

            MooseBoxAsteroid asteroid = new MooseBoxAsteroid(new MooseBoxPosition(100, 20), uart, gameObjects);
            gameObjects.Add(asteroid);

            while (true)
            {
                // Exit after 30 asteroids
                if (asteroidCount == MAX_ASTEROIDS)
                {
                    framebuffer[0].clear();
                    framebuffer[1].clear();
                    break;
                }

                // Clear the screen
                framebuffer[framebuffer_sel].clear();

                // Add an asteroid if one isn't already active
                if (!gameObjects.Contains(asteroid))
                {
                    asteroid = new MooseBoxAsteroid(new MooseBoxPosition(rand.Next(40, 180), 10), uart, gameObjects);
                    gameObjects.Add(asteroid);
                    asteroidCount++;
                }

                // Update the the game objects
                foreach (MooseBoxSprite sprite in gameObjects.ToList())
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
                        foreach (MooseBoxSprite other in gameObjects.ToList())
                        {
                            if (other != null && other != sprite) // deleted by previous collision
                            {
                                detectCollision(sprite, other);
                            }
                        }
                    }
                }

                // Draw the frame
                framebuffer[framebuffer_sel].scrollBackground(-2);
                foreach (MooseBoxSprite sprite in gameObjects)
                {
                    framebuffer[framebuffer_sel].draw(sprite);
                }
                framebuffer[framebuffer_sel].write(); 
                framebuffer[framebuffer_sel].showFrame();

                // Switch the framebuffer
                framebuffer_sel = (framebuffer_sel == 0) ? 1 : 0;
                //Thread.Sleep(6);
            }

            backgroundAudio.stop();
        }

        static bool detectCollision(MooseBoxSprite sprite_1, MooseBoxSprite sprite_2)
        {
            if (!(sprite_1 is Collideable))
            {
                return false;
            }
            if (sprite_2 is Collideable)
            {
                if (Math.Abs(sprite_1.position.x - sprite_2.position.x) <= sprite_1.width)
                {
                    if (Math.Abs(sprite_1.position.y - sprite_2.position.y) <= sprite_1.height)
                    {
                        ((Collideable)sprite_1).collide();
                        ((Collideable)sprite_2).collide();
                        return true;
                    }
                }
            }
            foreach (MooseBoxSprite child in sprite_2.children.ToList())
            {
                if (detectCollision(sprite_1, child))
                {
                    return true;
                }
            }
            return false;
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
            loadingScreen = new MooseBoxBackgroundImage(uart, LOADING_SCREEN, freeMemoryPointer);
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
            titleScreen = new MooseBoxBackgroundImage(uart, MAIN_MENU_A, freeMemoryPointer);
            freeMemoryPointer += titleScreen.size;
            if (load)
            {
                titleScreen.write();
            }

            titleScreen2 = new MooseBoxBackgroundImage(uart, MAIN_MENU_B, freeMemoryPointer);
            if (load)
            {
                titleScreen2.write();
            }
            freeMemoryPointer += titleScreen.size;
            Console.WriteLine("Done!"); 

            // Load background image
            Console.Write("- > Loading background image...");
            backgroundImage_1 = new MooseBoxBackgroundImage(uart, BACKGROUND, freeMemoryPointer);
            if (load)
            {
                backgroundImage_1.write();
            }
            freeMemoryPointer += backgroundImage_1.size;

            backgroundImage_2 = new MooseBoxBackgroundImage(uart, BACKGROUND, freeMemoryPointer);
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
            backgroundAudio.loadSong(MAIN_MENU_SONG);
            backgroundAudio.start();

            // Blink the PLAYER START text
            int playerStartCount = 0;

            // Switch to title screen
            framebuffer[0].setBackground(titleScreen);
            bool title2 = false;
            while (true)
            {
                // wait until the SPACE key is pressed
                if (keyboard.isKeyPressed(Key.ENTER))
                {
                    break;
                }
                // or until timeout
                if (menuTimeOut == 400)
                {
                    //break;
                }

                // Make the start text blink
                if (playerStartCount % 20 == 0)
                {
                    title2 = !title2;
                }
                if (title2)
                {
                    framebuffer[0].setBackground(titleScreen2);
                }
                else
                {
                    framebuffer[0].setBackground(titleScreen);
                }

                playerStartCount++;
                menuTimeOut++;
                Thread.Sleep(50);
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


