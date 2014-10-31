using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;
using System.IO;
using System.Drawing.Imaging;
using Microsoft.VisualBasic; //Conversion.Hex()

namespace bmp2rgb
{
    class bmp2rgb
    {
        public static void Main()
        {
            Console.WriteLine("bmp2rgb Mk.I Copyright (C) 2014 Mike and Paul");

            Console.Write("Enter name of file to convert: ");
            String fileName = Console.ReadLine();

            Console.Write("Enter name of output file: ");
            String fileNameOut = Console.ReadLine();

            Bitmap bmp;
            try
            {
                bmp = new Bitmap(fileName);
            }
            catch (FileNotFoundException)
            {
                Console.WriteLine("Can't find specified file. Press enter to exit");
                Console.ReadLine();
                return;
            }
            catch (ArgumentException)
            {
                Console.WriteLine("File name must be *.bmp. Press enter to exit");
                Console.ReadLine();
                return;
            }

            if (bmp.PixelFormat != PixelFormat.Format24bppRgb)
            {
                Console.WriteLine("ERROR: Opened bitmap file with format {0}", bmp.PixelFormat);
                Console.WriteLine("The bitmap format should be 24 bits RGB");
            }

            // For each pixel in the bitmap file, convert it to 8 bit RGB
            // Our 8 bit RGB format: {RED (three bits), GREEN (three bits), BLUE (two bits)}
            int pix_x = bmp.Width;
            int pix_y = bmp.Height;

            int rgb_index = 0; // Index for the rgb file
            String[] rgb = new String[pix_x * pix_y];
            for (int y = 0; y < pix_y; y++ )
            {
                for (int x = 0; x < pix_x; x++)
                {
                    Color pix = bmp.GetPixel(x, y);
                    rgb[rgb_index] = Conversion.Hex(convertTo8Bit(pix.R, pix.G, pix.B));
                    rgb_index++;
                }
            }

            try
            {
                File.WriteAllLines(fileNameOut, rgb);
            }
            catch (IOException)
            {
                Console.WriteLine("Failed to open output file. Press enter to exit");
                Console.ReadLine();
            }
            Console.WriteLine("File successfully converted, output {0}", fileNameOut);
            Console.WriteLine("Press enter to exit");
            Console.ReadLine();
        }

        static byte convertTo8Bit(byte r, byte g, byte b)
        {
            byte pixel8Bit = 0;
            pixel8Bit += (byte)(r & 0xE0); // Keep the most significant three bits
            pixel8Bit += (byte)((g & 0xE0) >> 3); 
            pixel8Bit += (byte)((b & 0xC0) >> 6); // Keep the most significant two bits
            return pixel8Bit;
        }
    }
}


