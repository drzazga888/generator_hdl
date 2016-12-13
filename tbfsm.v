`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:22:55 12/13/2016
// Design Name:   fsm
// Module Name:   /home/lab_jos/Drzazga_Bajorek/generator_hdl/tbfsm.v
// Project Name:  generator
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fsm
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tbfsm;

	// Inputs
	reg [11:0] value;
	reg rst;
	reg clk;
	reg zero;

	// Outputs
	wire spi_mosi;
	wire dac_cs;
	wire dac_clr;
	wire spi_sck;

	// Instantiate the Unit Under Test (UUT)
	fsm uut (
		.value(value), 
		.rst(rst), 
		.clk(clk), 
		.zero(zero), 
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
		zero = 1'b0;
		forever begin
			#100 zero = ~zero;
			#1 zero = ~zero;
		end
	end
	
	initial begin
		rst = 1'b0;
		value = 12'b010101010101;
		#1 rst = 1'b1;
		#5 rst = 1'b0;
	end
	
	initial begin
		#3000 $finish;
	end
      
endmodule

