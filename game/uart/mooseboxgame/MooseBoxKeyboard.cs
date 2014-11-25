using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MooseBoxGame
{
    public enum keyEnum { A, D, ENTER, SPACE };

    /// <summary>
    /// 
    /// </summary>
    public class MooseBoxKeyboard
    {
        const byte A_ADDR = 0x12;
        const byte D_ADDR = 0x14;
        const byte SPACE_ADDR = 0x15;
        const byte ENTER_ADDR = 0x16;

        MooseBoxUART uart;

        /// <summary>
        /// 
        /// </summary>
        /// <param name="uartObj"></param>
        public MooseBoxKeyboard(MooseBoxUART uartObj)
        {
            uart = uartObj;
        }

        /// <summary>
        /// Checks whether or not a key is pressed
        /// </summary>
        /// <param name="key">The key to check</param>
        /// <returns>True if the key is pressed, false otherwise</returns>
        public bool isKeyPressed(keyEnum key)
        {
            uint readValue = 0;
            switch (key)
            {
                case keyEnum.A:
                    {
                        readValue = uart.read(A_ADDR);
                        break;
                    }
                case keyEnum.D:
                    {
                        readValue = uart.read(D_ADDR);
                        break;
                    }
                case keyEnum.ENTER:
                    {
                        readValue = uart.read(ENTER_ADDR);
                        break;
                    }
                case keyEnum.SPACE:
                    {
                        readValue = uart.read(SPACE_ADDR);
                        break;
                    }
            }

            if (readValue == 1)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}
