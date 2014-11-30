using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MooseBoxGame
{
    /// <summary>
    /// Represents a 2D coordinate
    /// </summary>
    public class MooseBoxPosition
    {
        int pos_x;
        int pos_y;

        /// <summary>
        /// Creates the position
        /// </summary>
        /// <param name="position_X">X coordinate</param>
        /// <param name="position_Y">Y coordinate</param>
        public MooseBoxPosition(int position_X, int position_Y)
        {
            pos_x = position_X;
            pos_y = position_Y;
        }

        /// <summary>
        /// Gets or sets the X coordinate
        /// </summary>
        public int x
        {
            get
            {
                return pos_x;
            }
            set
            {
                pos_x = value;
            }
        }

        /// <summary>
        /// Gets or sets the Y coordinate
        /// </summary>
        public int y
        {
            get
            {
                return pos_y;
            }
            set
            {
                pos_y = value;
            }
        }
    }
}
