`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:04:54 12/11/2016 
// Design Name: 
// Module Name:    generator 
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
module generator #(parameter DIV = 50000, parameter SIZE = 12, parameter N = 1024) (
    input clk,
    input rst,
    output spi_mosi,
    output dac_cs,
    output dac_clr,
    output spi_sck
    );
	 
	`include "clogb2.v"
	
	localparam logsize = clogb2(SIZE);
	 
	wire [SIZE - 1:0] sample_wire;

	signal2data #(.N(N)) signal2data_impl (
		.clk(clk),
		.rst(rst),
		.next(dac_cs),
		.data(sample_wire),
		.channel(channel_wire)
	);

	fsm fsm_inst (
		.clk(clk),
		.rst(rst),
		.data(sample_wire),
		.channel(channel_wire),
		.spi_mosi(spi_mosi),
		.dac_cs(dac_cs),
		.dac_clr(dac_clr),
		.spi_sck(spi_sck)
	);


endmodule
