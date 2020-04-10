module counter (reset, clk, out);
input reset;
input clk;
output [3:0] out;

reg [3:0] out;

always @(negedge reset or posedge clk) begin
    if (~reset)
        out <= 0;
    else begin
        if (out == 4'b1001)
            out <= 4'b0000;
        else
            out <= out + 1;
    end
end
endmodule
