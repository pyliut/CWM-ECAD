//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #3 - Active IoT Devices Monitor
// Student Name: Peiyu (Tom) Liu
// Date: 14 June 2021
//
// Description: A testbench module to test Ex3 - Active IoT Devices Monitor
// Guidance: start with simple tests of the module (how should it react to each 
// control signal?). Don't try to test everything at once - validate one part of 
// the functionality at a time.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb();
    
//Todo: Parameters
	parameter CLK_PERIOD = 10; 	//set clock period

//Todo: Registers and wires
	reg clk;
	reg on_off;
	reg rst;
	reg change;
	reg err;
	wire [7:0] counter_out;
	reg [7:0] counter_prev;
	
	
//Todo: Clock generation
	initial begin
       		clk = 1'b1;
       		forever
         		#(CLK_PERIOD/2) clk=~clk;	//change every half-period
     	end

//Todo: User logic

	initial begin
		on_off = 1;
		rst = 1;
		change = 0;
		err = 0;
		#1 	//offsets checks
		forever begin
			counter_prev = counter_out;
			#CLK_PERIOD		//add delay to progress time
			
			//check for failure
			if (change) begin
				if (on_off) begin
					if (counter_out != (counter_prev + 1)) begin
						$display("***TEST FAILED: on_off==%d, change == %d, counter_out=%d counter_prev=%d***",on_off,change,counter_out,counter_prev);
						err = 1;
					end
				end else begin
					if (counter_out != (counter_prev - 1)) begin
						$display("***TEST FAILED: on_off==%d, change == %d, counter_out=%d counter_prev=%d***",on_off,change,counter_out,counter_prev);
						err = 1;
					end
				end
			end
		end
	end

//Todo: Finish test, check for success
	initial begin
		#10
		rst = 0;
		#10
		change = 1;
		#30
		change = 0;
		#60
		change = 1;
		#200
		on_off = 0;
        	#200			//500-1000 sim ticks in total
        	if (err==0)
          		$display("***TEST PASSED! :) ***");
        	$finish;	//finish simulation
      	end

//Todo: Instantiate counter module
	monitor top (
		.clk (clk),
		.rst (rst),
		.change (change),
		.on_off (on_off),
		.counter_out (counter_out)
		);
 
endmodule 
