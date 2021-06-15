//////////////////////////////////////////////////////////////////////////////////
// Exercise #3 - Active IoT Devices Monitor
// Student Name: Peiyu (Tom) Liu
// Date: 14 June 2021
//
//  Description: In this exercise, you need to design a counter of active IoT devices, where 
//  if the rst=1, the counter should be set to zero. If event=0, the value
//  should stay constant. If on-off=1, the counter should count up every
//  clock cycle, otherwise it should count down.
//  Wrap-around values are allowed.
//
//  inputs:
//           clk, rst, change, on_off
//
//  outputs:
//           counter_out[7:0]
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module monitor (
    //Todo: add ports 
	input clk,	//0 or 1
	input rst,	//1 resets counter_out
	input change,	//1 indicates we should increment/decrement
	input on_off,	//1 increments, 0 decrements
	output [7:0] counter_out	//counter
    );
                    
    //Todo: add registers and wires, if needed
    	reg [7:0] counter_out;

    //Todo: add user logic
	always @ (posedge clk)
		
		//reset
		if (rst)
			counter_out <= 8'b0;

		else if (change) begin
			if (on_off) begin
				if (counter_out == 8'b1111_1111)
					counter_out <= 8'b0;
				else
					counter_out <= counter_out + 8'b1;
			end else begin
				if (counter_out == 8'b0)
					counter_out <= 8'b1111_1111;
				else
					counter_out <= counter_out - 8'b1;
			end
		end
			
      
endmodule
