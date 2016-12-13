`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:00:06 12/13/2016
// Design Name:   moduloaddr
// Module Name:   /home/lab_jos/Drzazga_Bajorek/generator_hdl/tbaddr.v
// Project Name:  generator
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: moduloaddr
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tbaddr;

	// Inputs
	reg clk;
	reg rst;
	reg up;

	// Outputs
	wire [11:0] address;

	// Instantiate the Unit Under Test (UUT)
	moduloaddr uut (
		.clk(clk), 
		.rst(rst), 
		.up(up), 
		.address(address)
	);

	initial begin
		clk = 1'b0;
		forever #1 clk = ~clk;
	end
	
	initial begin
		up = 1'b0;
		forever begin
			#4 up = ~up;
			#1 up = ~up;
		end
	end
	
	initial begin
		rst = 1'b0;
		#1 rst = 1'b1;
		#5 rst = 1'b0;
	end
	
	initial begin
		#100 $finish;
	end
      
endmodule

