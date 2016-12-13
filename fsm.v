`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:06:51 12/13/2016 
// Design Name: 
// Module Name:    fsm 
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
module fsm #(
	 parameter CHANNEL = 4'b1111,
	 parameter COMMAND = 4'b0011
) (
    input [11:0] value,
    input rst,
    input clk,
    input zero,
    output spi_mosi,
    output dac_cs,
    output dac_clr,
    output spi_sck
    );
	 
	localparam
		STATUS_INIT = 2'd0,
		STATUS_LOAD = 2'd1,
		STATUS_LOAD2 = 2'd2,
		STATUS_SENDING = 2'd3;
	 
	reg [11:0] value_r;
	reg en_r, clr_ctrl_r;
	reg [1:0] st, nst;
	
	always @(posedge clk, posedge rst)
		if(rst)
			st <= STATUS_INIT;
		else
			st <= nst;
	
	always @* begin
		nst = STATUS_INIT;
		en_r = 1'b0;
		clr_ctrl_r = 1'b1;
		case (st)
			STATUS_INIT: begin
				nst = STATUS_LOAD;
				clr_ctrl_r = 1'b0;
			end
			STATUS_LOAD: begin
				en_r = 1'b1;
				value_r = value;
				nst = STATUS_LOAD2;
			end
			STATUS_LOAD2: begin
				nst = STATUS_SENDING;
			end
			STATUS_SENDING:
				if (zero)
					nst = STATUS_LOAD;
				else
					nst = STATUS_SENDING;
		endcase
	end
		
	 
	spi #(32) spi_impl (
		.clk(clk),
		.rst(rst),
		.en(en_r),
		.clr_ctrl(1'b0),
		.data2trans({4'd0, value_r, CHANNEL, COMMAND, 8'd0}),
		.ss(dac_cs),
		.sclk(spi_sck),
		.mosi(spi_mosi)
	);
	
	assign dac_clr = clr_ctrl_r;

endmodule
