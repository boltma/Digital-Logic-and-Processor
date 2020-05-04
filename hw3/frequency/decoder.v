module decoder (clk, count, leds, EN);
input clk;
input [15:0] count;
output [7:0] leds;
output [3:0] EN;

wire [15:0] count;
wire [7:0] leds;
reg [3:0] EN;
reg [3:0] cur_count;

BCD7 bcd7 (cur_count, leds);

initial begin
    EN <= 4'b0111;
end

always @(posedge clk) begin
    case (EN)
        4'b0111: begin
            EN <= 4'b1011;
            cur_count <= count[11:8];
        end
        4'b1011: begin
            EN <= 4'b1101;
            cur_count <= count[7:4];
        end
        4'b1101: begin
            EN <= 4'b1110;
            cur_count <= count[3:0];
        end
        4'b1110: begin
            EN <= 4'b0111;
            cur_count <= count[15:12];
        end
        default: begin
            EN <= 4'b1111;
            cur_count <= 4'b0000;
        end
    endcase
end

endmodule
