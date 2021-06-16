//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #8  - Simple End-to-End Design
// Student Name: Peiyu (Tom) Liu
// Date: 16 June 2021
//
// Description: A testbench module to test Ex8
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb();
    
//Todo: Parameters
	parameter CLK_PERIOD = 10; 	//set clock period

//Todo: Registers and wires
	reg clk;
	reg [4:0] temperature;
	wire heating;
	wire cooling;
	reg err;


//Todo: Clock generation
	initial begin
       		clk = 1'b0;
       		forever
         		#(CLK_PERIOD/2) clk=~clk;	//change every half-period
     	end

//Todo: error checking
	initial begin
		err = 0;
		
		forever begin
			#(CLK_PERIOD)
			if ((temperature > 5'd22) && (({heating,cooling} == 2'b10) || ({heating,cooling} == 2'b00))) begin
				err = 1;
				$display("*** TEST FAILED: temperature=%d heating=%d cooling=%d) ***", temperature, heating, cooling);
			end else if ((temperature < 5'd18) && (({heating,cooling} == 2'b01) || ({heating,cooling} == 2'b00))) begin
				err = 1;
				$display("*** TEST FAILED: temperature=%d heating=%d cooling=%d) ***", temperature, heating, cooling);
			end else if ({heating,cooling} == 2'b11) begin
				err = 1;
				$display("*** TEST FAILED: temperature=%d heating=%d cooling=%d) ***", temperature, heating, cooling);
			end
		end
	end
			

//Todo: Final block & schange variables

	initial begin
		temperature = 5'd20;

		#(CLK_PERIOD*2)
		temperature = 5'd22;
		#(CLK_PERIOD*2)
		temperature = 5'd25;
		#(CLK_PERIOD*2)
		temperature = 5'd20;
		#(CLK_PERIOD*2)
		temperature = 5'd18;
		#(CLK_PERIOD*2)
		temperature = 5'd19;
		#(CLK_PERIOD*2)
		temperature = 5'd20;
		#(CLK_PERIOD*2)
		if (err==0)
          		$display("***TEST PASSED!***");

		$finish;
	end

//Todo: Instantiate module
	top top (
		.clk (clk),
		.temperature (temperature),
		.heating (heating),
		.cooling (cooling)
		);	
	

 
endmodule
