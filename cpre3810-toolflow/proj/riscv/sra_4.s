.data
.text
.globl main
main:
# shift by maximum(31)
addi t0, x0, 4
addi t1, x0, -31
sra t2, t0, t1      # t2 = 0x2
# Justification: tests shift with a negative value. The lowest 5 bits are used so with -31 shift right by 1
#This is the make sure that a negative value does not shift it left and must shift it right.

# shift by maximum(31) positve
lui t3, 0xFFFFF  # t31 = 0x0FFFF000
addi t5, x0, -1
sra t4, t3, t5      # t4 = -1
# Justification: Make sure bottom 5 bits are used and shift right. This should "Clear" the register negative wise
#and result in -1
end:
wfi
#j end
