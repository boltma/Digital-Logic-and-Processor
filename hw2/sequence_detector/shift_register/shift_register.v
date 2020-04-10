module shift_register (clk, reset, in, out);
input clk, reset, in;
output [5:0] out;
reg [5:0] out;

always @(negedge reset or posedge clk) begin
    if (~reset)
        out <= 0;
    else
        out <= {in, out[5:1]};
end
endmodule
