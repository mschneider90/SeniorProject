using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MooseBoxGame
{
    /// <summary>
    /// Represents an object that can be controlled by player input
    /// </summary>
    interface Inputable
    {
        void handleInput();
    }

    /// <summary>
    /// Represents an object that is controlled autonomously
    /// </summary>
    interface Updateable
    {
        void update();
    }

    /// <summary>
    /// Represents an object that can collide with other objects
    /// </summary>
    interface Collideable
    {
        void collide();
    }
}
