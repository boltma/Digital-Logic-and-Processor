module detector (clk, reset, in, out, register);
input clk, reset, in;
output out;
output [5:0] register;

reg out;
wire [5:0] register;

shift_register sr(clk, reset, in, register);

always @(register) begin
	if (register[5:0] == 6'b110101) // register stores reverse of 101011
		out <= 1;
	else
		out <= 0;
end
endmodule
