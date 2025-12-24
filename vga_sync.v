`timescale 1ns / 1ps
module vga_sync(
    input wire clk,           
    input wire reset,
    output reg hsync,
    output reg vsync,
    output reg [9:0] x,       
    output reg [9:0] y,       
    output reg video_on,
    output reg frame_pulse
);
    localparam H_DISPLAY = 640;
    localparam H_FRONT = 16;
    localparam H_SYNC = 96;
    localparam H_BACK = 48;
    localparam H_TOTAL = 800;
    
    localparam V_DISPLAY = 480;
    localparam V_FRONT = 10;
    localparam V_SYNC = 2;
    localparam V_BACK = 33;
    localparam V_TOTAL = 525;
    
    reg [9:0] h_count, v_count;
    
    always @(posedge clk or posedge reset) begin
        if(reset)
            h_count <= 0;
        else if(h_count == H_TOTAL - 1)
            h_count <= 0;
        else
            h_count <= h_count + 1;
    end
    
    always @(posedge clk or posedge reset) begin
        if(reset)
            v_count <= 0;
        else if(h_count == H_TOTAL - 1) begin
            if(v_count == V_TOTAL - 1)
                v_count <= 0;
            else
                v_count <= v_count + 1;
        end
    end
    
    always @(posedge clk or posedge reset) begin
        if(reset)
            frame_pulse <= 0;
        else
            frame_pulse <= (h_count == 0 && v_count == 0);
    end
    
    always @(*) begin
        hsync = ~((h_count >= (H_DISPLAY + H_FRONT)) && 
                  (h_count < (H_DISPLAY + H_FRONT + H_SYNC)));
        vsync = ~((v_count >= (V_DISPLAY + V_FRONT)) && 
                  (v_count < (V_DISPLAY + V_FRONT + V_SYNC)));
    end
    
    always @(*) begin
        if(h_count < H_DISPLAY && v_count < V_DISPLAY) begin
            video_on = 1;
            x = h_count;
            y = v_count;
        end else begin
            video_on = 0;
            x = 0;
            y = 0;
        end
    end
endmodule
