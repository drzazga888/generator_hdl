
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:58:22 12/06/2016 
// Design Name: 
// Module Name:    clogb2 
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
function integer clogb2;
input [31:0] value;
begin
	value = value - 1;
	for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
		value = value >> 1;
end
endfunction