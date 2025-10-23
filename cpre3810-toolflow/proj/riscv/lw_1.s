# lw_jbruck22_1.s
# lw Test 1

# This test intends to test common load cases using a base address stored in t0
# and an immediate offset value. This will test that the address is being computed 
# correctly and that the value is correctly being read from memory, transorted to 
# the register file, and written to the destination register

.data
# store known values at known addresses in mem
value1: .word 0x11111111 # 0x10010000
value2: .word 0x22222222 # 0x10010004
value3: .word 0x33333333 # 0x10010008

.text
.globl main

main:
# start test
lui t0, 0x10010  # load address 0x1001000 into t0

lw t1, 0(t0) # load value 0x11111111 into t1 from addr 0x10010000 + 0 
lw t2, 4(t0) # load value 0x22222222 into t2 from addr 0x10010000 + 4 
lw t3, 8(t0) # load value 0x33333333 into t3 from addr 0x10010000 + 8 

# expected results
# value in t1: 0x11111111
# value in t2: 0x22222222
# value in t3: 0x33333333

#end:
wfi
#j end