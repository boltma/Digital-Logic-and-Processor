`timescale 1ns/1ps
`define PERIOD 10

module test_tb;
reg [1:0] testmode;
reg sysclk;
reg modecontrol;
wire highfreq;
wire [7:0] cathodes;
wire [3:0] AN;

test u_test (
		 .testmode                ( testmode     [1:0] ),
		 .sysclk                  ( sysclk             ),
		 .modecontrol             ( modecontrol        ),

		 .highfreq                ( highfreq           ),
		 .cathodes                ( cathodes     [7:0] ),
		 .AN                      ( AN           [3:0] )
	 );

initial begin
	testmode <= 2'b00;
	sysclk <= 0;
	modecontrol <= 0;
end

initial fork
	forever
		#(`PERIOD/2) sysclk <= ~sysclk;
	#3000000 testmode <= 2'b01;
	#6000000 testmode <= 2'b10;
	#9000000 testmode <= 2'b11;
	#12000000 modecontrol <= 1;
	#12000000 testmode <= 2'b00;
	#15000000 testmode <= 2'b01;
	#18000000 testmode <= 2'b10;
	#21000000 testmode <= 2'b11;
	#24000000 $finish;
join

endmodule
