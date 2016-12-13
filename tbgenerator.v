`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:32:48 12/13/2016
// Design Name:   generator
// Module Name:   /home/lab_jos/Drzazga_Bajorek/generator_hdl/tbgenerator.v
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

	// Instantiate the Unit Under Test (UUT)
	generator #(.DIV(3)) uut (
		.clk(clk), 
		.rst(rst), 
		.spi_mosi(spi_mosi), 
		.dac_cs(dac_cs), 
		.dac_clr(dac_clr), 
		.spi_sck(spi_sck)
	);

	initial begin
		clk = 1'b0;
		forever #1 clk = ~clk;
	end
	
	initial begin
		rst = 1'b0;
		#1 rst = 1'b1;
		#5 rst = 1'b0;
	end
	
	initial begin
		#3000 $finish;
	end
      
endmodule

