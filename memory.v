`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:22:31 12/11/2016 
// Design Name: 
// Module Name:    memory 
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
module memory #(parameter size = 32) (
	 input clk, read, 
	 input [4:0] address,
    output reg [11:0] sample
    );
	
	reg [11:0] samples [0:size-1];

	
	initial begin
		$readmemh("memory.list", samples);
	end

	always @(posedge clk)
		if(read)
			sample = samples[address];

	
endmodule
