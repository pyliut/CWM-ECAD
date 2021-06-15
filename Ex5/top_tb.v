//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #5 - Air Conditioning
// Student Name: Peiyu (Tom) Liu
// Date: 15 June
//
// Description: A testbench module to test Ex5 - Air Conditioning
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb();
    
//Todo: Parameters
	parameter CLK_PERIOD = 10; 	//set clock period

//Todo: Registers and wires
	reg clk;
	reg [4:0] temp;
	wire [1:0] mode;
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
			if ((temp > 5'd22) && ((mode == 2'b10) || (mode == 2'b00))) begin
				err = 1;
				$display("*** TEST FAILED :( *** temp=%d mode(heating_bit, cooling_bit) =%d", temp, mode);
			end else if ((temp < 5'd18) && ((mode == 2'b01) || (mode == 2'b00))) begin
				err = 1;
				$display("*** TEST FAILED :( *** temp=%d mode(heating_bit, cooling_bit) =%d", temp, mode);
			end else if (mode == 2'b11) begin
				err = 1;
				$display("*** INVALID MODE :( *** temp=%d mode(heating_bit, cooling_bit) =%d", temp, mode);
			end
		end
	end
			

//Todo: Final block & schange variables

	initial begin
		temp = 5'd20;

		#(CLK_PERIOD*2)
		temp = 5'd22;
		#(CLK_PERIOD*2)
		temp = 5'd25;
		#(CLK_PERIOD*2)
		temp = 5'd20;
		#(CLK_PERIOD*2)
		temp = 5'd18;
		#(CLK_PERIOD*2)
		temp = 5'd19;
		#(CLK_PERIOD*2)
		temp = 5'd20;
		#(CLK_PERIOD*2)
		if (err==0)
          		$display("***TEST PASSED!***");

		$finish;
	end

//Todo: Instantiate counter module
	aircon top (
		.clk (clk),
		.temp (temp),
		.mode (mode)
		);	
	

 
endmodule
