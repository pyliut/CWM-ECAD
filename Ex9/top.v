`timescale 1ns / 100ps

module controller (
    	input clk_p,
    	input clk_n,

     //Todo: add all other ports besides clk_n and clk_p 
	input temperature_0,			//0th bit of temperature
	input temperature_1,
	input temperature_2,
	input temperature_3,
	input temperature_4,
	input temperature_5,
	
	input weight_0,			//0th bit of weight
	input weight_1,
	input weight_2,
	input weight_3,
	input weight_4,
	input weight_5,

	input smoke,

	output [23:0] aircon_light,				//1 if on
	output alarm,
	output [23:0] order
   	);

	//Add registers/wires
	wire heating;
	wire cooling;
	wire [23:0] rgb;
	wire [23:0] aircon_light;
	wire [5:0] temperature = {temperature_5, temperature_4, temperature_3, temperature_2, temperature_1, temperature_0};
	
	wire alarm;
	
	wire [5:0] weight = {weight_5, weight_4, weight_3, weight_2, weight_1, weight_0};
	wire [23:0] order_code;
    	wire [23:0] order;

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

	smoke_detector my_smoke_detector(
		.clk (clk),
		.temperature (temperature),			//6bits temperature
		.smoke (smoke),					//1 if on
		.alarm (alarm)					//1 if on
   	);

	fridge my_fridge(
		.clk (clk),
		.weight (weight),			//6bits temperature
		.sel (sel)				//1 for non-empty order
	);

	shopping_list my_shopping_list(
		.clk (clk),				//0 or 1
		.temperature (temperature),		//6bits temperature
		.order_code (order_code)		//3x8bits: R G B
    	);

	select_order my_select_order(
		.order_code (order_code),
		.no_order (24'hffffff),
		.sel (sel),
		.order (order)
	);








endmodule
