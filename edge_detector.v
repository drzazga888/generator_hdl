`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:31:01 12/17/2016 
// Design Name: 
// Module Name:    edge_detector 
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
module edge_detector(
    input clk,
    input i,
    output o
    );
	 
	reg posedge_detector_r = 1'b0;
	 
	always @(posedge clk)
		posedge_detector_r <= i; 
		
	assign o = i & ~posedge_detector_r;

endmodule
