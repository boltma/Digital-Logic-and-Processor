module range (range, sigin, sigout);
input range, sigin;
output sigout;
reg sig10;
reg [4:0] state;

assign sigout = range ? sig10 : sigin;

initial begin
    state <= 0;
    sig10 <= 0;
end

always @(posedge sigin) begin
    if (state == 0)
        sig10 = ~sig10;
    state = state + 4'd2;
    if (state == 4'd10)
        state = 4'b0;
end

endmodule
