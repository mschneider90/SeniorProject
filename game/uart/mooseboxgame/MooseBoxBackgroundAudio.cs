using System;
using System.IO;
using System.IO.Ports;
using System.Globalization;
using System.Security;
using System.Threading;

namespace MooseBoxGame
{
    /// <summary>
    /// This class provides the ability to play a song in a background thread
    /// </summary>
    public class MooseBoxBackgroundAudio
    {
        enum audioTypeEnum { PAF, P2F };
        const String PAF_EXT = ".paf";
        const String P2F_EXT = ".p2f";
        const int SLEEP_BETWEEN_NOTES = 120;

        MooseBoxUART uart;
        String[] audioFile;
        int audioIndex;
        audioTypeEnum audioType;
        bool stopped;

        Thread backgroundAudioThread;

        Mutex index_lock;

        /// <summary>
        /// Constructs the object and loads the initial song
        /// </summary>
        /// <param name="uartObj">The UART to write to</param>
        /// <param name="audioFilePath">The path to the .paf or .p2f audio file</param>
        public MooseBoxBackgroundAudio(MooseBoxUART uartObj, String audioFilePath)
        {
            uart = uartObj;
            audioIndex = 0;
            stopped = true;
            index_lock = new Mutex();

            loadSong(audioFilePath);

            backgroundAudioThread = new Thread(new ThreadStart(playAudio));
            backgroundAudioThread.Start();
        }

        /// <summary>
        /// Loads a new song
        /// </summary>
        /// <param name="audioFilePath">The path to the .paf or .p2f audio file</param>
        public void loadSong(String audioFilePath)
        {
            if (!stopped)
            {
                stop();
            }
            reset();
            
            String extension = Path.GetExtension(audioFilePath);
            if (extension.Equals(PAF_EXT))
            {
                audioType = audioTypeEnum.PAF;
            }
            else if (extension.Equals(P2F_EXT))
            {
                audioType = audioTypeEnum.P2F;
            }
            else
            {
                throw new ArgumentException();
            }

            audioFile = MooseBoxFileIO.readFile(audioFilePath);
        }

        /// <summary>
        /// Plays the audio. Thread safe.
        /// </summary>
        /// <remarks>
        /// This was designed to be used in a separate thread. e.g.,
        /// Thread backgroundAudioThread = new Thread(new ThreadStart(backgroundAudio.playAudio));
        /// </remarks>
        public void playAudio()
        {
            try
            {
                while (true)
                {
                    if (!stopped)
                    {
                        if (audioType == audioTypeEnum.PAF)
                        {
                            playNotePAF();
                        }
                        else // P2F
                        {
                            playNoteP2F();
                        }

                        index_lock.WaitOne();
                        if (audioIndex == audioFile.Length - 1) // Loop audio
                        {
                            audioIndex = 0;
                        }
                        else
                        {
                            audioIndex++;
                        }
                        index_lock.ReleaseMutex();
                    }

                    Thread.Sleep(SLEEP_BETWEEN_NOTES);
                }
            }
            catch (FormatException)
            {
                Console.WriteLine("MooseBoxBackgroundAudio: Bad file format");
            }
        }

        /// <summary>
        /// Plays a note of the .p2f format
        /// </summary>
        private void playNoteP2F()
        {
            String[] bytes = audioFile[audioIndex].Split('\t');
            for (uint j = 2; j < bytes.Length; j += 4) // Write effects registers
            {
                uint fx_high = (uint.Parse(bytes[j], NumberStyles.AllowHexSpecifier) << 8);
                uint fx_low = uint.Parse(bytes[j + 1], NumberStyles.AllowHexSpecifier);
                uint fx = fx_high + fx_low;

                uart.write((j - 2) / 2 + 1, fx);
            }
            for (uint j = 0; j < bytes.Length; j += 4) // Write note registers
            {
                uint note_high = (uint.Parse(bytes[j], NumberStyles.AllowHexSpecifier) << 8);
                uint note_low = uint.Parse(bytes[j + 1], NumberStyles.AllowHexSpecifier);
                uint note = note_high + note_low;

                if (note != 0) // Only write note regs if they are non-zero
                {
                    uart.write(j / 2, note);
                }
                else //write garbage to one of the unused ACP registers
                {
                    uart.write(0xF, 0);
                }
            }
        }

        /// <summary>
        /// Plays a note of the .paf format
        /// </summary>
        private void playNotePAF()
        {
            String[] regs = audioFile[audioIndex].Split(',');
            for (uint j = 1; j < regs.Length; j += 2) // Write effects registers
            {
                uint fx = uint.Parse(regs[j], NumberStyles.AllowHexSpecifier);
                uart.write(j, fx, false);
            }
            for (uint j = 0; j < regs.Length; j += 2) // Write note registers
            {
                uint note = uint.Parse(regs[j], NumberStyles.AllowHexSpecifier);
                if (note != 0) // Only write note regs if they are non-zero
                {
                    uart.write(j, note, false);
                }
                else //write garbage to one of the unused ACP registers
                {
                    uart.write(0xF, 0, false);
                }
            }

        }

        /// <summary>
        /// Restarts the song from the beginning
        /// </summary>
        public void restart()
        {
            stop();
            reset();
            start();
        }

        /// <summary>
        /// Resets position in the song back the start. Thread safe.
        /// </summary>
        public void reset()
        {
            index_lock.WaitOne();
            audioIndex = 0;
            index_lock.ReleaseMutex();
        }

        /// <summary>
        /// Resumes the song
        /// </summary>
        public void start()
        {
            stopped = false;
        }

        /// <summary>
        /// Pauses the song
        /// </summary>
        public void stop()
        {
            stopped = true;
        }

    }
}
