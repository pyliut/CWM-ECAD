`timescale 1ns / 100ps

module select_light(
    //Todo: define inputs here
	input [23:0] rgb,
	input [23:0] white,
	input heating,
	input cooling,
	output [23:0] aircon_light
    	);
    
    //Todo: define registers and wires here
	wire [23:0] aircon_light;

    //Todo: define your logic here  

	//delay by 5 ticks 
	assign #5 aircon_light = (heating || cooling)? rgb : white;
endmodule
