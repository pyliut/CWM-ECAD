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
	reg clk_p;
	reg clk_n;
	reg rst_n;
	reg temperature_0;
	reg temperature_1;
	reg temperature_2;
	reg temperature_3;
	reg temperature_4;
	reg [4:0] temperature = {temperature_4, temperature_3, temperature_2, temperature_1, temperature_0};
	wire heating;
	wire cooling;
	reg err;


//Todo: Clock generation
	initial begin
       		clk_p = 1'b1;
       		forever
         		#(CLK_PERIOD/2) clk_p=~clk_p;	//change every half-period
     	end
	clk_n = ~clk_p;

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
		.clk_p (clk_p),
		.clk_n (clk_n),
		.rst_n (rst_n),
		.temperature_0 (temperature_0),
		.temperature_1 (temperature_1),
		.temperature_2 (temperature_2),
		.temperature_3 (temperature_3),
		.temperature_4 (temperature_4),
		.heating (heating),
		.cooling (cooling)
		);	
	

 
endmodule
