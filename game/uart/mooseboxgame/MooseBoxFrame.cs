using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MooseBoxGame
{
    /// <summary>
    /// Represents the framebuffer position
    /// </summary>
    public class MooseBoxFrame
    {
        MooseBoxUART uart;
        const uint FRAMEBUFFER_ADDR = 0x20;
        uint framePos;

        /// <summary>
        /// Constructs the framebuffer object
        /// </summary>
        /// <param name="uartObj">The UART object</param>
        public MooseBoxFrame(MooseBoxUART uartObj, uint initialAddr = 0)
        {
            uart = uartObj;
            framePos = initialAddr;
        }

        /// <summary>
        /// Sets the frame position
        /// </summary>
        /// <param name="addr">The address to set the framebuffer to</param>
        public void setFramePosition(uint addr)
        {
            framePos = addr;
            uart.write(FRAMEBUFFER_ADDR, framePos);
        }

        /// <summary>
        /// Gets the frame position
        /// </summary>
        /// <returns>The address of the frame position</returns>
        public uint getFramePosition()
        {
            return framePos;
        }
    }
}
