.protect
.lib '/cad/cell_lib/cic018.l'TT
.inc xorpre.sp
.inc xor.pex.netlist
.unprotect

.global VDD
.global VSS

.global a
.global b


VDD VDD 0 1.8
VSS VSS 0 0

va  a  0 pulse( 0 1.8 20ns 5ns 5ns 30ns 50ns) 
vb  b  0 pulse( 0 1.8 30ns 5ns 5ns 30ns 50ns)


*sub-circuit

Xxor  a b XORHspice VDD VSS xor1
Xxor1 a XORlayout b VSS VDD XOR




.meas tran delay5layout
+trig v(a) val=1.8*0.5 rise=1
+targ v(XORlayout) val=1.8*0.5 rise=1

.meas tran delay5Hspice
+trig v(a) val=1.8*0.5 rise=1
+targ v(XORHspice) val=1.8*0.5 rise=1




.meas tran delay6layout
+trig v(b) val=1.8*0.5 rise=1
+targ v(XORlayout) val=1.8*0.5 fall=1

.meas tran delay6Hspice
+trig v(b) val=1.8*0.5 rise=1
+targ v(XORHspice) val=1.8*0.5 fall=1


******

.meas tran delay7layout
+trig v(a) val=1.8*0.5 fall=1
+targ v(XORlayout) val=1.8*0.5 rise=2

.meas tran delay7Hspice
+trig v(a) val=1.8*0.5 fall=1
+targ v(XORHspice) val=1.8*0.5 rise=2




.meas tran delay8layout
+trig v(b) val=1.8*0.5 fall=1
+targ v(XORlayout) val=1.8*0.5 fall=2

.meas tran delay8Hspice
+trig v(b) val=1.8*0.5 fall=1
+targ v(XORHspice) val=1.8*0.5 fall=2

.meas tran pwr avg power


.op
.tran 50p 70n

.option post




.end
