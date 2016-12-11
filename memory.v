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
module memory #(size = 32) (
	 input clk, rst, [11:0] address,
    output [11:0] sample
    );
	
	reg [11:0] output_sample;
	reg [11:0] samples [0:size];
	
	assign sample = output_sample;
	
	initial begin
		$readmemh("memory.list", samples);
	end

	always @(posedge clk, posedge rst)
		if(rst)
			output_sample = 12'b0;
		else begin
			index = address * 1;
			output_sample = samples[address * 1];
		end
	
endmodule
