using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MooseBoxGame
{
    /// <summary>
    /// Represents a sound effect (plays only once)
    /// </summary>
    public abstract class MooseBoxSoundFX
    {
        MooseBoxUART uart;

        /// <summary>
        /// Creates the sound effect
        /// </summary>
        /// <param name="uartObj">The UART to write to</param>
        public MooseBoxSoundFX(MooseBoxUART uartObj)
        {
            uart = uartObj;
        }

        /// <summary>
        /// Plays the sound effect
        /// </summary>
        public abstract void play();
    }
}
