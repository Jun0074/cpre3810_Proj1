# ===========================================================
# Proj1_base_test.s
# Step 4a Proj1
# ===========================================================

.data
result: .word 0

.text
.globl main
main:
addi x1, x0, 5           # x1 = 5
addi x2, x0, 10          # x2 = 10
addi x3, x0, -3          # x3 = -3
addi x4, x0, 0           # x4 = 0

# ---- Arithmetic operations ----
add x5, x1, x2           # x5 = 5 + 10 = 15
sub x6, x2, x1           # x6 = 10 - 5 = 5
slt x7, x3, x2           # x7 = 1  (since -3 < 10)
slti x8, x1, 8           # x8 = 1  (since 5 < 8)
sltiu x9, x3, 4          # x9 = 1  (unsigned compare)
lui x10, 0x12345         # x10 = 0x12345000
auipc x11, 0x1           # x11 = PC + 0x1000 (tests AUIPC behavior)

# ---- Logical operations ----
and x12, x1, x2          # x12 = 5 AND 10
andi x13, x1, 12         # x13 = 5 AND 12
or x14, x1, x3           # x14 = 5 OR -3
ori x15, x1, 7           # x15 = 5 OR 7
xor x16, x1, x2          # x16 = 5 XOR 10
xori x17, x2, 15         # x17 = 10 XOR 15

sll x18, x1, x2          # x18 = x1 << (x2[4:0])
slli x19, x1, 2          # x19 = 5 << 2 = 20
srl x20, x2, x1          # x20 = x2 >> (x1[4:0])
srli x21, x2, 1          # x21 = 10 >> 1 = 5
sra x22, x3, x1          # x22 = -3 >> 5 (arith right)
srai x23, x3, 1          # x23 = -3 >> 1 (arith right immediate)

end:
wfi                      # halt program
