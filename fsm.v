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
	 parameter CHANNEL_S = 4'b1111,
	 parameter CHANNEL_T = 4'b1111,
	 parameter COMMAND = 4'b0011
) (
    input [11:0] data,
    input rst,
    input clk,
	 input channel,
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
	 
	reg [11:0] data_r;
	reg en_r, dac_clr_r;
	reg [1:0] st, nst;
	reg sel_channel;
	
	always @(posedge clk, posedge rst)
		if(rst)
			st <= STATUS_INIT;
		else
			st <= nst;
	
	always @* begin
		nst = STATUS_INIT;
		en_r = 1'b0;
		dac_clr_r = 1'b0;
		case (st)
			STATUS_INIT: begin
				dac_clr_r = 1'b1;
				nst = STATUS_LOAD;
			end
			STATUS_LOAD: begin
				en_r = 1'b1;
				nst = STATUS_SENDING;
			end
	/*		STATUS_LOAD2: begin
				en_r = 1'b1;
				nst = STATUS_SENDING;
			end*/
			STATUS_SENDING: begin
				if (dac_cs)
					nst = STATUS_LOAD;
				else
					nst = STATUS_SENDING;
			end
		endcase
	end
	
	always @(posedge clk, posedge rst)
		if(rst)
			data_r <= 12'b0;
		else if (st == STATUS_LOAD)
			data_r <= data;
		
	always @*
		if(channel)
			sel_channel <= CHANNEL_T;
		else
			sel_channel <= CHANNEL_S;
	
	spi #(32) spi_impl (
		.clk(clk),
		.rst(rst),
		.en(en_r),
		.clr_ctrl(1'b0),
		// .data2trans({4'd0, data_r, CHANNEL, COMMAND, 8'd0}),
		.data2trans({8'd0, COMMAND, sel_channel, data_r, 4'd0}),
		.ss(dac_cs),
		.sclk(spi_sck),
		.mosi(spi_mosi)
	);
	
	assign dac_clr = !rst;
	
endmodule
