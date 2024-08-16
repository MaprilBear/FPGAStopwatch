`timescale 1ns / 1ps

module stopwatch(
    input clk,
    input start,
    input reset,
    input [7:0] ext,
    input [1:0] mode,
    output [6:0] sseg,
    output [3:0] an,
    output dp
    );
    
    wire [13:0] counter;
    wire [2:0] mux;
    wire ms_clk;
    wire [7:0] ext_cap;
    assign ext_cap = ext[3:0] + (ext[7:4] * 10);
    
    clock_div_ms ms(
        .clk(clk),
        .reset(0),
        .clk_out(ms_clk)
    );
    
    FSM fsm(
        .start(start),
        .reset(reset),
        .mode(mode),
        .CLK(ms_clk),
        .counter(counter),
        .out(mux)
    );
    
    sseg_display disp(
        .clk(clk),
        .reset(0),
        .in(counter),
        .sseg(sseg),
        .an(an),
        .dp(dp)
    );
    
    counter count(
        .in(mux),
        .ext(ext_cap),
        .clk(ms_clk),
        .out(counter)
    );
    
    
endmodule
