//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #7 - Lights Selector
// Student Name: Peiyu (Tom) Liu
// Date: 16 June 2021
//
// Description: A testbench module to test Ex7 - Lights Selector
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb();
    
//Todo: Parameters
	parameter CLK_PERIOD = 10; 	//set clock period

//Todo: Registers and wires
	reg clk;
	reg sel;		//1 = rgb, 0 = white
	reg rst;		//resets rgb to 3'b001
	reg button; 		//changes to next rgb colour in sequence 
	wire [23:0] light;	//3x8bits: R G B or white

	reg err;


//Todo: Clock generation
	initial begin
       		clk = 1'b1;
       		forever
         		#(CLK_PERIOD/2) clk=~clk;	//change every half-period
     	end

//Todo: error checking
	initial begin
		err = 0;
		
		forever begin
			#(CLK_PERIOD)
			if ( (sel == 0) && (light != 24'hffffff) ) begin
				err = 1;
				$display("*** TEST FAILED : sel=%d rst =%d ***", sel, rst);
			end 
		end
	end		

//Todo: Final block & schange variables

	initial begin
		sel = 0;
		rst = 1;
		button = 0;

		#(CLK_PERIOD*5)
		sel = 1;
		#(CLK_PERIOD*5)
		rst = 0;
		#(CLK_PERIOD*5)
		button = 1;
		#(CLK_PERIOD*10)

		#(CLK_PERIOD*5)
		button = 0;
		#(CLK_PERIOD*5)
		rst = 1;
		#(CLK_PERIOD*5)
		rst = 0;
		#(CLK_PERIOD*5)

		if (err==0)
          		$display("***TEST PASSED!***");

		$finish;
	end

//Todo: Instantiate module
	

	light_select top (
		.clk (clk),		//0 or 1
		.sel (sel),		//1 = rgb, 0 = white
		.rst (rst),		//resets rgb to 3'b001
		.button (button), 	//changes to next rgb colour in sequence 
		.light (light)		//3x8bits: R G B or white
    	);
	

 
endmodule
