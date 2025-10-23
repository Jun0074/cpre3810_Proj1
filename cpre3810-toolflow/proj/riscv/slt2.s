###########################################################
# File: slt.jwk0425.2.s
# Purpose: SLT sign-boundary and overflow edge cases
# Author: JongwooKim
###########################################################

.data
.text
.globl main

main:
# --------------------------------------------------------
# Register initialization 
# --------------------------------------------------------
addi x1, x0, 0
addi x2, x0, 0
addi x3, x0, 0
addi x4, x0, 0
addi x5, x0, 0
addi x6, x0, 0
addi x7, x0, 0
addi x8, x0, 0
addi x9, x0, 0
addi x10, x0, 0
addi x11, x0, 0
addi x12, x0, 0
addi x13, x0, 0
addi x14, x0, 0
addi x15, x0, 0
addi x16, x0, 0
addi x17, x0, 0
addi x18, x0, 0
addi x19, x0, 0
addi x20, x0, 0
addi x21, x0, 0
addi x22, x0, 0
addi x23, x0, 0
addi x24, x0, 0
addi x25, x0, 0
addi x26, x0, 0
addi x27, x0, 0
addi x28, x0, 0
addi x29, x0, 0
addi x30, x0, 0
addi x31, x0, 0

# --------------------------------------------------------
# SLT Test 2 - Boundary and overflow tests
# --------------------------------------------------------
# Test 1: -2^31 < 0 → expect 1
lui  t0, 0x80000      # t0 = 0x80000000 (-2147483648)
addi t1, x0, 0
slt  t2, t0, t1
addi t3, x0, 1
xor  t4, t2, t3
or   a0, a0, t4

# Test 2: +2^31-1 < -2^31 → expect 0
lui  t0, 0x7ffff
addi t0, t0, 0x7FF
lui  t1, 0x80000
slt  t2, t0, t1
addi t3, x0, 0
xor  t4, t2, t3
or   a0, a0, t4

# Test 3: -2^31 < +2^31-1 → expect 1
lui  t0, 0x80000
lui  t1, 0x7ffff
addi t1, t1, 0x7FF
slt  t2, t0, t1
addi t3, x0, 1
xor  t4, t2, t3
or   a0, a0, t4

end:
wfi
#j end
