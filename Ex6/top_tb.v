//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #6 - RGB Colour Converter
// Student Name: Peiyu (Tom) Liu
// Date: 15 June 2021
//
// Description: A testbench module to test Ex6 - RGB Colour Converter
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb();
    
//Todo: Parameters
	parameter CLK_PERIOD = 10; 	//set clock period

//Todo: Registers and wires
	reg clk;
	reg [2:0] colour;
	reg enable;
	wire [23:0] rgb;
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
		colour = 3'b001;
		forever begin
			#(CLK_PERIOD)
			if (enable) begin
				case(colour)
					3'b000: colour = 3'b001;
					3'b110: colour = 3'b001;
					3'b111: colour = 3'b001;
					default: colour = colour + 3'b001;
				endcase
			end
				
		end
	end
			

//Todo: Final block & schange variables

	initial begin
		enable = 0;

		#(CLK_PERIOD*5)
		enable = 1;
		#(CLK_PERIOD*20)
		enable = 0;
		#(CLK_PERIOD*5)
		enable = 1;
		#(CLK_PERIOD*20)
		if (err==0)
          		$display("***TEST PASSED!***");

		$finish;
	end

//Todo: Instantiate counter module
	rgb_converter top (
		.clk (clk),
		.colour (colour),
		.enable (enable),
		.rgb (rgb)
		);	
	

 
endmodule
