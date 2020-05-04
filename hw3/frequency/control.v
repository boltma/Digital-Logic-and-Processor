module control (clk, reset, enable, latch);
input clk;
output reset, enable, latch;

reg [1:0] state;
reg reset, enable, latch;

initial begin
    state <= 2'b00;
    reset <= 0;
    enable <= 0;
    latch <= 1;
end

always @(posedge clk) begin
    case (state)
        2'b00: begin
            state <= 2'b01;
            reset <= 1;
            enable <= 1;
            latch <= 1;
        end
        2'b01: begin
            state <= 2'b10;
            reset <= 1;
            enable <= 0;
            latch <= 0;
        end
        2'b10: begin
            state <= 2'b00;
            reset <= 0;
            enable <= 0;
            latch <= 1;
        end
        default: begin
            state <= 2'b00;
            reset <= 0;
            enable <= 1;
            latch <= 1;
        end
    endcase
end

endmodule
