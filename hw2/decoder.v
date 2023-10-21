module decoder(A_out, WEN_out, CEN_out, A_in, WEN_in, CEN_in);

output reg [13:0]   A_out;
output reg [15:0]   WEN_out, CEN_out;
input [17:0]        A_in;
input               WEN_in, CEN_in;



function [15:0] binary_to_onehot;
    input [3:0]      binary;
    begin
        if(binary == 4'd15)
            binary_to_onehot = ~16'd32768;
        else if(binary == 4'd14)
            binary_to_onehot = ~16'd16384;
        else if(binary == 4'd13)
            binary_to_onehot = ~16'd8192; 
        else if(binary == 4'd12)
            binary_to_onehot = ~16'd4096;
        else if(binary == 4'd11)
            binary_to_onehot = ~16'd2048;
        else if(binary == 4'd10)
            binary_to_onehot = ~16'd1024;
        else if(binary == 4'd9)
            binary_to_onehot = ~16'd512;
        else if(binary == 4'd8)
            binary_to_onehot = ~16'd256;
        else if(binary == 4'd7)
            binary_to_onehot = ~16'd128;
        else if(binary == 4'd6)
            binary_to_onehot = ~16'd64;
        else if(binary == 4'd5)
            binary_to_onehot = ~16'd32;
        else if(binary == 4'd4)
            binary_to_onehot = ~16'd16;
        else if(binary == 4'd3)
            binary_to_onehot = ~16'd8;
        else if(binary == 4'd2)
            binary_to_onehot = ~16'd4;
        else if(binary == 4'd1)
            binary_to_onehot = ~16'd2;
        else
            binary_to_onehot = ~16'd1;
    end
endfunction

always @(A_in or CEN_in or WEN_in)
begin
    if(~WEN_in)
    begin
        WEN_out = binary_to_onehot(A_in[17:14]);
    end
    else
    begin
        WEN_out = 16'hffff;
    end
    if(~CEN_in)
    begin
        CEN_out = binary_to_onehot(A_in[17:14]);
    end
    else
    begin
        CEN_out = 16'hffff;
    end
    A_out = A_in[13:0];
end
endmodule
