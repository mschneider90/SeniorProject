`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:21:50 09/03/2014 
// Design Name: 
// Module Name:    noise_channel 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////



//The linear feedback shift register (LFSR) generates a pseudo-random bit sequence. 
//It has a 15-bit shift register with feedback. When clocked by the frequency timer, 
//the low two bits (0 and 1) are XORed, all bits are shifted right by one, and the 
//result of the XOR is put into the now-empty high bit. If width mode is 1 (NR43), 
//the XOR result is ALSO put into bit 6 AFTER the shift, resulting in a 7-bit LFSR. 
//The waveform output is bit 0 of the LFSR, INVERTED.
//SOURCE: http://gbdev.gg8.se/wiki/articles/Gameboy_sound_hardware


module noise_channel(
    );


endmodule
