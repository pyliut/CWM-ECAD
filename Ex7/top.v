//////////////////////////////////////////////////////////////////////////////////
// Exercise #7 - Lights Selector
// Student Name: Peiyu (Tom) Liu
// Date: 16 june 2021
//
//  Description: In this exercise, you need to implement a selector between RGB 
// lights and a white light, coded in RGB. If sel is 0, white light is used. If
//  the sel=1, the coded RGB colour is the output.
//
//  inputs:
//           clk, sel, rst, button
//
//  outputs:
//           light [23:0]
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 100ps

module light_select (
    //Add ports 
	input clk,		//0 or 1
	input sel,		//1 = rgb, 0 = white
	input rst,		//resets rgb to 3'b001
	input button, 		//changes to next rgb colour in sequence 
	output [23:0] light	//3x8bits: R G B or white
    	);

    //Add registers/wires
	wire [2:0] colour;
	wire [23:0] rgb;
	wire [23:0] light;

    //Add modules
	lights my_lights (
		.clk (clk),		//0 or 1
		.rst (rst),		//1 resets counter_out
		.button (button),	//1 indicates we should increment
		.colour (colour)	//3-bit (RGB) colour code
    	);

	rgb_converter my_rgb_converter (
		.clk (clk),		//0 or 1
		.colour (colour),	//3-bits: R G B
		.enable (1'b1),		//lookup colour when 1
		.rgb (rgb)		//3x8bits: R G B
	);

	select my_select(
		.rgb (rgb),
		.white (24'hffffff),
		.sel (sel),
		.light (light)
	);
	
    //Add logic


endmodule
	
	
