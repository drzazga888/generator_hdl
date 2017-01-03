`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:50:37 12/17/2016
// Design Name:   generator
// Module Name:   /home/mario/generator_hdl/tbgenerator.v
// Project Name:  generator
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: generator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tbgenerator;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire spi_mosi;
	wire dac_cs;
	wire dac_clr;
	wire spi_sck;
	wire cs_test;
	wire clk_test;

	// Instantiate the Unit Under Test (UUT)
	generator #(.N(3)) uut (
		.clk(clk), 
		.rst(rst), 
		.spi_mosi(spi_mosi), 
		.dac_cs(dac_cs), 
		.dac_clr(dac_clr), 
		.spi_sck(spi_sck),
		.cs_test(cs_test),
		.clk_test(clk_test)
	);
	
	always begin
		#5 clk = !clk;
	end

	initial begin
		clk = 0;
		rst = 1;
		#5
		rst = 0;
		#300
		$finish;
	end
      
endmodule

