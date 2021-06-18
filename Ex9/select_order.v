`timescale 1ns / 100ps

module select_order(
    //Todo: define inputs here
	input [23:0] order_code,
	input [23:0] no_order,
	input sel,
	output [23:0] order
    	);
    
    //Todo: define registers and wires here
	wire [23:0] order;

    //Todo: define your logic here  

	//delay by 5 ticks 
	assign #5 order = (sel)? order_code : no_order;
endmodule