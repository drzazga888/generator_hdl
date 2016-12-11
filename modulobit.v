`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:24:41 12/06/2016 
// Design Name: 
// Module Name:    modulobit 
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
module modulobit #(parameter N = 32) (
    input clk,
    input rst,
    output zero
    );
	
	`include "clogb2.v"
	
	localparam s = clogb2(N);
	
	reg [s-1:0] memory;
	
	always @(posedge clk, posedge rst)
		if(rst)
			memory <= {s{1'b0}};
		else
			memory <= memory + 1;
			
	assign zero = (memory == 0);

endmodule
