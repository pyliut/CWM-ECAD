`timescale 1ns / 100ps

module top_tb();
    
//Todo: Parameters
	parameter CLK_PERIOD = 10; 	//set clock period

//Todo: Registers and wires
	//inputs
	reg clk_p;
	reg clk_n;

	reg [5:0] temperature;
	reg temperature_0;
	reg temperature_1;
	reg temperature_2;
	reg temperature_3;
	reg temperature_4;
	reg temperature_5;
	
	reg smoke;
	
	reg [5:0] weight;
	reg weight_0;
	reg weight_1;
	reg weight_2;
	reg weight_3;
	reg weight_4;
	reg weight_5;

	
	//outputs
	wire [23:0] aircon_light;
	wire alarm;
	wire [23:0] order;
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
	initial begin
		err = 0;
		smoke = 0;
		forever begin
			#CLK_PERIOD
			temperature_0 = temperature[0];
			temperature_1 = temperature[1];
			temperature_2 = temperature[2];
			temperature_3 = temperature[3];
			temperature_4 = temperature[4];
			temperature_5 = temperature[5];

			weight_0 = weight[0];
			weight_1 = weight[1];
			weight_2 = weight[2];
			weight_3 = weight[3];
			weight_4 = weight[4];
			weight_5 = weight[5];
		end
	end
			

//Todo: Final block & schange variables

	initial begin
		temperature = 6'd20;
		weight = 6'd20;

		#(CLK_PERIOD*2)
		temperature = 6'd22;
		weight = 6'd5;
		#(CLK_PERIOD*2)
		temperature = 6'd25;
		weight = 6'd2;
		#(CLK_PERIOD*2)
		temperature = 6'd60;
		#(CLK_PERIOD*2)
		temperature = 6'd25;
		smoke = 1;
		#(CLK_PERIOD*2)
		temperature = 6'd20;
		#(CLK_PERIOD*2)
		temperature = 6'd18;
		weight = 6'd20;
		#(CLK_PERIOD*2)
		temperature = 6'd19;
		smoke = 0;
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
		.temperature_0 (temperature_0),
		.temperature_1 (temperature_1),
		.temperature_2 (temperature_2),
		.temperature_3 (temperature_3),
		.temperature_4 (temperature_4),
		.temperature_5 (temperature_5),
		.weight_0 (weight_0),			//0th bit of weight
		.weight_1 (weight_1),
		.weight_2 (weight_2),
		.weight_3 (weight_3),
		.weight_4 (weight_4),
		.weight_5 (weight_5),
		.smoke (smoke),
		.aircon_light (aircon_light),
		.alarm (alarm),
		.order (order)
		);	
	

 
endmodule
