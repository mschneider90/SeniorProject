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
        protected MooseBoxUART uart;

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

    public class MooseBoxFireFX : MooseBoxSoundFX
    {
        public MooseBoxFireFX(MooseBoxUART uartObj) : base(uartObj)
        {

        }

        public override void play()
        {
            uart.write(3, 0x0278);
            uart.write(2, 0x0b81);
        }
    }

    public class MooseBoxHitFX : MooseBoxSoundFX
    {
        public MooseBoxHitFX(MooseBoxUART uartObj)
            : base(uartObj)
        {

        }

        public override void play()
        {
            uart.write(7, 0x0000);
            uart.write(6, 0xac9);
        }
    }

    public class MooseBoxMissFX : MooseBoxSoundFX
    {
        public MooseBoxMissFX(MooseBoxUART uartObj)
            : base(uartObj)
        {

        }

        public override void play()
        {
            uart.write(3, 0x0000);
            uart.write(2, 0xbc9);
        }
    }
}
