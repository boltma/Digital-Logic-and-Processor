module fsm (clk, reset, in, out);
input clk, reset, in;
output out;
reg out;

reg [2:0] current_state, next_state;
localparam A=3'b000;
localparam B=3'b001;
localparam C=3'b011;
localparam D=3'b110;
localparam E=3'b101;
localparam F=3'b010;

always @(negedge reset or posedge clk) begin
    if (~reset)
        current_state <= A;
    else
        current_state <= next_state;
end

always @(current_state or in) begin
    case (current_state)
        A: next_state <= in ? B : A;
		B: next_state <= in ? B : C;
		C: next_state <= in ? D : A;
		D: next_state <= in ? B : E;
		E: next_state <= in ? F : A;
		F: next_state <= in ? B : E;
		default: next_state <= A;
    endcase
end

always @(negedge reset or posedge clk) begin
	if (~reset)
        out <= 0;
    else
		out <= (current_state == F && in) ? 1 : 0;
end
endmodule
