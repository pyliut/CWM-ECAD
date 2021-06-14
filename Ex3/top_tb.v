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

module top_tb(
    );
    
//Todo: Parameters
	parameter CLK_PERIOD = 10; 	//set clock period

//Todo: Registers and wires
	reg clk;
	reg on_off;
	reg rst;
	reg change;
	reg err;
	reg [7:0] counter_out;
	reg [7:0] counter_prev;
	
	
//Todo: Clock generation
	initial
    		begin
       			clk = 1'b0;
       			forever
         			#(CLK_PERIOD/2) clk=~clk;	//change every half-period
     		end

//Todo: User logic

	initial
		begin
			counter_out = 0;
			on_off = 1;
			rst = 0;
			change = 1;
			err = 0;
			counter_prev = counter_out;
			forever begin
				#CLK_PERIOD		//add delay to progress time
				if (change) begin
					if (on_off) begin
						if (counter_out != (counter_prev + 1)) begin
							$display("***TEST FAILED! on_off==%d, counter_out=%d counter_prev=%d***",on_off,counter_out,counter_prev);
							err = 1;
						end
					end else begin
						if (counter_out != (counter_prev - 1)) begin
							$display("***TEST FAILED! on_off==%d, counter_out=%d counter_prev=%d***",on_off,counter_out,counter_prev);
							err = 1;
						end
					end
				end
			end
		end

//Todo: Finish test, check for success
	initial begin
        	#50 			//500-1000 sim ticks
        	if (err==0)
          		$display("***TEST PASSED! :) ***");
        	$finish;	//finish simulation
      	end

//Todo: Instantiate counter module
	monitor top (
		.clk (clk),
		.rst (rst),
		.change (change),
		.on_off (on_off)
		);
 
endmodule 
