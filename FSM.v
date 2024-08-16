`timescale 1ns / 1ps

localparam HOLD = 3'b000;
localparam INC = 3'b001;
localparam DEC = 3'b010;
localparam LOAD_0 = 3'b011;
localparam LOAD_9999 = 3'b100;
localparam LOAD_EXT = 3'b101;

localparam INIT = 2'b00;
localparam INC_DEC = 2'b01;
localparam PAUSE = 2'b10;
localparam DONE = 2'b11;

localparam MODE_INC_0 = 2'b00;
localparam MODE_INC_EXT = 2'b01;
localparam MODE_DEC_9999 = 2'b10;
localparam MODE_DEC_EXT = 2'b11;

module FSM(
    input start,
    input reset,
    input [1:0] mode,
    input CLK,
    input [13:0] counter,
    output [2:0] out
    );
    
    reg start_stop_delay;   
    wire start_stop_edge;
    assign start_stop_edge = start && !start_stop_delay;
    
    reg [1:0] mode_delay;
    wire mode_change;
    assign mode_change = mode != mode_delay;
    
    
    always @ (posedge CLK) begin
        start_stop_delay <= start;
        mode_delay <= mode;
    end
    
        reg [1:0] state = 0;
    reg [2:0] out_buf;
    assign out = out_buf;
    
    always @(posedge CLK) begin
        if (mode_change) begin
            state <= INIT;
            case (mode)
                MODE_INC_0: out_buf <= LOAD_0;
                MODE_INC_EXT: out_buf <= LOAD_EXT;
                MODE_DEC_9999: out_buf <= LOAD_9999;
                MODE_DEC_EXT: out_buf <= LOAD_EXT;
            endcase
        end else begin
            case (state)
                INIT: begin 
                    if (start_stop_edge) begin
                        state <= INC_DEC;
                    end
                    case (mode)
                        MODE_INC_0: out_buf <= LOAD_0;
                        MODE_INC_EXT: out_buf <= LOAD_EXT;
                        MODE_DEC_9999: out_buf <= LOAD_9999;
                        MODE_DEC_EXT: out_buf <= LOAD_EXT;
                    endcase
                end
                INC_DEC: begin 
                    if (reset) begin
                       case (mode)
                            MODE_INC_0: out_buf <= LOAD_0;
                            MODE_INC_EXT: out_buf <= LOAD_EXT;
                            MODE_DEC_9999: out_buf <= LOAD_9999;
                            MODE_DEC_EXT: out_buf <= LOAD_EXT;
                        endcase 
                        state <= INIT;
                    end
                    else if (start_stop_edge) begin
                        state <= PAUSE;
                        out_buf <= HOLD;
                    end
                    else if (((mode == MODE_INC_0 || mode == MODE_INC_EXT) && counter == 9998) 
                        || ((mode == MODE_DEC_9999 || mode == MODE_DEC_EXT) && counter == 1)) begin
                        
                        state <= DONE;
                        out_buf <= HOLD;
                    end 
                    else begin
                        case (mode)
                            MODE_INC_0: out_buf <= INC;
                            MODE_INC_EXT: out_buf <= INC;
                            MODE_DEC_9999: out_buf <= DEC;
                            MODE_DEC_EXT: out_buf <= DEC;
                        endcase 
                    end
                end
                
                PAUSE: begin
                    if (reset) begin
                        case (mode)
                            MODE_INC_0: out_buf <= LOAD_0;
                            MODE_INC_EXT: out_buf <= LOAD_EXT;
                            MODE_DEC_9999: out_buf <= LOAD_9999;
                            MODE_DEC_EXT: out_buf <= LOAD_EXT;
                        endcase 
                        state <= INC_DEC;
                    end
                    else if (start_stop_edge) begin
                        state <= INC_DEC;
                        case (mode)
                            MODE_INC_0: out_buf <= INC;
                            MODE_INC_EXT: out_buf <= INC;
                            MODE_DEC_9999: out_buf <= DEC;
                            MODE_DEC_EXT: out_buf <= DEC;
                        endcase 
                    end else out_buf <= HOLD;
                end 
                
                DONE: begin
                    if (reset) begin
                        state <= INC_DEC;
                        case (mode)
                            MODE_INC_0: out_buf <= LOAD_0;
                            MODE_INC_EXT: out_buf <= LOAD_EXT;
                            MODE_DEC_9999: out_buf <= LOAD_9999;
                            MODE_DEC_EXT: out_buf <= LOAD_EXT;
                        endcase 
                    end else out_buf <= HOLD;
                end
             endcase  
         end
    end
endmodule
