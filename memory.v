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
module memory #(parameter file = "sinus.list", parameter N = 1024, parameter size = 12, parameter logsize = 4) (
	 input clk,
	 input read, 
	 input [logsize - 1:0] address,
    output reg [size - 1:0] sample
    );
	
	reg [size - 1:0] samples [0: N - 1];
	
	initial begin
		$readmemh(file, samples);
	end
	
	always @(posedge clk)
		if(read)
			sample <= samples[address];
			
endmodule
