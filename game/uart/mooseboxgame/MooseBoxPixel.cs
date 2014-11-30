using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MooseBoxGame
{
    /// <summary>
    /// Represents one "pixel", which is a 16 bit value that contains two 8 bit pixels
    /// </summary>
    public class MooseBoxPixel
    {
        MooseBoxUART uart;

        ushort pix_color;
        uint pix_addr;

        /// <summary>
        /// Create a new pixel 
        /// </summary>
        /// <param name="pixelColorMSB">The most significant byte of the pixel</param>
        /// <param name="pixelColorLSB">The least significant byte of the pixel</param>
        /// <param name="pixelAddr">The pixel address</param>
        public MooseBoxPixel(MooseBoxUART uartObj, byte pixelColorMSB, byte pixelColorLSB, uint pixelAddr)
        {
            uart = uartObj;
            pix_color = (ushort)((pixelColorMSB << 8) + pixelColorLSB);
            pix_addr = pixelAddr;
        }

        /// <summary>
        /// Write the pixel to the screen
        /// </summary>
        public void write()
        {
            uart.write(pix_addr, pix_color);
        }

        /// <summary>
        /// Get the color of the pixel
        /// </summary>
        public ushort color
        {
            get
            {
                return pix_color;
            }
        }

        /// <summary>
        /// Get the address of the pixel
        /// </summary>
        public uint addr
        {
            get
            {
                return pix_addr;
            }
        }
    }
}
