`timescale 1ns / 1ps
module sim_SRAM();
reg         CLK=1'b0;
reg  [7:0]  D=8'b0;
reg         CEN=1'b1, WEN=1'b1;
reg  [13:0] A=14'b0;
wire [7:0]  Q;

SRAM uut(Q, CLK, CEN, WEN, A, D, 3'b0);

always
begin
    #5 CLK=~CLK;
end

initial 
begin
    #0;     WEN=0;CEN=0;A=18'b10101010101010;D=8'b11111111;
    #10     WEN=1;CEN=1;
    #10;    WEN=0;CEN=0;A=18'b01010101010101;D=8'b10101010;     
    #10;    WEN=1;CEN=0;A=18'b10101010101010;
    #10;    WEN=1;CEN=1;
    #10;    WEN=1;CEN=1;A=18'b01010101010101;D=8'b00000000;
    #10;    WEN=0;CEN=0;A=18'b01010101010101;D=8'b10101011;
    #10;    WEN=0;CEN=0;A=18'b11111111111111;D=8'b10101111;
    #10;    WEN=1;CEN=0;A=18'b11111111111111;
    #10;    WEN=1;CEN=0;A=18'b01010101010101;
    #30;
    $finish;
end

endmodule 
