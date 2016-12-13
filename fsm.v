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
		STATUS_SENDING = 2'd2;
	 
	reg [11:0] value_r;
	reg en_r, value_r, st, nst;
	
	always @(posedge clk, posedge rst)
		if(rst)
			st <= STATUS_INIT;
		else
			st <= nst;
	
	always @* begin
		nst = STATUS_INIT;
		en_r = 0'b0;
		case (st)
			STATUS_INIT: begin
				en_r = 0'b1;
				nst = STATUS_LOAD;
			end
			STATUS_LOAD: begin
				value_r = value;
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
		.clr(dac_clr),
		.ss(dac_cs),
		.sclk(spi_sck),
		.mosi(spi_mosi)
	);


endmodule
