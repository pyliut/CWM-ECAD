//////////////////////////////////////////////////////////////////////////////////
// Exercise #6 - RGB Colour Converter
// Student Name: Peiyu (Tom) Liu
// Date: 15 June 2021
//
//
//  Description: In this exercise, you need to design a memory with 8 entries, 
//  converting colours to their RGB code.
//
//  inputs:
//           clk, colour [2:0], enable
//
//  outputs:
//           rgb [23:0]
//
//////////////////////////////////////////////////////////////////////////////////



`timescale 1ns / 100ps

module rgb_converter (
    //Todo: add ports 
	input clk,		//0 or 1
	input [2:0] colour,	//3-bits: R G B
	input enable,		//lookup colour when 1
	output [23:0] rgb	//3x8bits: R G B
    	);

    //Todo: add register
	wire [23:0] rgb;


//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
	bram_ex6 my_bram (
	  .clka(clk),    // input wire clka
	  .ena(enable),      // input wire ena
	  .wea(1'b0),      // input wire [0 : 0] wea
	  .addra(colour),  // input wire [2 : 0] addra
	  .dina(24'b0),    // input wire [23 : 0] dina
	  .douta(rgb)  // output wire [23 : 0] douta
	);
// INST_TAG_END ------ End INSTANTIATION Template ---------


	 //always @(posedge clk)
      		//if (enable) begin
         		//rgb = my_bram;
      		//end
	
      
endmodule

