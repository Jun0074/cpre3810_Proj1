#---------------------------------------------------
# RISC-V SRL testing Shift Amounts and Edge Cases
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
# Initial Value: 0xFFFF0000
lui t0, 0xFFFF0
addi t0, t0, 0x000 # t0 = 0xFFFF0000

#test 1, shift amount zero
li t2, 0
srl t1, t0, t2
li t3, 0xFFFF0000
bne t3, t1, test_fail

#test 2, shift amount 1
li t2, 1
srl t1, t0, t2
li t3, 0x7FFF8000
bne t3, t1, test_fail

#test 3, shift amount 31 (maximum)
li t2, 31
srl t1, t0, t2
li t3, 0x00000001
bne t3, t1, test_fail

#test 4, shift amount 32 (ignored bits)
li t2, 32
srl t1, t0, t2
li t3, 0xFFFF0000
bne t3, t1, test_fail

test_pass:
addi t5, x0, 1 # t5 = 1 (PASS)
j exit

test_fail:
addi t5, x0, 2 # t5 = 2 (FAIL)

exit:
wfi

