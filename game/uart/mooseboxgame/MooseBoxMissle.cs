using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MooseBoxGame
{
    /// <summary>
    /// Represents a missle shot by the Player Ship
    /// </summary>
    public class MooseBoxMissle : MooseBoxSprite, Updateable, Collideable
    {
        const String MISSLE_BMP_PATH = "missle.bmp";
        const int MISSLE_SPEED = 6;

        List<MooseBoxSprite> sprites;

        /// <summary>
        /// Creates a missle at the specified position
        /// </summary>
        /// <param name="position">The initial position of the missle</param>
        /// <param name="spriteList">The child sprite list which contains this missle</param>
        public MooseBoxMissle(MooseBoxPosition position,
                              List<MooseBoxSprite> spriteList) : base(MISSLE_BMP_PATH, position, MISSLE_SPEED)
        {
            sprites = spriteList;
        }

        /// <summary>
        /// Updates the missle position
        /// </summary>
        public void update()
        {
            move(Direction.up);
            if (position.y < 0)
            {
                collide();
            }
        }

        /// <summary>
        /// Explodes the missle
        /// </summary>
        public void collide()
        {
            foreach (MooseBoxSprite sprite in sprites)
            {
                if (sprite == this)
                {
                    sprites.Remove(this);
                    return;
                }
            }
        }
    }
}
