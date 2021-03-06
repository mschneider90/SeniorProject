﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MooseBoxGame
{
    /// <summary>
    /// Represents the player controlled ship
    /// </summary>
    class MooseBoxShip : MooseBoxSprite, Inputable, Updateable
    {
        const int START_X = 100;
        const int START_Y = 225;
        const uint SHIP_VELOCITY = 4;
        const String SHIP_BMP_PATH = "spaceship.bmp";

        // Limit the cyclic rate of the cannon
        const int CYCLIC_RATE = 10;
        int updateCounter;

        MooseBoxKeyboard kb;

        MooseBoxFireFX fire_sfx;

        /// <summary>
        /// Creates a new ship
        /// </summary>
        /// <param name="keyboard">The keyboard to read input from</param>
        /// 
        public MooseBoxShip(MooseBoxKeyboard keyboard, MooseBoxUART uartObj) : base(SHIP_BMP_PATH,
                                                              new MooseBoxPosition(START_X,START_Y),
                                                              SHIP_VELOCITY)
        {
            kb = keyboard;
            updateCounter = 0;

            fire_sfx = new MooseBoxFireFX(uartObj);
        }

        /// <summary>
        /// Handles the keyboard input by moving the ship left or right
        /// </summary>
        public void handleInput()
        {
            if (kb.isKeyPressed(Key.A)) // move left
            {
                if (position.x > 5)
                {
                    move(Direction.left);
                }
            }
            else if (kb.isKeyPressed(Key.D)) // move right
            {
                if (position.x < 320 - width - 70) // idk
                {
                    move(Direction.right);
                }
            }

            if (kb.isKeyPressed(Key.SPACE)) // fire a missle
            {
                if (updateCounter == 0)
                {
                    MooseBoxPosition misslePosition = new MooseBoxPosition(position.x + 5, position.y);
                    childSprites.Add(new MooseBoxMissle(misslePosition, childSprites));
                    fire_sfx.play();
                    updateCounter = 1;
                }
            }

            if (updateCounter != 0)
            {
                updateCounter++;
                if (updateCounter == CYCLIC_RATE)
                {
                    updateCounter = 0;
                }
            }
        }

        public void update()
        {
            foreach (MooseBoxSprite child in childSprites.ToList())
            {
                if (child is Updateable)
                {
                    ((Updateable)child).update();
                }
            }
        }
    }
}
