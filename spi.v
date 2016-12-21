`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:56:27 12/06/2016 
// Design Name: 
// Module Name:    spi 
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
module spi #(parameter bits = 8) (
	input clk, rst, en, miso, clr_ctrl,
	input [bits-1:0] data2trans,
	output clr, ss, sclk, mosi,
	output reg [bits-1:0] data_rec
	);

	`include "clogb2.v"

	localparam m = 3, d = 1, bm = clogb2(m), bdcnt = clogb2(bits);
	localparam idle = 2'b00, shdown = 2'b01, progr = 2'b10, start = 2'b11;
	
	reg [1:0] st, nst;
	reg [bits-1:0] shr;
	reg [bm-1:0] cnt;
	reg [bdcnt:0] dcnt;
	reg tmp, tm, cnten;
	
	//rejestr stanu
	always @(posedge clk, posedge rst)
		if(rst)
			st <= idle;
		else
			st <= nst;
	//logika automatu
	always @*
	begin
		nst = idle;
		cnten= 1'b1;
		case(st)
			idle: begin
				cnten=1'b0;
				nst = en ? (clr_ctrl ? shdown : start):idle;
			end
			shdown: nst = (cnt == m-1)?start:shdown;
			start: nst = (cnt == d)?progr:start;
			progr: nst = (dcnt == {(bdcnt+1){1'd0}})?idle:progr;
		endcase
	end
	//licznik czasu trwania stanów 
	//i poziomów zegara transmisji 
	always @(posedge clk, posedge rst)
		if(rst)
			cnt <= {bm{1'b0}};
		else if(cnten)
			if(cnt == m | dcnt == {(bdcnt+1){1'd0}})
				cnt <= {bm{1'b0}};
			else
				cnt <= cnt + 1'b1;
	//logika sygnałów wyjściowych		
	assign clr = (st == shdown)?1'b1:1'b0;
	assign ss=((st== start) | (st==progr))?1'b0:1'b1;
	assign sclk = ((st == progr) & (cnt < (m/2 + 1)))?1'b1:1'b0;
	
	//generator zezwolenie dla rejestru przesuwnego
	always @(posedge clk, posedge rst)
		if(rst)
			tmp<= 1'b0;
		else
			tmp <= sclk;
		assign spi_en = ~sclk & tmp;
	//licznik bitów
	always @(posedge clk, posedge rst)
		if(rst)
			dcnt <= bits;
		else if(spi_en)
			dcnt <= dcnt - 1'b1;
		else if(en& dcnt == {(bdcnt+1){1'd0}})
			dcnt <= bits;
	//rejestr przesuwny
	assign mosi = shr[bits-1];
	always @(posedge clk, posedge rst)
		if(rst)
			shr<={bits{1'b0}};
		else if(en)
			shr <= data2trans;
		else if(spi_en)
			shr <= {shr[bits-2:0],miso};
	//generator zezwolenia zapisu na wyjście
	always @(posedge clk, posedge rst)
		if(rst)
			tm <= 1'b0;
		else
			tm <= ss;
	assign en_out= ss & ~tm;
	//rejestr wyjściowy
	always @(posedge clk, posedge rst)
		if(rst)
			data_rec <= {bits{1'b0}};
		else if(en_out)
			data_rec <= shr;
endmodule
