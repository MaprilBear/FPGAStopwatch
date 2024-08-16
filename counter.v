`timescale 1ns / 1ps

module counter(
    input [2:0] in,
    input [7:0] ext,
    input clk,
    output reg [13:0] out
    );
    
    always @(posedge clk)
        begin
        case(in)
            3'b000: out <= out;
            3'b001: out <= out + 1;
            3'b010: out <= out - 1;
            3'b011: out <= 0;
            3'b100: out <= 9999;
            3'b101: out <= ext * 100;
            default: begin
                out <= -1; //shouldn't actually get here theoretical
            end
        endcase
    end
endmodule