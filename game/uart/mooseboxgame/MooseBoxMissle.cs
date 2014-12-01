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
        /// <summary>
        /// Creates a missle at the specified position
        /// </summary>
        public MooseBoxMissle(MooseBoxPosition position) : base("missle.bmp", position)
        {

        }

        /// <summary>
        /// Updates the missle position
        /// </summary>
        public void update()
        {

        }

        /// <summary>
        /// Explodes the missle
        /// </summary>
        public void collide()
        {

        }
    }
}
