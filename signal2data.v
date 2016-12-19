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
module signal2data #(parameter SIZE = 12, parameter N = 3) (
    input clk,
    input rst,
    input next,
    output [SIZE - 1:0] data
    );
	 
	`include "clogb2.v"
	
	localparam logsize = clogb2(SIZE);
	
	reg [logsize - 1:0] address_reg;
	wire real_next;
	
        always @(posedge clk, posedge rst) begin
		if (rst)
			address_reg <= {logsize{1'b0}};
                else begin
                        if (real_next) begin
                                if (address_reg == (N - 1))
                                        address_reg <= {logsize{1'b0}};
                                else
                                        address_reg <= address_reg + 1;
                        end
                end
	end

	edge_detector edge_detector_impl(
		.i(next),
		.clk(clk),
		.o(real_next)
	);
	 
	memory #(.size(SIZE), .logsize(logsize), .N(N)) memory_impl(
		.clk(clk),
		.read(next),
		.address(address_reg),
		.sample(data)
	);


endmodule
