`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:43:38 12/11/2016
// Design Name:   memory
// Module Name:   /home/mario/generator_hdl/tbmemory.v
// Project Name:  generator
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: memory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tbmemory;

	// Inputs
	reg clk;
	reg rst;
	reg [11:0] address;
	wire [11:0] sample;

	// Instantiate the Unit Under Test (UUT)
	memory uut (
		.clk(clk), 
		.rst(rst),
		.address(address),
		.sample(sample)
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
		address = 12'b0;
	end
	
	initial begin
		#100 $finish;
	end
	
	initial begin
		#10 address = 3;
		#15 address = 6;
	end
      
endmodule

