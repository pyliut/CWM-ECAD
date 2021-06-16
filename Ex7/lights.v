//////////////////////////////////////////////////////////////////////////////////
// Exercise #4 - Dynamic LED lights
// Student Name: Peiyu Liu
// Date: 15 June 2021
//
//  Description: In this exercise, you need to design a LED based lighting solution, 
//  following the diagram provided in the exercises documentation. The lights change 
//  as long as a button is pressed, and stay the same when it is released. 
//
//  inputs:
//           clk, rst, button
//
//  outputs:
//           colour [2:0]
//
//  You need to write the whole file.
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module lights (
    //Todo: add ports 
	input clk,	//0 or 1
	input rst,	//1 resets counter_out
	input button,	//1 indicates we should increment
	output [2:0] colour	//3-bit (RGB) colour code
    );
                    
    //Todo: add registers and wires, if needed
    	reg [2:0] colour;

    //Todo: add user logic
	always @ (posedge clk)
		if (rst)
			colour = 3'b001;
		else if (button) begin
			case(colour)
				3'b000: colour = 3'b001;
				3'b110: colour = 3'b001; //only 6 colours b1 to b110
				3'b111: colour = 3'b001;
				default: colour = colour + 3'b1;
			endcase
		end
			
      
endmodule
