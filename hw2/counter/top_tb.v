`timescale 1ns/1ps
`define PERIOD 10

module top_tb;
reg reset;
reg clk;
wire [7:0] leds;
wire EN;

initial begin
    reset <= 0;
    clk <= 0;
end

initial fork
    #150 reset <= 1;
    #380 reset <= 0;
    forever
        #(`PERIOD/2) clk <= ~clk;
    #400 $finish;
join

top counter_top (
        .reset (reset),
        .clk (clk),
        .leds (leds),
        .EN (EN)
    );

endmodule
