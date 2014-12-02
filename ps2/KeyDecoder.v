`timescale 1ns / 1ps

module KeyDecoder #(parameter D_WIDTH = 8)
                   (input[D_WIDTH-1:0] key_code,
                    input en,
                    output e_we,
                    output w_we,
                    output a_we,
                    output s_we,
                    output d_we,
                    output kp7_we,
                    output kp8_we,
                    output kp4_we,
                    output kp5_we,
                    output kp6_we);
                    
// Player 1: E W A S D
parameter PS2_E = 8'h24;
parameter PS2_W = 8'h1D;
parameter PS2_A = 8'h1C;
parameter PS2_S = 8'h1B;
parameter PS2_D = 8'h23;

// Player 2: 7 8 4 5 6 (_KEYPAD_)
// 11/24 - remove player 2 keys KP7 and KP8, add space bar and enter
//parameter PS2_KP7 = 8'h6C;
//parameter PS2_KP8 = 8'h75;
parameter PS2_KP7 = 8'h29; // space
parameter PS2_KP8 = 8'h5A; // enter
parameter PS2_KP4 = 8'h6B;
parameter PS2_KP5 = 8'h73;
parameter PS2_KP6 = 8'h74;

assign e_we = (key_code == PS2_E && en)? 1 : 0;
assign w_we = (key_code == PS2_W && en)? 1 : 0;
assign a_we = (key_code == PS2_A && en)? 1 : 0;
assign s_we = (key_code == PS2_S && en)? 1 : 0;
assign d_we = (key_code == PS2_D && en)? 1 : 0;

assign kp7_we = (key_code == PS2_KP7 && en)? 1 : 0;
assign kp8_we = (key_code == PS2_KP8 && en)? 1 : 0;
assign kp4_we = (key_code == PS2_KP4 && en)? 1 : 0;
assign kp5_we = (key_code == PS2_KP5 && en)? 1 : 0;
assign kp6_we = (key_code == PS2_KP6 && en)? 1 : 0;

endmodule
