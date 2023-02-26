`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.02.2023 10:24:42
// Design Name: 
// Module Name: adder_tb
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


module adder_tb;

    reg s_0, s_1, d_0, d_1, d_2, d_3;
    wire c_out;
    
    multuplexor multuplexor_1(
        .s0(s_0),
        .s1(s_1),
        .d0(d_0),
        .d1(d_1),
        .d2(d_2),
        .d3(d_3),
        .c(c_out)
    );
    
    integer i;
    reg [5:0] test_val;
    reg expected_val;
    
    initial begin
        for (i = 0; i < 64; i = i + 1) begin
            test_val = i;
            s_0 = test_val[0];
            s_1 = test_val[1];
            d_0 = test_val[2];
            d_1 = test_val[3];
            d_2 = test_val[4];
            d_3 = test_val[5];
            
            if (s_0 == 0 & s_1 == 0) begin
                expected_val = d_0;
            end else begin
                if (s_0 == 0 & s_1 == 1) begin
                    expected_val = d_1;
                end else begin
                    if (s_0 == 1 & s_1 == 0) begin
                        expected_val = d_2;
                    end else begin
                        expected_val = d_3;
                    end
                end
            end
            
            #10
            
            if (c_out == expected_val) begin
                $display("YES, s_0=%b, s_1=%b, d_0=%b, d_1=%b, d_2=%b, d_3=%b, c_out=%b",
                    s_0, s_1, d_0, d_1, d_2, d_3, c_out);
            end else begin
                $display("NO, s_0=%b, s_1=%b, d_0=%b, d_1=%b, d_2=%b, d_3=%b, c_out=%b",
                    s_0, s_1, d_0, d_1, d_2, d_3, c_out);
            end
          end
        #10 $stop;
    end 

endmodule
