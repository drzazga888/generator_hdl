`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:30:36 12/06/2016
// Design Name:   modulobit
// Module Name:   /home/lab_jos/Drzazga_Bajorek/projekt/generator/tbmodbit.v
// Project Name:  generator
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: modulobit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tbmodbit;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire zero;

	// Instantiate the Unit Under Test (UUT)
	modulobit uut (
		.clk(clk), 
		.rst(rst), 
		.zero(zero)
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
		#100 $finish;
	end
      
endmodule

