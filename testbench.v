`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2025 11:18:19
// Design Name: 
// Module Name: testbench
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


module testbench;
    reg clk, reset, left_btn, right_btn;
    wire hsync, vsync;
    wire [3:0] red, green, blue;
    
    top_module uut(
        .clk(clk),
        .reset(reset),
        .left_btn(left_btn),
        .right_btn(right_btn),
        .hsync(hsync),
        .vsync(vsync),
        .red(red),
        .green(green),
        .blue(blue)
    );
    
    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;
    
    // Test sequence
    initial begin
        $display("=== VGA Racing Game Simulation Start ===");
        reset = 1;
        left_btn = 0;
        right_btn = 0;
        
        #100 reset = 0;
        $display("Reset released at %0dns", $time);
        
        // Let it run for several frames
        #1000000;
        $display("Testing steering - Press right button");
        right_btn = 1;
        
        #2000000;
        right_btn = 0;
        $display("Testing steering - Press left button");
        left_btn = 1;
        
        #2000000;
        left_btn = 0;
        
        #5000000;
        $display("=== Simulation Complete ===");
        $finish;
    end
    
    // Monitor frame updates
    integer frame_count;
    initial frame_count = 0;
    
    always @(posedge uut.frame_pulse) begin
        frame_count = frame_count + 1;
        if(frame_count % 60 == 0) begin
            $display("Frame %0d: offset=%0d lateral=%0d", 
                     frame_count, uut.frame_offset, uut.lateral_offset);
        end
    end
endmodule
