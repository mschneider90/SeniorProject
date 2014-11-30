using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;

namespace MooseBoxGame
{
    public enum Key { A, D, ENTER, SPACE };

    /// <summary>
    /// Provides the ability to read from the keyboard in a background thread
    /// </summary>
    public class MooseBoxKeyboard
    {
        const byte A_ADDR = 0x12;
        const byte D_ADDR = 0x14;
        const byte SPACE_ADDR = 0x15;
        const byte ENTER_ADDR = 0x16;

        const int THREAD_SLEEP_MS = 100;

        MooseBoxUART uart;

        Thread keyboardThread;

        bool a_pressed;
        bool d_pressed;
        bool space_pressed;
        bool enter_pressed;

        /// <summary>
        /// Creates a keyboard object
        /// </summary>
        /// <param name="uartObj">The UART to read from</param>
        public MooseBoxKeyboard(MooseBoxUART uartObj)
        {
            uart = uartObj;

            a_pressed = false;
            d_pressed = false;
            space_pressed = false;
            enter_pressed = false;

            keyboardThread = new Thread(new ThreadStart(updateKeyStatus));
            keyboardThread.Start();
        }

        /// <summary>
        /// Updates the key status
        /// </summary>
        private void updateKeyStatus()
        {
            while (true)
            {
                a_pressed = (uart.read(A_ADDR) == 1);
                Thread.Sleep(1);
                d_pressed = (uart.read(D_ADDR) == 1);
                Thread.Sleep(1);
                enter_pressed = (uart.read(ENTER_ADDR) == 1);
                Thread.Sleep(1);
                space_pressed = (uart.read(SPACE_ADDR) == 1);

                Thread.Sleep(THREAD_SLEEP_MS);
            }
        }

        /// <summary>
        /// Checks whether or not a key is pressed
        /// </summary>
        /// <remarks>Not synchronized with the update thread but doesn't really matter in this application</remarks>
        /// <param name="key">The key to check</param>
        /// <returns>True if the key is pressed, false otherwise</returns>
        public bool isKeyPressed(Key key)
        {
            switch (key)
            {
                case Key.A:
                    {
                        return a_pressed;
                    }
                case Key.D:
                    {
                        return d_pressed;
                    }
                case Key.ENTER:
                    {
                        return enter_pressed;
                    }
                case Key.SPACE:
                    {
                        return space_pressed;
                    }
                default:
                    {
                        return false;
                    }
            }
        }
    }
}
