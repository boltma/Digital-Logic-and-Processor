module counter (reset, enable, sig, out);
input reset, enable, sig;
output [15:0] out;

reg [15:0] out;

initial begin
    out <= 16'b0000_0000_0000_0000;
end

always @(negedge reset or posedge sig) begin
    if (~reset)
        out <= 0;
    else if (enable) begin
        if (out[3:0] == 4'b1001) begin
            out[3:0] <= 0;
            if (out[7:4] == 4'b1001) begin
                out[7:4] <= 0;
                if (out[11:8] == 4'b1001) begin
                    out[11:8] <= 0;
                    if (out[15:12] == 4'b1001) begin
                        out[15:12] <= 0;
                    end
                    else begin
                        out[15:12] <= out[15:12] + 1;
                    end
                end
                else begin
                    out[11:8] <= out[11:8] + 1;
                end
            end
            else begin
                out[7:4] <= out[7:4] + 1;
            end
        end
        else begin
            out[3:0] <= out[3:0] + 1;
        end
    end
end

endmodule
