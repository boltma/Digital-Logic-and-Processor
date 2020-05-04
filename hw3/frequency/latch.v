module latch(lock, in, out);
input lock;
input [15:0] in;
output [15:0] out;
reg [15:0] out;

always @(*) begin
    if (~lock)
        out <= in;
end

endmodule
