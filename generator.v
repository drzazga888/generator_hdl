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
module generator(
    input clk,
    input rst,
    /*output spi_mosi,
    output dac_cs,
    output dac_clr,
    output spi_sck*/
	 output[11:0] address
    );
	 
	 modulobit modulobit_inst (
		.clk(clk),
		.rst(rst),
		.zero(zero_wire)
	 );
	 
	 moduloaddr moduloaddr_inst (
		.clk(clk),
		.rst(rst),
		.up(zero_wire),
		.address(address)
	 );


endmodule
