`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:22:31 12/11/2016 
// Design Name: 
// Module Name:    memory 
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
module memory #(size = 32) (
	 input clk, rst, [11:0] address,
    output [11:0] sample
    );
	
	reg [11:0] output_sample;
	reg [11:0] samples [0:size];
	initial begin
		$readmemh("memory.list", samples);
	end
	integer index;
	always @(posedge clk, posedge rst)
		if(rst)
			output_sample = 12'b0;
		else begin
			index = address * 1;
			output_sample = samples[index];
		end
	
	assign sample = output_sample;
	
	function integer bit2int;
	input [11:0] addr_bin;
		begin: bin
			integer weight=1;
			integer addr_int=0;
			integer i;
			for(i=0; i<=11; i=i+1)
			begin
			  addr_int=addr_int+(addr_bin[i]*weight);   
			  weight=weight*2;
			end
		end
	endfunction

endmodule
