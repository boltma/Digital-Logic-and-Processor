module top (reset, clk, leds, EN);
input reset;
input clk;
output [7:0] leds;
output EN;

wire [7:0] leds;
wire [3:0] bcd;
wire EN;

counter cnt (reset, clk, bcd);
BCD7 bcd7 (bcd, leds, EN);

endmodule
