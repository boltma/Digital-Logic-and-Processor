module BCD7(
	din,
	dout,
    EN
);
input 	[3:0]	din;
output 	[7:0] 	dout;
output  EN;

wire [7:0] dout;
wire EN;

assign  EN=0;
assign	dout=(din==4'h0)?8'b10000001:
             (din==4'h1)?8'b11110011:
             (din==4'h2)?8'b01001001:
             (din==4'h3)?8'b01100001:
             (din==4'h4)?8'b00110011:
             (din==4'h5)?8'b00100101:
             (din==4'h6)?8'b00000101:
             (din==4'h7)?8'b11110001:
             (din==4'h8)?8'b00000001:
             (din==4'h9)?8'b00100001:8'b11111111;
endmodule

