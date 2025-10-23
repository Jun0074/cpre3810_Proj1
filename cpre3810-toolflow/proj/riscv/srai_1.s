.data

.text
.globl main

main:

addi t0, zero, 0  #0x00000000
srai t1, t0, 0    #should remain 0
srai t1, t0, 31   #should remain 0

addi t0, zero, 1  #0x00000001
srai t1, t0, 1    #shift right by 1 -> 0
srai t1, t0, 31   #shift right by 31 -> 0

addi t0, zero, -1  #put 0xFFFFFFFF into t0
srai t1, t0, 1     #should remain as 0xFFFFFFFF
srai t1, t0, 31    #should remain as 0xFFFFFFFF

#these basic tests check the shifting mechanism, as well as the sign extension

end:
wfi
#j end
