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
module signal2data #(parameter SIZE = 12, parameter N = 3, parameter CHANNELS = 2) (
    input clk,
    input rst,
    input next,
    output [SIZE - 1:0] data,
	 output channel
    );
	 
	`include "clogb2.v"
	
	localparam logsize = clogb2(N);
	localparam logchannel = clogb2(CHANNELS);
	
	reg [logsize-1:0] address_reg;
	reg [logchannel-1:0] counter;
	wire real_next;
	
	always @(posedge clk, posedge rst)
		if (rst)
			counter <= {logsize{1'b0}};
		else begin
			if (real_next)
				counter <= counter + 1;
		end
	
   always @(posedge clk, posedge rst) begin
		if (rst)
			address_reg <= {logsize{1'b0}};
		else begin
			if (real_next & counter) begin
			  if (address_reg == (N - 1))
					address_reg <= {logsize{1'b0}};
			  else
					address_reg <= address_reg + 1;
			end
		end
	end

	edge_detector edge_detector_impl(
		.in(next),
		.clk(clk),
		.rst(rst),
		.out(real_next)
	);
	 
	main_memory #(.size(SIZE), .logsize(logsize), .N(N)) memory_impl(
		.clk(clk),
		.read(real_next),
		.channel(counter),
		.address(address_reg),
		.sample(data)
	);

	assign channel = counter;

endmodule
