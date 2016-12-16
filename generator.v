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
module generator #(parameter DIV = 50000) (
    input clk,
    input rst,
    output spi_mosi,
    output dac_cs,
    output dac_clr,
    output spi_sck
    );
	 
	 wire [11:0] address_wire, sample_wire;
	 
	 moduloaddr moduloaddr_inst (
		.clk(clk_slow),
		.rst(rst),
		.up(zero_wire),
		.address(address_wire)
	 );
	 
	 memory memory_inst (
		.clk(clk_slow),
		.rst(rst),
		.address(address_wire),
		.sample(sample_wire)
    );
	 
	 fsm fsm_inst (
		.clk(clk_slow),
		.rst(rst),
		.value(sample_wire),
		.zero(zero_wire),
		.spi_mosi(spi_mosi),
		.dac_cs(dac_cs),
		.dac_clr(dac_clr),
		.spi_sck(spi_sck)
    );


endmodule
