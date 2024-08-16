`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2023 08:25:38 PM
// Design Name: 
// Module Name: hex2base10
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module hex2base10(
    input [15:0] in,
    output [19:0] out
    );
    
    assign out[19:16] = in % 10000;
    assign out[15:12] = (in / 1000) % 10;
    assign out[11:8] = (in / 100) % 10;
    assign out[7:4] = (in / 10) % 10;
    assign out[3:0] = in % 10;
    
endmodule
