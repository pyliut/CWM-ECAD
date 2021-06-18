`timescale 1ns / 100ps

module fridge(
    	input clk,
	input [5:0] weight,			//6bits temperature
	output sel				//1 for non-empty order
   	);

	//registers & wires
	reg sel;
	wire [5:0] weight;
 

//Add logic here
	always @ (posedge clk)
		if (weight < 6'd4)
			sel = 1;
		else
			sel = 0;
			
endmodule
