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
        /// <summary>
        /// Create the asteroid at the specified position
        /// </summary>
        public MooseBoxAsteroid() : base("asteroid.bmp", new MooseBoxPosition(0,0))
        {

        }

        /// <summary>
        /// Update the asteroid position
        /// </summary>
        public void update()
        {

        }

        /// <summary>
        /// Explode the asteroid
        /// </summary>
        public void collide()
        {

        }
    }
}
