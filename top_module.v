module top_module(
    input wire clk,              // 100MHz board clock
    input wire reset,
    input wire left_btn,         // Steer left
    input wire right_btn,        // Steer right
    output wire hsync,
    output wire vsync,
    output wire [3:0] red,
    output wire [3:0] green,
    output wire [3:0] blue
);
    wire clk_25mhz;
    wire [9:0] x, y;
    wire video_on;
    wire [9:0] frame_offset;
    wire signed [10:0] lateral_offset;
    wire frame_pulse;
    
    // Clock divider: 100MHz -> 25MHz
    clock_divider clk_div(
        .clk_in(clk),
        .reset(reset),
        .clk_out(clk_25mhz)
    );
    
    // VGA sync generator
    vga_sync sync(
        .clk(clk_25mhz),
        .reset(reset),
        .hsync(hsync),
        .vsync(vsync),
        .x(x),
        .y(y),
        .video_on(video_on),
        .frame_pulse(frame_pulse)
    );
    
    // Scrolling controller - updates frame offset
    scroll_controller scroller(
        .clk(clk_25mhz),
        .reset(reset),
        .frame_pulse(frame_pulse),
        .frame_offset(frame_offset)
    );
    
    // Steering controller - handles left/right buttons
    steering_controller steering(
        .clk(clk_25mhz),
        .reset(reset),
        .frame_pulse(frame_pulse),
        .left_btn(left_btn),
        .right_btn(right_btn),
        .lateral_offset(lateral_offset)
    );
    
    // Game renderer - draws road and vehicle
    game_renderer renderer(
        .x(x),
        .y(y),
        .video_on(video_on),
        .frame_offset(frame_offset),
        .lateral_offset(lateral_offset),
        .red(red),
        .green(green),
        .blue(blue)
    );
endmodule
