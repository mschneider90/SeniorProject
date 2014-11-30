using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MooseBoxGame
{
    /// <summary>
    /// Represents a dynamic sprite to be drawn on top of a background
    /// </summary>
    public class MooseBoxSprite : MooseBoxImage
    {
        MooseBoxUART uart;
        uint pos_X;
        uint pos_Y;

        public MooseBoxSprite(MooseBoxUART uartObj,
                              String bitMapPath,
                              uint position_X,
                              uint position_Y) : base(bitMapPath)
        {
            uart = uartObj;
            pos_X = position_X;
            pos_Y = position_Y;
        }


    }
}
