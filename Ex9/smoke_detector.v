`timescale 1ns / 100ps

module smoke_detector(
    	input clk,
	input [5:0] temperature,			//6bits temperature

	input smoke,					//1 if on
	output alarm					//1 if on
   	);

	//registers & wires
	wire smoke;
	reg alarm;
	wire [5:0] temperature;



//Add logic here
	always @ (posedge clk)
		if ((smoke) || (temperature >= 6'd50))
			alarm = 1;
		else
			alarm = 0;	
			

endmodule
