using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MooseBoxGame
{
    /// <summary>
    /// Wrapper around some file I/O
    /// </summary>
    public class MooseBoxFileIO
    {
        /// <summary>
        /// Reads a file. Wraps System.IO.File.ReadAllLines(String) 
        /// </summary>
        /// <param name="filePath">The path of the file to be read</param>
        /// <returns>A string array with the contents of the file</returns>
        /// <exception cref="IOException">File could not be opened</exception>
        public static string[] readFile(string filePath)
        {
            string[] lines;
            try
            {
                lines = System.IO.File.ReadAllLines(filePath);
            }
            catch (Exception e)
            {
                throw new IOException();
            }

            return lines;
        }
    }
}
