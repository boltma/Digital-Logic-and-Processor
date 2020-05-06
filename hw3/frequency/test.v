module test(
           input [1:0] testmode,
           input sysclk,
           input modecontrol,
           output highfreq,
           output [7:0]cathodes,
           output[3:0] AN
       );
wire sigin;
siginput signalin(testmode, sysclk, sigin);
frequency freq(sigin, sysclk, modecontrol, highfreq, cathodes, AN);
endmodule
