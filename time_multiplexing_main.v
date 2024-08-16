`timescale 1ns / 1ps

module sseg_display(
    input clk, 
    input reset,
    input [15:0] in,
    output [3:0] an,
    output dp,
    output [6:0] sseg
    );
    
    wire [6:0] in0, in1, in2, in3;
    wire slow_clk;
    wire [19:0] base10;
    
    hex2base10 converter (.in(in), .out(base10));
    
    //Module instatiation of hexto7segment decoder
    hexto7segment c1 (.x(base10[3:0]), .r(in0));
    hexto7segment c2 (.x(base10[7:4]), .r(in1));
    hexto7segment c3 (.x(base10[11:8]), .r(in2));
    hexto7segment c4 (.x(base10[15:12]), .r(in3));
    
    //Module instantiation of the clock divider
    clk_div_disp c5 (.clk(clk), .reset(reset), .clk_out(slow_clk));
    
    //Module instatiation of the multiplexer
    sseg_display_fsm c6(
        .clk (slow_clk),
        .reset (reset),
        .in0 (in0),
        .in1 (in1),
        .in2 (in2),
        .in3 (in3),
        .an (an),
        .dp (dp),
        .sseg (sseg)
    );
endmodule
