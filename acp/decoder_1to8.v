`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Engineer: Paul Mayzeles
// Create Date:    17:31:55 10/16/2014 
// Module Name:    acp: the moosebox Audio Co-Processor
// (C) Paul Mayzeles and Michael Schneider. 2014. 
// This code may be used freely as long as the original authors are credited. 
// 
 
module decoder_1to8( 
					input [2:0] select,
					input data_in,
					output reg [7:0] data_out
    );
	 
initial 
begin
  data_out <= 8'b0;
end

always@(data_in or select)	 
	 case (select)
		3'b000: data_out <= {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,data_in};
		3'b001: data_out <= {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,data_in,1'b0};
		3'b010: data_out <= {1'b0,1'b0,1'b0,1'b0,1'b0,data_in,1'b0,1'b0};
		3'b011: data_out <= {1'b0,1'b0,1'b0,1'b0,data_in,1'b0,1'b0,1'b0};
		3'b100: data_out <= {1'b0,1'b0,1'b0,data_in,1'b0,1'b0,1'b0,1'b0};
		3'b101: data_out <= {1'b0,1'b0,data_in,1'b0,1'b0,1'b0,1'b0,1'b0};
		3'b110: data_out <= {1'b0,data_in,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};
		3'b111: data_out <= {data_in,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};
		default: data_out <= {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,data_in};
	endcase
	 


endmodule
