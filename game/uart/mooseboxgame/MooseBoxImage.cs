using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;
using System.IO;
using System.Drawing.Imaging;
using Microsoft.VisualBasic; //Conversion.Hex()

namespace MooseBoxGame
{
    /// <summary>
    /// Provides the ability to get both a 24-bit Bitmap and 8-bit RGB representation of the same image
    /// </summary>
    public class MooseBoxImage
    {
        Bitmap bmp;
        String[] rgb;

        /// <summary>
        /// Constructs the object from a bitmap file
        /// </summary>
        /// <param name="bitMapPath">The path to the bitmap file</param>
        /// <exception cref="ArgumentException">The width of the image is not divisible by 2</exception>
        public MooseBoxImage(String bitMapPath)
        {
            bmp = new Bitmap(bitMapPath);
            if (bmp.Width % 2 != 0) // Only support images with even width
            {
                throw new ArgumentException("Image must have an even width");
            }
            convertToRGB();
        }

        /// <summary>
        /// Gets the BMP representation of this image
        /// </summary>
        /// <returns>The BMP representation of this image</returns>
        public Bitmap getBMP() 
        {
            return bmp;
        }

        /// <summary>
        /// Gets the RGB representation of this image
        /// </summary>
        /// <returns>The RGB representation of this image</returns>
        public String[] getRGB() 
        {
            return rgb;
        }

        /// <summary>
        /// Gets the pixel at the specified location
        /// </summary>
        /// <param name="x">X coordinate of the pixel</param>
        /// <param name="y">Y coordinate of the pixel</param>
        /// <returns>The pixel in 8 bit RGB</returns>
        public byte getPixel8(int x, int y)
        {
            return convertTo8Bit(bmp.GetPixel(x, y));
        }

        /// <summary>
        /// Gets the pixel at the specified address
        /// </summary>
        /// <param name="addr">The address of the pixel</param>
        /// <returns>The pixel in 8 bit RGB</returns>
        public byte getPixel8(int addr)
        {
            int y = addr / width;
            int x = addr - (y * width) - 1;
            return getPixel8(x, y);
        }

        /// <summary>
        /// Returns the pixel at the specified location
        /// </summary>
        /// <param name="x">X coordinate of the pixel</param>
        /// <param name="y">Y coordinate of the pixel</param>
        /// <returns>The pixel in 24 bit RGB</returns>
        public Color getPixel24(int x, int y)
        {
            return bmp.GetPixel(x, y);
        }

        /// <summary>
        /// Get the height of the image in pixels
        /// </summary>
        public int height
        {
            get
            {
                return bmp.Height;
            }
        }

        /// <summary>
        /// Get the width of the image in pixels
        /// </summary>
        public int width
        {
            get
            {
                return bmp.Width;
            }
        }

        public uint size
        {
            get
            {
                return (uint)(height * width / 2);
            }
        }

        /// <summary>
        /// Converts the bitmap to an 8bit RGB format
        /// </summary>
        private void convertToRGB()
        {
            // For each pixel in the bitmap file, convert it to 8 bit RGB
            // Our 8 bit RGB format: {RED (three bits), GREEN (three bits), BLUE (two bits)}
            int pix_x = bmp.Width;
            int pix_y = bmp.Height;

            int rgb_index = 0; // Index for the rgb file
            rgb = new String[pix_x * pix_y / 2];
            for (int y = 0; y < pix_y; y++)
            {
                for (int x = 0; x < pix_x; x += 2)
                {
                    // Pack two pixels into 16 bits
                    Color pix_high = bmp.GetPixel(x, y);
                    Color pix_low = bmp.GetPixel(x + 1, y);
                    String highByte = Conversion.Hex(convertTo8Bit(pix_high.R, pix_high.G, pix_high.B));
                    String lowByte = Conversion.Hex(convertTo8Bit(pix_low.R, pix_low.G, pix_low.B));
                    if (lowByte.Length == 1) // Insert a leading 0
                    {
                        lowByte = "0" + lowByte;
                    }
                    rgb[rgb_index] = highByte + lowByte;
                    rgb_index++;
                }
            }
        }

        /// <summary>
        /// Converts 24-bit RGB to 8 bit RGB
        /// </summary>
        /// <param name="pixel">The pixel to convert</param>
        /// <returns>The color in 8 bit RGB</returns>
        private byte convertTo8Bit(Color pixel)
        {
            return convertTo8Bit(pixel.R, pixel.G, pixel.B);
        }

        /// <summary>
        /// Converts 24-bit RGB to 8 bit RGB
        /// </summary>
        /// <param name="r">8 bit red</param>
        /// <param name="g">8 bit green</param>
        /// <param name="b">8 bit blue</param>
        /// <returns>The color in 8 bit RGB</returns>
        /// <remarks>
        /// 8 bit RGB format is: {3'R, 3'G, 2'B}
        /// </remarks>
        private byte convertTo8Bit(byte r, byte g, byte b)
        {
            ushort r_rounded = (ushort)(((ushort)r + 0x10));
            ushort g_rounded = (ushort)(((ushort)g + 0x10));
            ushort b_rounded = (ushort)(((ushort)b + 0x20));
            byte pixel8Bit = 0;
            pixel8Bit += (byte)(clipValue(r_rounded) & 0xE0); // Mask off all but the most significant three bits
            pixel8Bit += (byte)((clipValue(g_rounded) & 0xE0) >> 3);
            pixel8Bit += (byte)((clipValue(b_rounded) & 0xC0) >> 6); // Mask off all but the most significant two bits
            return pixel8Bit;
        }

        /// <summary>
        /// Clips the value of a short to the maximum value of a byte
        /// </summary>
        /// <param name="val">The value to be clipped</param>
        /// <returns>The clipped value</returns>
        private short clipValue(ushort val)
        {
            if (val > Byte.MaxValue)
            {
                return Byte.MaxValue;
            }
            return (byte)val;
        }
    }
}
