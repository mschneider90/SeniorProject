using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MooseBoxGame
{
    public enum Direction { up, down, right, left };

    /// <summary>
    /// Represents a dynamic sprite to be drawn on top of a background
    /// </summary>
    public class MooseBoxSprite : MooseBoxImage
    {
        // Hold child sprites of this sprite (e.g. missles)
        List<MooseBoxSprite> childSprites;

        MooseBoxPosition pos;
        uint velocity;

        /// <summary>
        /// Creates the sprite
        /// </summary>
        /// <param name="bitMapPath">The path to the bitmap file</param>
        /// <param name="position">The initial position of the sprite</param>
        /// <param name="pixPerMove">The speed at which to move the sprite</param>
        public MooseBoxSprite(String bitMapPath,
                              MooseBoxPosition position,
                              uint pixPerMove = 4) : base(bitMapPath)
        {
            pos = position;
            velocity = pixPerMove;

            childSprites = new List<MooseBoxSprite>();
        }

        /// <summary>
        /// Moves the sprite
        /// </summary>
        /// <param name="direction">The direction to move</param>
        public void move(Direction direction)
        {
            switch (direction)
            {
                case Direction.up:
                    {
                        pos.y -= (int)velocity;
                        break;
                    }
                case Direction.down:
                    {
                        pos.y += (int)velocity;
                        break;
                    }
                case Direction.right:
                    {
                        pos.x += (int)velocity;
                        break;
                    }
                case Direction.left:
                    {
                        pos.x -= (int)velocity;
                        break;
                    }
            }
        }

        /// <summary>
        /// Gets the position of the sprite
        /// </summary>
        public MooseBoxPosition position
        {
            get
            {
                return pos;
            }
        }

        /// <summary>
        /// Get the list of child sprites
        /// </summary>
        public List<MooseBoxSprite> children
        {
            get
            {
                return childSprites;
            }
        }
    }
}
