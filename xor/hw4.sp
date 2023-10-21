.subckt xor A B OUT vd VSS
Mp1 A_inv A vd vd p_18 w=0.53u l=0.18u
Mn1 A_inv A VSS VSS n_18 w=0.53u l=0.18u

Mp2 B_inv B vd vd p_18 w=0.53u l=0.18u
Mn2 B_inv B VSS VSS n_18 w=0.53u l=0.18u

Mp3 node0 B_inv vd vd p_18 w=0.53u l=0.18u
Mp4 OUT A node0 vd p_18 w=0.53u l=0.18u
Mp5 node1 A_inv vd vd p_18 w=0.53u l=0.18u
Mp6 OUT B node1 vd p_18 w=0.53u l=0.18u

Mn3 node2 B_inv VSS VSS n_18 w=0.53u l=0.18u
Mn4 OUT A_inv node2 VSS n_18 w=0.53u l=0.18u
Mn5 node3 B VSS VSS n_18 w=0.53u l=0.18u
Mn6 OUT A node3 VSS n_18 w=0.53u l=0.18u
.ends
