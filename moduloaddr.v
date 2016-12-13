`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:35:33 12/06/2016 
// Design Name: 
// Module Name:    moduloaddr 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module moduloaddr #(parameter N = 32) (
    input clk,
    input rst,
    input up,
    output [11:0] address
    );
	 
	`include "clogb2.v"
	
	localparam s = clogb2(N);
	localparam t = 12 - s;
	
	reg [s-1:0] memory;
	
	always @(posedge clk, posedge rst)
		if(rst)
			memory <= {s{1'b0}};
		else if(up)
			memory <= memory + 1;
			
	assign address = {{t{1'b0}}, memory};

endmodule
