`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:16:11 12/13/2016 
// Design Name: 
// Module Name:    clk_div 
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
module clk_div #(parameter div = 50000)(
    input clk,
	 input rst,
	 output reg slow
    );
	 
	localparam bits = logb2(div);
	reg [bits-1:0] cnt;
	always @(posedge clk, posedge rst)
		if(rst)
			cnt <= div;
		else if(cnt == {bits{1'b0}})
			cnt <= div;
		else
			cnt <= cnt-1;
			
	always @(posedge clk, posedge rst)
		if(rst)
			slow <= 1'b0;
		else if(cnt == div/2)
			slow <= 1'b1;
		else if(cnt == 0)
			slow <= 1'b0;
	
	function integer logb2;
	input integer val;
		begin
			val = val - 1;
				for(logb2 = 0; val > 0; logb2 = logb2 + 1)
					val = val >> 1;
		end
	endfunction

endmodule
