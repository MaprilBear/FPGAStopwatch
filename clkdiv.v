`timescale 1ns / 1ps

// board clock is 100Mhz (10ns) so we need to wait 100,000 cycles

module clock_div_ms(
    input clk,
    input reset,
    output clk_out
    );
    
    reg [19:0] COUNT;
    
        assign clk_out = COUNT == 999999;
        
        always @ (posedge clk)
        begin
        if(reset)
            COUNT <= 0;
        else
            COUNT <= (COUNT == 999999) ? 0 : COUNT + 1;
        end
endmodule
