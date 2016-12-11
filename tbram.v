`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:59:00 12/11/2016
// Design Name:   ram_sp_ar_aw
// Module Name:   /home/mario/generator_hdl/tbram.v
// Project Name:  generator
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ram_sp_ar_aw
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tbram;

	// Inputs
	reg clk;
	reg rst;
	reg [7:0] address;

	// Bidirs
	wire [7:0] data;
	reg [7:0] tmpdata = 0;

	// Instantiate the Unit Under Test (UUT)
	ram_sp_ar_aw uut (
		.clk(clk),
		.rst(rst),
		.address(address), 
		.data(data)
	);

	initial begin
		address = 0;
	end
	
	initial begin
		clk = 1'b0;
		forever #1 clk = ~clk;
	end
	
	initial begin
		rst = 1'b0;
		#1 rst = 1'b1;
		#5 rst = 1'b0;
		#10 address = 2;
	end
	
	always @(posedge clk)
		tmpdata = tmpdata + 1;
		
	assign data = tmpdata;
	
	initial begin
		#100 $finish;
	end
      
endmodule

