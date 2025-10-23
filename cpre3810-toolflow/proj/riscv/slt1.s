###########################################################
# File: slt.jwk0425.1.s
# Purpose: Basic signed comparison tests for SLT instruction
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
# SLT Test 1 - Basic comparisons
# --------------------------------------------------------
# Test 1: -1 < 0 → expect 1
addi t0, x0, -1
addi t1, x0, 0
slt  t2, t0, t1
addi t3, x0, 1
xor  t4, t2, t3
or   a0, a0, t4

# Test 2: 0 < -1 → expect 0
addi t0, x0, 0
addi t1, x0, -1
slt  t2, t0, t1
addi t3, x0, 0
xor  t4, t2, t3
or   a0, a0, t4

# Test 3: 5 < 5 → expect 0
addi t0, x0, 5
addi t1, x0, 5
slt  t2, t0, t1
addi t3, x0, 0
xor  t4, t2, t3
or   a0, a0, t4

end:
wfi
#j end
