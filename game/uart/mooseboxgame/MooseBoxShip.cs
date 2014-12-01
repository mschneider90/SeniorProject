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
        const int START_Y = 220;
        const uint SHIP_VELOCITY = 8;
        const String SHIP_BMP_PATH = "test_sprite.bmp";

        MooseBoxKeyboard kb;

        /// <summary>
        /// Creates a new ship
        /// </summary>
        /// <param name="keyboard">The keyboard to read input from</param>
        public MooseBoxShip(MooseBoxKeyboard keyboard) : base(SHIP_BMP_PATH,
                                                              new MooseBoxPosition(START_X,START_Y),
                                                              SHIP_VELOCITY)
        {
            kb = keyboard;
        }

        /// <summary>
        /// Handles the keyboard input by moving the ship left or right
        /// </summary>
        public void handleInput()
        {
            if (kb.isKeyPressed(Key.A)) // move left
            {
                if (position.x > 0)
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

            if (kb.isKeyPressed(Key.ENTER)) // fire a missle
            {
                childSprites.Add(new MooseBoxMissle(position, childSprites));
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
