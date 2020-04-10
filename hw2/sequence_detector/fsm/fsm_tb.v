`timescale 1ns/1ps
`define PERIOD 10

module fsm_tb;
reg reset;
reg clk;
reg in;
wire out;

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

fsm t_fsm (
        .clk(clk),
        .reset(reset),
        .in(in),
        .out(out)
    );

endmodule
