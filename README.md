# Функциональная схемотехника. Лабораторная работа 1. 

Вариант: 
  - Базиз: `NOR`
  - БОЭ: Мультиплексор "4 в 1"

## Часть 1

Схема вентиля:

![image](https://user-images.githubusercontent.com/68964770/221428737-219df699-5189-4d3a-b2a1-c1de17da2858.png)

Символ вентиля:

![image](https://user-images.githubusercontent.com/68964770/221428748-13ea6af5-e1eb-4cbb-8de4-494e1fce4116.png)

Формат и диаграмма тестирования вентиля:

![image](https://user-images.githubusercontent.com/68964770/221428833-cd277a95-3bd9-41e7-97eb-8afd8c5357c4.png)

![image](https://user-images.githubusercontent.com/68964770/221428839-d740c52a-b6c1-4c68-b299-5cff20c18577.png)

![image](https://user-images.githubusercontent.com/68964770/221428848-f30e20b9-8dd6-4c59-a776-7e0fc35726c1.png)

- Задержка распространения сигнала: 2.6нс
- Максимальная частота:


Схема БОЭ:

![image](https://user-images.githubusercontent.com/68964770/221428891-72d237f7-bc0e-4f4e-8447-091503ac8b7d.png)

Символ разработанного БОЭ и схема тестирования:

![image](https://user-images.githubusercontent.com/68964770/221428941-287f19cc-7c61-4030-997d-a58cc283e960.png)

*схема тестирования in progress*

![image](https://user-images.githubusercontent.com/68964770/221429085-4b8b8f97-1c70-46c4-9218-07edbb1714f4.png)

Временная диаграмма процесса тестирования БОЭ:

![image](https://user-images.githubusercontent.com/68964770/221429092-6d86376c-50d0-4726-ba59-e6d843022f7f.png)

Результат измерения задержки распространения сигнала через БОЭ:

![image](https://user-images.githubusercontent.com/68964770/221429088-da9f6e8d-f029-40cc-a6cc-4deba5cb1418.png)

- Задержка: 2.5нс
- Максимальная частота:

## Часть 2


```verilog

timescale 1ns / 1ps
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




timescale 1ns / 1ps
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
```

## Вывод




