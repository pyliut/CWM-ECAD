`timescale 1ns / 100ps

module top(
    	input clk_p,
    	input clk_n,

     //Todo: add all other ports besides clk_n and clk_p 
	input temperature_0,			//0th bit of temperature
	input temperature_1,
	input temperature_2,
	input temperature_3,
	input temperature_4,
	input temperature_5,
	output [23:0] aircon_light,					//1 if on
   	);

	//Add registers/wires
	wire heating
	wire cooling
	wire [23:0] rgb;
	wire [23:0] aircon_light;
	wire [5:0] temperature = {temperature_5, temperature_4, temperature_3, temperature_2, temperature_1, temperature_0};
    

   /* clock infrastructure, do not modify */
        wire clk_ibufds;

    	IBUFDS IBUFDS_sysclk (
		.I(clk_p),
		.IB(clk_n),
		.O(clk_ibufds)
	);

     	wire clk; //use this signal as a clock for your design
        
     	BUFG bufg_clk (
		.I  (clk_ibufds),
		.O  (clk)
      	);


    //Add modules
	aircon my_aircon (
		.clk (clk),			//0 or 1
		.temperature (temperature),	//6 bits	
		.heating (heating),		//1 indicates heating on
		.cooling (cooling)		//1 indicates cooling on
    	);

	rgb_converter my_rgb_converter (
		.clk (clk),		//0 or 1
		.heating (heating),	//1 indicates heating on
		.cooling (cooling),	//1 indicates cooling on
		.rgb (rgb)		//3x8bits: R G B
	);

	select_light my_select_light(
		.rgb (rgb),
		.white (24'hffffff),
		.heating (heating),	//1 indicates heating on
		.cooling (cooling),	//1 indicates cooling on
		.aircon_light (aircon_light)
	);

endmodule
