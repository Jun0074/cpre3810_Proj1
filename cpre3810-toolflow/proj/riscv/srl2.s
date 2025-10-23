#---------------------------------------------------
# RISC-V SLL testing Source Data Edge Cases (rs1)
# Author: Jacob Mumey
#---------------------------------------------------

# Target Architecture: RV32I (32-bit registers)

# Register Mapping:
# t0 Base Test Data (rs1)
# t1 Destination Register (rd)
# t2 Shift Amount (rs2)
# t3 Expected Result

.data
.text
.globl main

main:
# Start Test

#data setup
# Fixed Shift Amount: 4
li t2, 4

#test 1, Source Data is Zero (0x00000000)
# Expected: 0x00000000 << 4 = 0x00000000
li t0, 0x00000000
sll t1, t0, t2
li t3, 0x00000000
bne t3, t1, test_fail

#test 2, Source Data is LSB Set (0x00000001)
# Expected: 0x00000001 << 4 = 0x00000010
li t0, 1
sll t1, t0, t2
li t3, 0x00000010
bne t3, t1, test_fail

#test 3, Source Data is MSB Set (0x80000000)
# Expected: 0x80000000 << 4 = 0x00000000 (The '1' bit is shifted out)
li t0, 0x80000000
sll t1, t0, t2
li t3, 0x00000000
bne t3, t1, test_fail

#test 4, Source Data is All Ones (0xFFFFFFFF)
# Expected: 0xFFFFFFFF << 4 = 0xFFFFFFF0 (The upper 4 bits are shifted out)
li t0, -1 # load 0xFFFFFFFF
sll t1, t0, t2
li t3, 0xFFFFFFF0
bne t3, t1, test_fail

test_pass:
addi t5, x0, 1 # t5 = 1 (PASS)
j exit

test_fail:
addi t5, x0, 2 # t5 = 2 (FAIL)

exit:
wfi

