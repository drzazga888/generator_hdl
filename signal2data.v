`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:21:27 12/17/2016 
// Design Name: 
// Module Name:    signal2data 
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
module signal2data #(parameter SIZE = 12) (
    input clk,
    input rst,
    input next,
    output [SIZE - 1:0] data
    );
	 
	`include "clogb2.v"
	
	localparam logsize = clogb2(SIZE);
	
	reg [logsize - 1:0] address_reg;
	
	always @(posedge clk, posedge rst) begin
		if (rst)
			address_reg <= {logsize{1'b0}};
		if (next)
			address_reg <= address_reg + 1;
	end
	
	always @* begin
		if (address_reg == SIZE)
			address_reg = {logsize{1'b0}};
	end
	 
	memory memory_impl (
		.clk(clk),
		.read(next),
		.address(address_reg),
		.sample(data)
	);


endmodule
