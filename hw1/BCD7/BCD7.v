module BCD7(
	din,
	dout
);
input 	[3:0]	din;
output 	[6:0] 	dout;

reg [6:0] dout;

always @(din)
begin
    case (din)
        4'h0: dout = 7'b1000000;
        4'h1: dout = 7'b1111001;
        4'h2: dout = 7'b0100100;
        4'h3: dout = 7'b0110000;
        4'h4: dout = 7'b0011001;
        4'h5: dout = 7'b0010010;
        4'h6: dout = 7'b0000010;
        4'h7: dout = 7'b1111000;
        4'h8: dout = 7'b0000000;
        4'h9: dout = 7'b0010000;
        default: dout = 7'b1111111;
    endcase
end
endmodule

