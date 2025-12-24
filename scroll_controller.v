`timescale 1ns / 1ps
module scroll_controller(
    input wire clk,
    input wire reset,
    input wire frame_pulse,
    output reg [9:0] frame_offset
);
    localparam SCROLL_SPEED = 3;
    localparam SCROLL_PERIOD = 512;
    
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            frame_offset <= 0;
        end else if(frame_pulse) begin
            if(frame_offset >= SCROLL_PERIOD - SCROLL_SPEED)
                frame_offset <= 0;
            else
                frame_offset <= frame_offset + SCROLL_SPEED;
        end
    end
endmodule
