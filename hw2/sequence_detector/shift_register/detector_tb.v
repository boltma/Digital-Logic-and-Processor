`timescale 1ns/1ps
`define PERIOD 10

module detector_tb;
reg reset;
reg clk;
reg in;
wire out;
wire [5:0] register;

initial begin
    reset <= 0;
    clk <= 0;
end

initial fork
    #(`PERIOD) reset <= 1;
    forever
        #(`PERIOD/2) clk <= ~clk;
join

initial begin
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 1;
    #(`PERIOD) in = 0;
    #(`PERIOD) in = 0;
    $finish;
end

detector t_detector (
        .clk(clk),
        .reset(reset),
        .in(in),
        .out(out),
        .register(register)
    );

endmodule
