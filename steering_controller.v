`timescale 1ns / 1ps
module steering_controller(
    input wire clk,
    input wire reset,
    input wire frame_pulse,
    input wire left_btn,
    input wire right_btn,
    output reg signed [10:0] lateral_offset
);
    localparam STEER_SPEED = 3;
    localparam MAX_OFFSET = 80;
    
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            lateral_offset <= 0;
        end else if(frame_pulse) begin
            if(left_btn && !right_btn && lateral_offset > -MAX_OFFSET) begin
                lateral_offset <= lateral_offset - STEER_SPEED;
            end
            else if(right_btn && !left_btn && lateral_offset < MAX_OFFSET) begin
                lateral_offset <= lateral_offset + STEER_SPEED;
            end
            else if(!left_btn && !right_btn) begin
                if(lateral_offset > 2)
                    lateral_offset <= lateral_offset - 2;
                else if(lateral_offset < -2)
                    lateral_offset <= lateral_offset + 2;
                else
                    lateral_offset <= 0;
            end
        end
    end
endmodule