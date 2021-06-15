//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #4 - Dynamic LED lights
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex4 - Dynamic LED lights
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb();
    
//Todo: Parameters
	parameter CLK_PERIOD = 10; 	//set clock period

//Todo: Registers and wires
	reg clk;
	reg rst;
	reg button;
	wire [2:0] colour;


//Todo: Clock generation
	initial begin
       		clk = 1'b0;
       		forever
         		#(CLK_PERIOD/2) clk=~clk;	//change every half-period
     	end


//Todo: User logic

	initial begin
		rst = 1;
		button = 0;

		#(CLK_PERIOD*5)
		rst = 0;
		#(CLK_PERIOD*5)
		button = 1;
		#(CLK_PERIOD*20)
		rst = 1;
		#(CLK_PERIOD*10)
		rst = 0;
		#(CLK_PERIOD*20)
		$finish;
	end

//Todo: Instantiate counter module
	monitor top (
		.clk (clk),
		.rst (rst),
		.button (button),
		.colour (colour)
		);	
	

 
endmodule 
