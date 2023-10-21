module SRAM_256kx8(Q, CLK, CEN, WEN, A, D);

output reg [7:0]    Q;


input               CLK, CEN, WEN;
input [17:0]        A;
input [7:0]         D;

wire [7:0]          Q_16kx8[0:15];
wire [15:0]         CEN_16kx8, WEN_16kx8;
wire [13:0]         Addr;

parameter           EMA=3'b0;



decoder decoder_256k_to_16k(Addr, WEN_16kx8, CEN_16kx8, A, WEN, CEN);

genvar i;
generate
for(i=0; i<16; i=i+1)
    SRAM unit(Q_16kx8[i], CLK, CEN_16kx8[i], WEN_16kx8[i], Addr, D, EMA);
endgenerate


always @(Q_16kx8[A[17:14]])
begin
    if(CEN)
        Q = Q;
    else
        Q = Q_16kx8[A[17:14]];
end
endmodule
