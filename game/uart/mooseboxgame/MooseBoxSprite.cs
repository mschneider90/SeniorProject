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
        MooseBoxPosition pos;

        public MooseBoxSprite(String bitMapPath,
                              MooseBoxPosition position) : base(bitMapPath)
        {
            pos = position;
        }

        public void move(Direction direction)
        {
            switch (direction)
            {
                case Direction.up:
                    {
                        pos.y -= 4;
                        break;
                    }
                case Direction.down:
                    {
                        pos.y += 4;
                        break;
                    }
                case Direction.right:
                    {
                        pos.x += 4;
                        break;
                    }
                case Direction.left:
                    {
                        pos.x -= 4;
                        break;
                    }
            }
        }

        public MooseBoxPosition position
        {
            get
            {
                return pos;
            }
        }
    }
}
