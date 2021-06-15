//////////////////////////////////////////////////////////////////////////////////
// Exercise #5 - Air Conditioning
// Student Name: Peiyu (Tom) Liu
// Date: 15 June
//
//  Description: In this exercise, you need to an air conditioning control system
//  According to the state diagram provided in the exercise.
//
//  inputs:
//           clk, temperature [4:0]
//
//  outputs:
//           heating, cooling
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 100ps

module aircon (
    //Todo: add ports 
	input clk,	//0 or 1
	input [4:0] temp,	//temperature in degrees celsius
	output [1:0] mode	//1st bit is 1 if heating, 2nd bit is 1 if cooling
    );
                    
    //Todo: add registers and wires, if needed
    	reg [1:0] mode;

    //Todo: add user logic
	always @ (posedge clk)
		case(mode)
			2'b00: begin
				if (temp <= 5'd18)
					mode[1] = 1;
				else if (temp >= 5'd22)
					mode[0] = 1;
			end
			2'b01: begin
				if (temp <= 5'd20)
					mode[0] = 0;
			end
			2'b10: begin
				if (temp >= 5'd20)
					mode[1] = 0;
			end
			default: mode = 2'b0;
		endcase
			
      
endmodule
