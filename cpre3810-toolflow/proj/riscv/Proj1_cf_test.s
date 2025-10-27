# ===========================================================
# Proj1_cf_test.s
# Control-flow instruction test (no prints, no syscalls)
# Demonstrates: beq, bne, blt, bge, bltu, bgeu, jal, jalr
# True call depth = 5
# ===========================================================
.text
.globl _start

_start:
# Initialize stack pointer to match RARS (0x7FFFFFF0)
lui sp, 0x7FFFF
addi sp, sp, 0xF0

jal func1
wfi

func1:
addi sp, sp, -16
sw ra, 12(sp)
jal func2
lw ra, 12(sp)
addi sp, sp, 16
jalr x0, 0(ra)

func2:
addi sp, sp, -16
sw ra, 12(sp)
jal func3
lw ra, 12(sp)
addi sp, sp, 16
jalr x0, 0(ra)

func3:
addi sp, sp, -16
sw ra, 12(sp)
jal func4
lw ra, 12(sp)
addi sp, sp, 16
jalr x0, 0(ra)

func4:
addi sp, sp, -16
sw ra, 12(sp)
jal func5
lw ra, 12(sp)
addi sp, sp, 16
jalr x0, 0(ra)

func5:
addi sp, sp, -16
sw ra, 12(sp)
jal branch_test
lw ra, 12(sp)
addi sp, sp, 16
jalr x0, 0(ra)

branch_test:
addi t0, x0, 0
addi t1, x0, 1

beq t0, t0, L1
L1:
bne t1, x0, L2
L2:
blt t0, t1, L3
L3:
bge t1, t0, L4
L4:
bltu t0, t1, L5
L5:
bgeu t1, t0, L6
L6:
jalr ra, ra, 4 # link to next addr +4 go L7
L7:
addi x0, x0, 0 
wfi

