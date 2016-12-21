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
module main_memory #(parameter N = 32, parameter size = 12, parameter logsize = 4) (
	 input clk,
	 input rst,
	 input read,
	 input channel,
	 input [logsize - 1:0] address,
    output [size - 1:0] sample
    );
	
	wire [size-1:0] sinus_r;
	wire [size-1:0] trojkat_r;
	
	assign read_sin = channel && read;
	assign read_tr = !channel && read;

	memory #(.size(size), .logsize(logsize), .N(N), .file("sinus.list")) memory_sinus(
		.clk(clk),
		.read(read_sin),
		.address(address),
		.sample(sinus_r)
	);
	
	memory #(.size(size), .logsize(logsize), .N(N), .file("trojkat.list")) memory_trojkat(
		.clk(clk),
		.read(read_tr),
		.address(address),
		.sample(trojkat_r)
	);
	
	assign sample = channel ? sinus_r : trojkat_r;
			
endmodule
