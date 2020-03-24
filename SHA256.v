// round compression function
module sha256_round (
    input [31:0] Kt, Wt,
    input [31:0] a_in, b_in, c_in, d_in, e_in, f_in, g_in, h_in,
    output [31:0] a_out, b_out, c_out, d_out, e_out, f_out, g_out, h_out
);
    wire [31:0] ch, maj_abc, s0, s1, t1, t2;
    Ch Ch0(.x(e_in), .y(f_in), .z(g_in), .Ch(ch));
    Maj Maj0(.x(a_in), .y(b_in), .z(c_in), .Maj(maj_abc));
    sha256_S0 s0_a(.x(a_in), .S0(s0));
    sha256_S1 s1_e(.x(e_in), .S1(s1));
    assign t1 = h_in + s1 + ch + Kt + Wt;
    assign t2 = s0 + maj_abc;
    assign a_out = t1 + t2;
    assign b_out = a_in;
    assign c_out = b_in;
    assign d_out = c_in;
    assign e_out = d_in + t1;
    assign f_out = e_in;
    assign g_out = f_in;
    assign h_out = g_in;
endmodule

// Σ₀(x)
module sha256_S0 (
    input wire [31:0] x,
    output wire [31:0] S0
);
    assign S0 = ({x[1:0], x[31:2]} ^ {x[12:0], x[31:13]} ^ {x[21:0], x[31:22]});
endmodule

// Σ₁(x)
module sha256_S1 (
    input wire [31:0] x,
    output wire [31:0] S1
);
    assign S1 = ({x[5:0], x[31:6]} ^ {x[10:0], x[31:11]} ^ {x[24:0], x[31:25]});
endmodule

// Ch(x,y,z)
module Ch (
    input wire [31:0] x, y, z,
    output wire [31:0] Ch
);
    assign Ch = ((x & y) ^ (~x & z));
endmodule

// Maj(x,y,z)
module Maj (
    input wire [31:0] x, y, z,
    output wire [31:0] Maj
);
    assign Maj = ((x & y) ^ (y & z) ^ (z & x));
endmodule