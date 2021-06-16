//////////////////////////////////////////////////////////////////////////////////
// Exercise #8  - Simple End-to-End Design
// Student Name: Peiyu (Tom) Liu
// Date: 16 June 2021
//
//  Description: In this exercise, you need to design an air conditioning system
//
//  inputs:
//           rst_n, clk_n, clk_p, temperature [4:0]
//
//  outputs:
//           heating, cooling
//////////////////////////////////////////////////////////////////////////////////


module top(
    	input clk_p,
    	input clk_n,
     //Todo: add all other ports besides clk_n and clk_p 
	input rst_n,
	input [4:0] temperature,
	output heating,				//1 if on
	output cooling				//1 if on
   	);

	//registers
	reg heating;
	reg cooling;
    

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

//Add logic here
	always @ (posedge clk)
		case({heating,cooling})
			2'b00: begin
				if (temperature <= 5'd18)
					heating = 1;
				else if (temperature >= 5'd22)
					cooling = 1;
			end
			2'b01: begin
				if (temperature <= 5'd20)
					cooling = 0;
			end
			2'b10: begin
				if (temperature >= 5'd20)
					heating = 0;
			end
			default: {heating,cooling} = 2'b0;
		endcase
			

endmodule
