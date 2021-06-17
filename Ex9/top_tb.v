`timescale 1ns / 100ps

module top_tb();
    
//Todo: Parameters
	parameter CLK_PERIOD = 10; 	//set clock period

//Todo: Registers and wires
	reg clk_p;
	reg clk_n;

	reg [5:0] temperature;
	
	wire [23:0] aircon_light;
	reg err;


//Todo: Clock generation
	initial begin
       		clk_p = 1'b1;
       		forever
         		#(CLK_PERIOD/2) clk_p=~clk_p;	//change every half-period
     	end
	
	initial begin
       		clk_n = 1'b0;
       		forever
         		#(CLK_PERIOD/2) clk_n=~clk_n;	//change every half-period
     	end


//Todo: error checking
			

//Todo: Final block & schange variables

	initial begin
		temperature = 6'd20;

		#(CLK_PERIOD*2)
		temperature = 6'd22;
		#(CLK_PERIOD*2)
		temperature = 6'd25;
		#(CLK_PERIOD*2)
		temperature = 6'd20;
		#(CLK_PERIOD*2)
		temperature = 6'd18;
		#(CLK_PERIOD*2)
		temperature = 6'd19;
		#(CLK_PERIOD*2)
		temperature = 6'd20;
		#(CLK_PERIOD*2)
		if (err==0)
          		$display("***TEST PASSED!***");

		$finish;
	end

//Todo: Instantiate module
	controller top (
		.clk_p (clk_p),
		.clk_n (clk_n),
		.temperature_0 (temperature[0]),
		.temperature_1 (temperature[1]),
		.temperature_2 (temperature[2]),
		.temperature_3 (temperature[3]),
		.temperature_4 (temperature[4]),
		.temperature_5 (temperature[5]),
		.aircon_light (aircon_light),
		);	
	

 
endmodule
