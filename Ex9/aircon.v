`timescale 1ns / 100ps

module aircon(
    	input clk,
	input [5:0] temperature,			//6bits temperature

	output heating,				//1 if on
	output cooling				//1 if on
   	);

	//registers & wires
	reg heating;
	reg cooling;
	wire [5:0] temperature;
 

//Add logic here
	always @ (posedge clk)
		case({heating,cooling})
			2'b00: begin
				if (temperature <= 6'd18)
					heating = 1;
				else if (temperature >= 6'd22)
					cooling = 1;
			end
			2'b01: begin
				if (temperature <= 6'd20)
					cooling = 0;
			end
			2'b10: begin
				if (temperature >= 6'd20)
					heating = 0;
			end
			default: {heating,cooling} = 2'b0;
		endcase
			

endmodule
