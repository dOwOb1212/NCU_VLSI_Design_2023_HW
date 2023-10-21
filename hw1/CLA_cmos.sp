.title carry_lookahead addder implement by cmos logic

.protect
.lib '/cad/cic018.l' tt
.unprotect

.global VDD VSS
Vdd VDD 0 dc 1.8v
Vss VSS 0 dc 0v


* inverter subcircuit
.subckt inv in out
Mp1 out in VDD VDD p_18 w=0.25u l=0.18u m=1
Mn1 out in VSS VSS n_18 w=0.25u l=0.18u m=1
.ends

* and subcircuit
.subckt and in1 in2 out 
Mp1 out_t in1 VDD   VDD p_18 w=0.25u l=0.18u m=1
Mp2 out_t in2 VDD   VDD p_18 w=0.25u l=0.18u m=1
Mn1 out_t in1 in1_s VSS n_18 w=0.25u l=0.18u m=1
Mn2 in1_s in2 VSS   VSS n_18 w=0.25u l=0.18u m=1

xinv out_t out inv
.ends

* or subcircuit
.subckt or in1 in2 out
Mp1 in1_d in1 VDD   VDD p_18 w=0.25u l=0.18u m=1
Mp2 out_t in2 in1_d VDD p_18 w=0.25u l=0.18u m=1
Mn1 out_t in1 VSS   VSS n_18 w=0.25u l=0.18u m=1
Mn2 out_t in2 VSS   VSS n_18 w=0.25u l=0.18u m=1

xinv out_t out inv 
.ends

* XNOR subcircuit
.subckt XNOR in1 in2 out
xinv1 in1 in1_i inv
xinv2 in2 in2_i inv

Mp1L p1l_s in1   VDD   VDD p_18 w=0.45u l=0.18u m=1
Mp2L out   in2   p1l_s VDD p_18 w=0.45u l=0.18u m=1
Mp1R p1r_s in1_i VDD   VDD p_18 w=0.45u l=0.18u m=1 
Mp2R out   in2_i p1r_s VDD p_18 w=0.45u l=0.18u m=1

Mn1L out   in1   n1l_s VSS n_18 w=0.25u l=0.18u m=1
Mn2L n1l_s in2_i VSS   VSS n_18 w=0.25u l=0.18u m=1
Mn1R out   in1_i n1r_s VSS n_18 w=0.25u l=0.18u m=1
Mn2R n1r_s in2   VSS   VSS n_18 w=0.25u l=0.18u m=1
.ends

* multiplexer subcircuit 
.subckt mux sel in1 in2 out
xinv sel sel_i inv

Mn1 out sel   in1 VSS n_18 w=0.45u l=0.18u m=1
Mp1 out sel_i in1 VDD p_18 w=0.45u l=0.18u m=1
Mn2 out sel_i in2 VSS n_18 w=0.45u l=0.18u m=1
Mp2 out sel   in2 VDD p_18 w=0.45u l=0.18u m=1
.ends

.subckt mux_cmos sel in1 in2 out
xinv sel sel_i inv

xand1 sel   in1  out1 and
xand2 sel_i in2  out2 and
xor   out1  out2 out  or
.ends

* single bit CLA
.subckt unit x y cin cout s
xxnor_upper x        y   xnor_out XNOR
xxnor_lower xnor_out cin s        XNOR
xmux xnor_out y cin cout mux
.ends

* 8 bit CLA
.subckt CLA_8 x0 x1 x2 x3 x4 x5 x6 x7 y0 y1 y2 y3 y4 y5 y6 y7 c0 c1 c2 c3 c4 c5 c6 c7 c8 s0 s1 s2 s3 s4 s5 s6 s7
xu0 x0 y0 c0 c1 s0 unit
xu1 x1 y1 c1 c2 s1 unit
xu2 x2 y2 c2 c3 s2 unit
xu3 x3 y3 c3 c4 s3 unit
xu4 x4 y4 c4 c5 s4 unit
xu5 x5 y5 c5 c6 s5 unit
xu6 x6 y6 c6 c7 s6 unit
xu7 x7 y7 c7 c8 s7 unit
.ends

* main circuit
xCLA_8 x0 x1 x2 x3 x4 x5 x6 x7 y0 y1 y2 y3 y4 y5 y6 y7 c0 c1 c2 c3 c4 c5 c6 c7 c8 s0 s1 s2 s3 s4 s5 s6 s7 CLA_8

* input signal
vin1  X0 vss pulse (0v 0v   4ns 1ns 1ns 4ns 10ns)
vin3  X1 vss pulse (0v 0v   4ns 1ns 1ns 4ns 10ns)
vin5  X2 vss pulse (0v 0v   4ns 1ns 1ns 4ns 10ns)
vin7  X3 vss pulse (0v 0v   4ns 1ns 1ns 4ns 10ns)
vin9  X4 vss pulse (0v 0v   4ns 1ns 1ns 4ns 10ns)
vin11 X5 vss pulse (0v 0v   4ns 1ns 1ns 4ns 10ns)
vin13 X6 vss pulse (0v 0v   4ns 1ns 1ns 4ns 10ns)
vin15 X7 vss pulse (0v 0v   4ns 1ns 1ns 4ns 10ns)

vin2  Y0 vss pulse (0v 1.8v 0ns 0ns 0ns 5ns 20ns)
vin4  Y1 vss pulse (1.8v 1.8v 4ns 1ns 1ns 4ns 10ns)
vin6  Y2 vss pulse (1.8v 1.8v 4ns 1ns 1ns 4ns 10ns)
vin8  Y3 vss pulse (1.8v 1.8v 4ns 1ns 1ns 4ns 10ns)
vin10 Y4 vss pulse (1.8v 1.8v 4ns 1ns 1ns 4ns 10ns)
vin12 Y5 vss pulse (1.8v 1.8v 4ns 1ns 1ns 4ns 10ns)
vin14 Y6 vss pulse (1.8v 1.8v 4ns 1ns 1ns 4ns 10ns)
vin16 Y7 vss pulse (1.8v 1.8v 4ns 1ns 1ns 4ns 10ns)

vin17 C0 vss pulse (1.8v 1.8v 4ns 1ns 1ns 4ns 10ns)

* measure
.op
.tran 0.1ns 20n
.temp 25
.options post

.meas tran T1 when V(Y0)=0.9 fall=1
.meas tran T2 when V(S7)=0.9 rise=1
.meas Td param = 'T2-T1'
*.meas tran power_analysis_mux avg p(xCLA_8.xu0.xmux) from T1 to T2
*.meas tran power_analysis_xnor_up avg p(xCLA_8.xu0.xxnor_upper) from T1 to T2
*.meas tran power_analysis_xnor_low avg p(xCLA_8.xu0.xxnor_lower) from T1 to T2
.meas tran power avg p(xCLA_8) from T1 to T2
*.meas tran U0_power avg p(xCLA_8.xu0) from T1 to T2
*.meas tran U1_power avg p(xCLA_8.xu1) from T1 to T2
*.meas tran U2_power avg p(xCLA_8.xu2) from T1 to T2
*.meas tran U3_power avg p(xCLA_8.xu3) from T1 to T2
*.meas tran U4_power avg p(xCLA_8.xu4) from T1 to T2
*.meas tran U5_power avg p(xCLA_8.xu5) from T1 to T2
*.meas tran U6_power avg p(xCLA_8.xu6) from T1 to T2
*.meas tran U7_power avg p(xCLA_8.xu7) from T1 to T2

.end
