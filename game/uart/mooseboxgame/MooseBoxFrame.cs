using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;

namespace MooseBoxGame
{
    /// <summary>
    /// Represents the framebuffer position
    /// </summary>
    public class MooseBoxFrame
    {
        MooseBoxUART uart;
        MooseBoxBackgroundImage background;

        List<MooseBoxPixel> pixels;

        const int TRANSPARENT_R = (int)(0xFF);
        const int TRANSPARENT_G = (int)(0x00);
        const int TRANSPARENT_B = (int)(0xDC);
        Color TRANSPARENT = Color.FromArgb(TRANSPARENT_R, TRANSPARENT_G, TRANSPARENT_B); // hot pink
        const uint FRAMEBUFFER_ADDR = 0x20;

        uint framePos;
        uint backgroundScrollLine;

        /// <summary>
        /// Constructs the framebuffer object
        /// </summary>
        /// <param name="uartObj">The UART object</param>
        /// <param name="initialAddr">The initial frame position</param>
        public MooseBoxFrame(MooseBoxUART uartObj, uint initialAddr = 0)
        {
            uart = uartObj;
            framePos = initialAddr;
            backgroundScrollLine = 0;
        }

        /// <summary>
        /// Sets the background image for the frame
        /// </summary>
        /// <param name="backgroundImage"></param>
        public void setBackground(MooseBoxBackgroundImage backgroundImage)
        {
            background = backgroundImage;
            setFramePosition(background.address);
        }

        /// <summary>
        /// Draws the sprite to the framebuffer in memory on the host side, to be written later
        /// </summary>
        /// <param name="sprite">The sprite to draw</param>
        public void draw(MooseBoxSprite sprite)
        {
            // add non-transparent pixels to a list
            for (int y = 0; y < sprite.height; y++)
            {
                for (int x = 0; x < sprite.width; x++)
                {
                    Color pix24 = sprite.getPixel24(x, y);
                    if (!pix24.Equals(TRANSPARENT) )
                    {
                        byte pix8MSB = 0;
                        byte pix8LSB = 0;
                        uint pixAddr = 0;

                        if (x % 2 == 0) // word aligned
                        {
                            pixAddr = (uint)(y * sprite.width + x); // TODO
                            pix8MSB = sprite.getPixel8(x,y);

                            // Also need to check the next pixel since we pack two pixels together
                            pix24 = sprite.getPixel24(x + 1, y);
                            if (pix24.Equals(TRANSPARENT))
                            {
                                pix8LSB = background.getPixel8(x + 1, y);
                            }
                            else
                            {
                                pix8LSB = sprite.getPixel8(x + 1, y);
                            }
                            x++; // Now we can skip the next pixel
                        }
                        else // not word aligned
                        {
                            // We can assume that this pixel was transparent, otherwise we would have skipped it
                            pix8MSB = background.getPixel8(x-1, y);
                            pix8LSB = sprite.getPixel8(x, y);

                            // Subtract 1 since the pixel address must be word aligned
                            pixAddr = (uint)( y * sprite.width + x - 1); // TODO
                        }

                        pixels.Add(new MooseBoxPixel(uart, pix8MSB, pix8LSB, pixAddr));
                    }
                }
            }
        }

        /// <summary>
        /// Writes the contents of the current framebuffer
        /// </summary>
        public void write()
        {
            setFramePosition((uint)(background.address + backgroundScrollLine * background.width / 2));
            // write list of pixels to the screen
            foreach (MooseBoxPixel pix in pixels)
            {
                pix.write();
            }
        }

        /// <summary>
        /// 
        /// </summary>
        public void clear()
        {
            // clear written pixels by writing over them with the background image
            foreach (MooseBoxPixel pix in pixels)
            {
                // Get the address of the pixel wrt the background
                int pixelAddr = (int)(pix.addr - background.address);

                // Create a new pixel that has the address of the current pixel but with the color of the background
                MooseBoxPixel pix_background = new MooseBoxPixel(uart,
                                                                 background.getPixel8(pixelAddr),
                                                                 background.getPixel8(pixelAddr + 1),
                                                                 pix.addr);
                pix_background.write();
            }
            pixels.Clear();
        }

        public void scrollBackground(int lines)
        {
            if (lines > 0) //scroll down
            {
                if (backgroundScrollLine + lines > background.height)
                {
                    backgroundScrollLine += (uint)lines;
                }
                else
                {
                    backgroundScrollLine = 0;
                }
            }
            else //scroll up
            {
                if (backgroundScrollLine - lines > 0)
                {
                    backgroundScrollLine -= (uint)lines;
                }
                else
                {
                    backgroundScrollLine = (uint)background.height;
                }
            }
        }

        /// <summary>
        /// Sets the frame position
        /// </summary>
        /// <param name="addr">The address to set the framebuffer to</param>
        public void setFramePosition(uint addr)
        {
            framePos = addr + 8; // Align the screen correctly
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
