.data
.text
.globl main
main:

# shift by maximum(31)
lui t0, 0xF0000
addi t1, x0, 31
sra t2, t0, t1      # x3 = 0xFFFFFFFF >> 31 = -1
# Justification: tests maximum shift for negative number, looking for sign bit to be preserved

# shift by maximum(31) positve
lui t3, 0x0FFFF  # t31 = 0x0FFFF000
#use t1 from before which is 31
sra t4, t3, t1      # t4 = 0x0FFFF000 >> 31 = 0
# Justification: tests maximum shift for positve number, looking to "clear" this register

end:
wfi
#j end
