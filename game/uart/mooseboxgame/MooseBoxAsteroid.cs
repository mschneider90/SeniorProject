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

        List<MooseBoxSprite> sprites;

        /// <summary>
        /// Create the asteroid at the specified position
        /// </summary>
        /// <param name="position">The initial position of the sprite</param>
        /// <param name="spriteList">The list of sprites which contains this asteroid</param>
        public MooseBoxAsteroid(MooseBoxPosition position,
                                List<MooseBoxSprite> spriteList) : base("asteroid.bmp", position, ASTEROID_SPEED)
        {
            sprites = spriteList;
        }

        /// <summary>
        /// Update the asteroid position
        /// </summary>
        public void update()
        {
            move(Direction.down);
            if (position.y > 220)
            {
                collide();
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
        }
    }
}
