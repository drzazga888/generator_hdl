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
	 input rst,
    input in,
    output out
    );
	 
	reg [1:0] memory;
	
	always @(posedge clk, posedge rst)
		if (rst)
			memory <= 2'b0;
		else begin
			memory <= {memory[0], in};
		end
	
	assign out = ~memory[1] & memory[0];

endmodule
