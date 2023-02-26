`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.02.2023 10:09:38
// Design Name: 
// Module Name: adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module orrer(
    input a,
    input b,
    output c
    );
    wire nor_result;
    nor(nor_result, a, b);
    nor(c, nor_result, nor_result);
endmodule

module ander(
    input a,
    input b,
    output c
    );
    wire not_a, not_b, not_c;
    nor(not_a, a, a);
    nor(not_b, b, b);
    orrer orrer_1(.a(not_a), .b(not_b), .c(not_c));
    nor(c, not_c, not_c);
endmodule

module multuplexor(
    input s0,
    input s1,
    input d0,
    input d1,
    input d2,
    input d3,
    output c
    );
    
    wire not_s0, not_s1, sd0, sd1, sd2, sd3, res0, res1, res2, res3, final_0, final_1;
   
    nor(not_s0, s0, s0);
    nor(not_s1, s1, s1);
    
    ander ander_sd0(.a(not_s0), .b(not_s1), .c(sd0));
    ander ander_sd1(.a(not_s0), .b(s1), .c(sd1));
    ander ander_sd2(.a(s0), .b(not_s1), .c(sd2));
    ander ander_sd3(.a(s0), .b(s1), .c(sd3));
    
    ander ander_d0(.a(sd0), .b(d0), .c(res0));
    ander ander_d1(.a(sd1), .b(d1), .c(res1));
    ander ander_d2(.a(sd2), .b(d2), .c(res2));
    ander ander_d3(.a(sd3), .b(d3), .c(res3));
    
    orrer orrer_1(.a(res0), .b(res1), .c(final_0));
    orrer orrer_2(.a(res2), .b(res3), .c(final_1));
    
    orrer orrer_3(.a(final_0), .b(final_1), .c(c));
    
endmodule
