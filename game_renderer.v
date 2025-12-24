`timescale 1ns / 1ps
module game_renderer(
    input wire [9:0] x,
    input wire [9:0] y,
    input wire video_on,
    input wire [9:0] frame_offset,
    input wire signed [10:0] lateral_offset,
    output reg [3:0] red,
    output reg [3:0] green,
    output reg [3:0] blue
);
    localparam VEHICLE_X = 305;
    localparam VEHICLE_Y = 380;
    localparam VEHICLE_WIDTH = 40;
    localparam VEHICLE_HEIGHT = 60;
    
    localparam ROAD_BASE_WIDTH = 220;
    localparam SCREEN_CENTER = 320;
    
    wire [9:0] y_scroll;
    assign y_scroll = (y + frame_offset) & 10'h1FF;
    
    reg signed [11:0] road_center;
    reg [9:0] road_width;
    
    wire [5:0] curve_index;
    assign curve_index = y_scroll[8:3];
    
    reg signed [7:0] sine_value;
    
    always @(*) begin
        case(curve_index)
            6'd0:  sine_value = 0;
            6'd1:  sine_value = 8;
            6'd2:  sine_value = 16;
            6'd3:  sine_value = 24;
            6'd4:  sine_value = 31;
            6'd5:  sine_value = 38;
            6'd6:  sine_value = 45;
            6'd7:  sine_value = 51;
            6'd8:  sine_value = 57;
            6'd9:  sine_value = 62;
            6'd10: sine_value = 67;
            6'd11: sine_value = 71;
            6'd12: sine_value = 74;
            6'd13: sine_value = 77;
            6'd14: sine_value = 79;
            6'd15: sine_value = 80;
            6'd16: sine_value = 80;
            6'd17: sine_value = 80;
            6'd18: sine_value = 79;
            6'd19: sine_value = 77;
            6'd20: sine_value = 74;
            6'd21: sine_value = 71;
            6'd22: sine_value = 67;
            6'd23: sine_value = 62;
            6'd24: sine_value = 57;
            6'd25: sine_value = 51;
            6'd26: sine_value = 45;
            6'd27: sine_value = 38;
            6'd28: sine_value = 31;
            6'd29: sine_value = 24;
            6'd30: sine_value = 16;
            6'd31: sine_value = 8;
            6'd32: sine_value = 0;
            6'd33: sine_value = -8;
            6'd34: sine_value = -16;
            6'd35: sine_value = -24;
            6'd36: sine_value = -31;
            6'd37: sine_value = -38;
            6'd38: sine_value = -45;
            6'd39: sine_value = -51;
            6'd40: sine_value = -57;
            6'd41: sine_value = -62;
            6'd42: sine_value = -67;
            6'd43: sine_value = -71;
            6'd44: sine_value = -74;
            6'd45: sine_value = -77;
            6'd46: sine_value = -79;
            6'd47: sine_value = -80;
            6'd48: sine_value = -80;
            6'd49: sine_value = -80;
            6'd50: sine_value = -79;
            6'd51: sine_value = -77;
            6'd52: sine_value = -74;
            6'd53: sine_value = -71;
            6'd54: sine_value = -67;
            6'd55: sine_value = -62;
            6'd56: sine_value = -57;
            6'd57: sine_value = -51;
            6'd58: sine_value = -45;
            6'd59: sine_value = -38;
            6'd60: sine_value = -31;
            6'd61: sine_value = -24;
            6'd62: sine_value = -16;
            6'd63: sine_value = -8;
        endcase
        
        road_center = SCREEN_CENTER + sine_value + lateral_offset;
        road_width = ROAD_BASE_WIDTH + (y >> 3);
    end
    
    wire signed [11:0] road_left_calc, road_right_calc;
    reg [9:0] road_left, road_right;
    
    assign road_left_calc = road_center - (road_width >> 1);
    assign road_right_calc = road_center + (road_width >> 1);
    
    always @(*) begin
        if(road_left_calc < 0)
            road_left = 0;
        else if(road_left_calc > 639)
            road_left = 639;
        else
            road_left = road_left_calc[9:0];
            
        if(road_right_calc < 0)
            road_right = 0;
        else if(road_right_calc > 639)
            road_right = 639;
        else
            road_right = road_right_calc[9:0];
    end
    
    wire in_vehicle_body, in_vehicle_window, in_vehicle_wheel_left, in_vehicle_wheel_right;
    
    assign in_vehicle_body = (x >= VEHICLE_X) && (x < VEHICLE_X + VEHICLE_WIDTH) &&
                             (y >= VEHICLE_Y) && (y < VEHICLE_Y + VEHICLE_HEIGHT);
    
    assign in_vehicle_window = (x >= VEHICLE_X + 6) && (x < VEHICLE_X + VEHICLE_WIDTH - 6) &&
                               (y >= VEHICLE_Y + 4) && (y < VEHICLE_Y + 24);
    
    assign in_vehicle_wheel_left = (x >= VEHICLE_X - 2) && (x < VEHICLE_X + 8) &&
                                   (y >= VEHICLE_Y + 42) && (y < VEHICLE_Y + 55);
    
    assign in_vehicle_wheel_right = (x >= VEHICLE_X + VEHICLE_WIDTH - 8) && 
                                    (x < VEHICLE_X + VEHICLE_WIDTH + 2) &&
                                    (y >= VEHICLE_Y + 42) && (y < VEHICLE_Y + 55);
    
    wire in_vehicle;
    assign in_vehicle = in_vehicle_body || in_vehicle_wheel_left || in_vehicle_wheel_right;
    
    wire on_road;
    assign on_road = (x >= road_left) && (x <= road_right);
    
    wire [8:0] dash_y;
    assign dash_y = (y_scroll + frame_offset) & 9'h1FF;
    
    reg signed [11:0] road_center_safe;
    always @(*) begin
        if(road_center < 3)
            road_center_safe = 3;
        else if(road_center > 636)
            road_center_safe = 636;
        else
            road_center_safe = road_center;
    end
    
    wire center_line;
    assign center_line = (x >= road_center_safe - 3) && (x <= road_center_safe + 3) && 
                         ((dash_y & 9'h3F) < 32) && on_road;
    
    wire left_edge, right_edge;
    assign left_edge = (road_left >= 4) && (x >= road_left - 4) && (x <= road_left + 2);
    assign right_edge = (road_right <= 635) && (x >= road_right - 2) && (x <= road_right + 4);
    
    wire left_rumble, right_rumble;
    assign left_rumble = on_road && (road_left + 10 <= 639) && 
                        (x >= road_left + 3) && (x <= road_left + 10) &&
                        ((y_scroll[4:0] & 5'h10) != 0);
    assign right_rumble = on_road && (road_right >= 10) &&
                         (x >= road_right - 10) && (x <= road_right - 3) &&
                         ((y_scroll[4:0] & 5'h10) != 0);
    
    // Thruster glow effect (animated)
    wire thruster_left, thruster_right;
    wire [2:0] thruster_intensity;
    assign thruster_intensity = y_scroll[2:0];
    
    assign thruster_left = (x >= VEHICLE_X + 2) && (x < VEHICLE_X + 8) &&
                          (y >= VEHICLE_Y + VEHICLE_HEIGHT - 2) && (y < VEHICLE_Y + VEHICLE_HEIGHT + 4);
    assign thruster_right = (x >= VEHICLE_X + VEHICLE_WIDTH - 8) && (x < VEHICLE_X + VEHICLE_WIDTH - 2) &&
                           (y >= VEHICLE_Y + VEHICLE_HEIGHT - 2) && (y < VEHICLE_Y + VEHICLE_HEIGHT + 4);
    
    // Stars in background
    wire is_star;
    assign is_star = ((x[3:0] ^ y[4:1] ^ frame_offset[3:0]) == 4'b1111) ||
                     ((x[4:1] ^ y[3:0] ^ frame_offset[4:1]) == 4'b0101);
    
    always @(*) begin
        if(video_on) begin
            if(thruster_left || thruster_right) begin
                // Thrusters - Animated cyan/blue glow
                red = 4'h2 + thruster_intensity[1:0];
                green = 4'h8 + thruster_intensity[2:1];
                blue = 4'hF;
            end
            else if(in_vehicle_window) begin
                // Window - Glowing purple
                red = 4'h8;
                green = 4'h0;
                blue = 4'hF;
            end
            else if(in_vehicle_wheel_left || in_vehicle_wheel_right) begin
                // Wheels - Dark metallic
                red = 4'h3;
                green = 4'h3;
                blue = 4'h5;
            end
            else if(in_vehicle_body) begin
                // Vehicle body - Futuristic silver/white
                red = 4'hD;
                green = 4'hD;
                blue = 4'hF;
            end
            else if(center_line) begin
                // Center line - Bright glowing cyan
                red = 4'h0;
                green = 4'hF;
                blue = 4'hF;
            end
            else if(left_rumble || right_rumble) begin
                // Rumble strips - Glowing purple
                red = 4'hC;
                green = 4'h0;
                blue = 4'hF;
            end
            else if(left_edge || right_edge) begin
                // Track edges - Bright glowing blue
                red = 4'h0;
                green = 4'h8;
                blue = 4'hF;
            end
            else if(on_road) begin
                // Track surface - Dark purple with glow pattern
                if((x[2:0] ^ y[2:0]) == 3'b111) begin
                    red = 4'h5;
                    green = 4'h0;
                    blue = 4'h8;
                end else begin
                    red = 4'h3;
                    green = 4'h0;
                    blue = 4'h6;
                end
            end
            else begin
                // Space background - Deep space with stars
                if(is_star) begin
                    // Twinkling stars
                    red = 4'hF;
                    green = 4'hF;
                    blue = 4'hF;
                end else if((x[4:0] ^ y[5:1]) == 5'b11010) begin
                    // Distant galaxies - purple tint
                    red = 4'h3;
                    green = 4'h1;
                    blue = 4'h4;
                end else begin
                    // Deep space - dark blue/purple
                    red = 4'h0;
                    green = 4'h0;
                    blue = 4'h2;
                end
            end
        end else begin
            red = 4'h0;
            green = 4'h0;
            blue = 4'h0;
        end
    end
endmodule