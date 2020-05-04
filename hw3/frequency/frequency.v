module frequency (sigin, sysclk, modecontrol, highfreq, cathodes, AN);
input sigin, sysclk, modecontrol;
output highfreq;
output [7:0] cathodes;
output [3:0] AN;

wire [15:0] count, latch_out;
wire scan_clk, control_clk, reset, enable, latch, sig;

assign highfreq = modecontrol;
clock clk(.sysclk(sysclk), .scan_clk(scan_clk), .control_clk(control_clk));
counter c(.reset(reset), .enable(enable), .sig(sig), .out(count));
control ctrl(.clk(control_clk), .reset(reset), .enable(enable), .latch(latch));
range r(.range(modecontrol), .sigin(sigin), .sigout(sig));
latch l(.lock(latch), .in(count), .out(latch_out));
decoder d(.clk(scan_clk), .count(latch_out), .leds(cathodes), .EN(AN));

endmodule
