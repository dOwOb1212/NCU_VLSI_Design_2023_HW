.title carry_lookahead addder implement by differential logic

.protect
.lib '/cad/cic018.l' tt
.unprotect

.global VDD VSS
Vdd VDD 0 dc 3.3v
Vss VSS 0 dc 0v

.subckt inverter input output
Mp1 out in VDD VDD p_18 w= l=
Mn1 out in VSS VSS n_18 w= l=
.end


.subckt XNOR input1 not_input1 input2 not_input2 output
Mp1 out1 oup2 VDD VDD p_18 w= l=
Mp2 out2 out1 VDD VDD p_18 w= l=

.end

