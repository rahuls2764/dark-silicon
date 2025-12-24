`timescale 1ns / 1ps
module clock_divider(
    input wire clk_in,      
    input wire reset,
    output reg clk_out      
);
    reg [1:0] counter;
    
    always @(posedge clk_in or posedge reset) begin
        if(reset) begin
            counter <= 2'd0;
            clk_out <= 1'b0;
        end else begin
            counter <= counter + 2'd1;
            if(counter == 2'd1 || counter == 2'd3)
                clk_out <= ~clk_out;
        end
    end
endmodule