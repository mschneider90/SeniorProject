using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MooseBoxGame
{
    /// <summary>
    /// Represents a static background image
    /// </summary>
    public class MooseBoxBackgroundImage : MooseBoxImage
    {
        MooseBoxUART uart;
        uint addr;

        /// <summary>
        /// Creates a backgroundImage
        /// </summary>
        /// <param name="uartObj">The UART object</param>
        /// <param name="bitMapPath">The path of the bitmap file</param>
        /// <param name="startingAddr">The address of the image in memory</param>
        public MooseBoxBackgroundImage(MooseBoxUART uartObj, String bitMapPath, uint startingAddr)
            : base(bitMapPath)
        {
            uart = uartObj;
            addr = startingAddr;
        }

        /// <summary>
        /// Writes the background image to memory
        /// </summary>
        public void write()
        {
            uart.write(addr, this.getRGB());
        }

        public uint address
        {
            get
            {
                return addr;
            }
        }
    }
}
