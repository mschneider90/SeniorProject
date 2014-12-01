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
        const uint SCREEN_WIDTH = 320;
        const uint SCREEN_HEIGHT = 240;

        uint framePos;
        uint backgroundScrollLine;

        /// <summary>
        /// Constructs the framebuffer object from a memory address
        /// </summary>
        /// <param name="uartObj">The UART object</param>
        /// <param name="frameAddress">The address in memory from which to display the frame</param>
        public MooseBoxFrame(MooseBoxUART uartObj, uint frameAddress)
        {
            uart = uartObj;
            setFramePosition(frameAddress);
            backgroundScrollLine = 0;

            pixels = new List<MooseBoxPixel>();
        }

        /// <summary>
        /// Constructs the framebuffer object from a background image
        /// </summary>
        /// <param name="uartObj">The UART object</param>
        /// <param name="backgroundImage">The background image</param>
        public MooseBoxFrame(MooseBoxUART uartObj, MooseBoxBackgroundImage backgroundImage)
        {
            uart = uartObj;
            setFramePosition(backgroundImage.address);
            backgroundScrollLine = 0;

            pixels = new List<MooseBoxPixel>();
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

                        // Pixel address = base address of the frame + 
                        //                 base address of the sprite +
                        //                 address of the pixel within the sprite
                        uint pixAddr = (uint)(framePos +
                                       (sprite.position.y * background.width / 2) + sprite.position.x / 2 +
                                       (y * background.width / 2) + x / 2); 
                        
                        if (x % 2 == 0) // word aligned
                        {
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
                            //Console.WriteLine("Calculated pixel address {0} for pixel {1},{2}", pixAddr, x, y);
                            x++; // Now we can skip the next pixel
                        }
                        else // not word aligned
                        {
                            // We can assume that this pixel was transparent, otherwise we would have skipped it
                            pix8MSB = background.getPixel8(x-1, y);
                            pix8LSB = sprite.getPixel8(x, y);

                            //Console.WriteLine("Calculated pixel address {0} for pixel {1},{2}", pixAddr, x, y);
                        }
                        pixels.Add(new MooseBoxPixel(uart, pix8MSB, pix8LSB, pixAddr));
                    }
                    else
                    {
                        // Console.WriteLine("Found transparent pixel {0},{1}", x, y);
                    }
                }
            }

            // Draw the sprite's child sprites
            List<MooseBoxSprite> childSprites = sprite.children;
            foreach (MooseBoxSprite child in childSprites)
            {
                draw(child);
            }
        }

        /// <summary>
        /// Writes the contents of the current framebuffer
        /// </summary>
        public void write()
        {
            // write list of pixels to the screen
            foreach (MooseBoxPixel pix in pixels)
            {
                pix.write();
            }
        }

        /// <summary>
        /// Clears the frame by erasing any written pixels
        /// </summary>
        public void clear()
        {
            // clear written pixels by writing over them with the background image
            foreach (MooseBoxPixel pix in pixels)
            {
                // Get the address of the pixel wrt the background
                int pixelAddr = (int)((pix.addr - background.address) * 2);

                // Create a new pixel that has the address of the current pixel but with the color of the background
                MooseBoxPixel pix_background = new MooseBoxPixel(uart,
                                                                 background.getPixel8(pixelAddr),
                                                                 background.getPixel8(pixelAddr + 1),
                                                                 pix.addr);
                pix_background.write();
                //Console.WriteLine("Cleared pixel at address {0} from background {1}", pix.addr, pixelAddr);
            }
            pixels.Clear();
        }

        /// <summary>
        /// Scrolls the background 
        /// </summary>
        /// <param name="lines">The number of lines to scroll. Positive values scroll down, negative values scroll up</param>
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
                if (backgroundScrollLine + lines > 0)
                {
                    backgroundScrollLine += (uint)lines;
                }
                else
                {
                    backgroundScrollLine = (uint)background.height - SCREEN_HEIGHT;
                }
            }
            //etFramePosition((uint)(background.address + backgroundScrollLine * background.width / 2));
            framePos = (uint)(background.address + backgroundScrollLine * background.width / 2) + 16;
        }

        /// <summary>
        /// Displays the frame.
        /// </summary>
        public void showFrame()
        {
            uart.write(FRAMEBUFFER_ADDR, framePos);
        }

        /// <summary>
        /// Sets the frame position
        /// </summary>
        /// <param name="addr">The address to set the framebuffer to</param>
        public void setFramePosition(uint addr)
        {
            framePos = addr + 16; // Align the screen correctly
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
