module clock (sysclk, scan_clk, control_clk);
input sysclk;		// 100MHz
output scan_clk;	// 1kHz
output control_clk;	// 1Hz
reg scan_clk, control_clk;
reg [16:0] scan_state;
reg [9:0] control_state;

initial begin
	scan_state <= 0;
	control_state <= 0;
	scan_clk <= 0;
	control_clk <= 0;
end

always @(posedge sysclk) begin
	if (scan_state == 0)
		scan_clk = ~scan_clk;
		scan_state = scan_state + 17'd2;
	if (scan_state == 17'd100000)
		scan_state = 17'b0;
end

always @(posedge scan_clk) begin
	if (control_state == 0)
		control_clk = ~control_clk;
	control_state = control_state + 10'd2;
	if (control_state == 10'd1000)
		control_state = 10'b0;
end

endmodule
