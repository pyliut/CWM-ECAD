`timescale 1ns / 100ps

module rgb_converter (
    //Add ports 
	input clk,		//0 or 1
	input heating,		//3-bits: R G B
	input cooling,
	output [5:0] rgb	//3x8bits: R G B
    	);

    //Add register
	wire [5:0] rgb;
	wire [1:0] mode;



    //Instantiate BRAM
	bram_lights my_bram_lights (
	  .clka(clk),    // input wire clka
	  .ena(1'b1),      // input wire ena
	  .wea(1'b0),      // input wire [0 : 0] wea
	  .addra({heating,cooling}),  // input wire [1 : 0] addra
	  .dina(6'b0),    // input wire [5 : 0] dina
	  .douta(rgb)  // output wire [5 : 0] douta
	);


	
      
endmodule
