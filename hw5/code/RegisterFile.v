
module RegisterFile(control, reset, clk, RegWrite, Read_register1, Read_register2, Write_register, Write_data, Read_data1, Read_data2, register);
	input reset, clk;
	input RegWrite;
	input [4:0] Read_register1, Read_register2, Write_register;
	input [31:0] Write_data;
	input [1:0] control;
	output [31:0] Read_data1, Read_data2;
	output [7:0] register;
	
	reg [31:0] RF_data[31:1];
	
	assign Read_data1 = (Read_register1 == 5'b00000)? 32'h00000000: RF_data[Read_register1];
	assign Read_data2 = (Read_register2 == 5'b00000)? 32'h00000000: RF_data[Read_register2];
	assign register = (control == 2'b00)? RF_data[4][7:0]:
					  (control == 2'b01)? RF_data[2][7:0]:
					  (control == 2'b10)? RF_data[29][7:0]: RF_data[31][7:0];
	
	integer i;
	always @(posedge reset or posedge clk)
		if (reset)
			for (i = 1; i < 32; i = i + 1)
				RF_data[i] <= 32'h00000000;
		else if (RegWrite && (Write_register != 5'b00000))
			RF_data[Write_register] <= Write_data;

endmodule
			