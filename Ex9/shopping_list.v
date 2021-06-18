`timescale 1ns / 100ps

module shopping_list (
    //Add ports 
	input clk,			//0 or 1
	input [5:0] temperature,	//6bits temperature
	output [5:0] order_code		//3x8bits: R G B
    	);

    //Add register
	wire [5:0] order_code;
	reg [2:0] temperature_band;



    //Instantiate BRAM
	bram_order my_bram_order (
	  .clka(clk),    // input wire clka
	  .ena(1'b1),      // input wire ena
	  .wea(1'b0),      // input wire [0 : 0] wea
	  .addra(temperature_band),  // input wire [2 : 0] addra
	  .dina(6'b0),    // input wire [23 : 0] dina
	  .douta(order_code)  // output wire [23 : 0] douta
	);

    //Add logic
	always @ (posedge clk)
		if (temperature <= 6'd10)
			temperature_band = 3'b001;	//hot choc & marshmallows?
		else if ((temperature > 6'd10) && (temperature <= 6'd15) )
			temperature_band = 3'b010;
		else if ((temperature > 6'd15) && (temperature <= 6'd20) )
			temperature_band = 3'b011;
		else if ((temperature > 6'd20) && (temperature <= 6'd25) )
			temperature_band = 3'b100;	//steak & veggies as usual
		else if ((temperature > 6'd25) && (temperature <= 6'd30) )
			temperature_band = 3'b101;
		else if ((temperature > 6'd30) && (temperature <= 6'd35) )
			temperature_band = 3'b110;	//ice cream and cold soda
		else if ((temperature > 6'd35))
			temperature_band = 3'b111;	//time to buy another aircon unit
		else
			temperature_band = 3'b000;		//erroneous order
      
endmodule
