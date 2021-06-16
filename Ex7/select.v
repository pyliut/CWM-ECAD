//////////////////////////////////////////////////////////////////////////////////
// Exercise #2 - Doorbell Chime
// Student Name: Peiyu (Tom) Liu
// Date: 14 June 2021
//
//  Description: In this exercise, you need to design a multiplexer that chooses between two sounds, where the  
//  output is delayed by 5 ticks (not clocks!) and acts according to the following truth table:
//
//  sel | out
// -----------------
//   0  | a
//   1  | b
//
//  inputs:
//           a, b, sel
//
//  outputs:
//           out
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module select(
    //Todo: define inputs here
	input [23:0] rgb,
	input [23:0] white,
	input sel,
	output [23:0] light
    	);
    
    //Todo: define registers and wires here
	wire light;

    //Todo: define your logic here  

	//delay by 5 ticks            
      	assign #5 light = (sel)? rgb : white;
endmodule
