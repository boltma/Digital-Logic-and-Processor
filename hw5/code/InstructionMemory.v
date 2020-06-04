
module InstructionMemory(Address, Instruction);
	input [31:0] Address;
	output reg [31:0] Instruction;
	
	always @(*)
		case (Address[9:2])
			8'd0: Instruction <= 32'h20040003;
			8'd1: Instruction <= 32'h0c000003;
			8'd2: Instruction <= 32'h1000ffff;
			8'd3: Instruction <= 32'h23bdfff8;
			8'd4: Instruction <= 32'hafbf0004;
			8'd5: Instruction <= 32'hafa40000;
			8'd6: Instruction <= 32'h28880001;
			8'd7: Instruction <= 32'h11000003;
			8'd8: Instruction <= 32'h00001026;
			8'd9: Instruction <= 32'h23bd0008;
			8'd10: Instruction <= 32'h03e00008;
			8'd11: Instruction <= 32'h2084ffff;
			8'd12: Instruction <= 32'h0c000003;
			8'd13: Instruction <= 32'h8fa40000;
			8'd14: Instruction <= 32'h8fbf0004;
			8'd15: Instruction <= 32'h23bd0008;
			8'd16: Instruction <= 32'h00821020;
			8'd17: Instruction <= 32'h03e00008;
			default: Instruction <= 32'h00000000;
		endcase
		
endmodule
