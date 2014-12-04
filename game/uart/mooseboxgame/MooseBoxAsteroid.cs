using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MooseBoxGame
{
    /// <summary>
    /// Represents an asteroid
    /// </summary>
    public class MooseBoxAsteroid : MooseBoxSprite, Updateable, Collideable
    {
        const int ASTEROID_SPEED = 4;

        const string ASTEROID_BMP_PATH = "asteroid.bmp";

        List<MooseBoxSprite> sprites;

        MooseBoxSoundFX sfx;
        MooseBoxHitFX hit_sfx;
        MooseBoxMissFX miss_sfx;

        /// <summary>
        /// Create the asteroid at the specified position
        /// </summary>
        /// <param name="position">The initial position of the sprite</param>
        /// <param name="uartObj">The UART to write sound effects to</param>
        /// <param name="spriteList">The list of sprites which contains this asteroid</param>
        public MooseBoxAsteroid(MooseBoxPosition position,
                                MooseBoxUART uartObj,
                                List<MooseBoxSprite> spriteList) : base(ASTEROID_BMP_PATH, position, ASTEROID_SPEED)
        {
            sprites = spriteList;
            hit_sfx = new MooseBoxHitFX(uartObj);
            miss_sfx = new MooseBoxMissFX(uartObj);
            sfx = hit_sfx;
        }

        /// <summary>
        /// Update the asteroid position
        /// </summary>
        public void update()
        {
            move(Direction.down);
            if (position.y > 220)
            {
                sfx = miss_sfx;
                collide();
                sfx = hit_sfx;
            }
        }

        /// <summary>
        /// Explode the asteroid
        /// </summary>
        public void collide()
        {
            foreach (MooseBoxSprite sprite in sprites.ToList())
            {
                if (sprite == this)
                {
                    sprites.Remove(this);
                }
            }

            sfx.play();
        }
    }
}
