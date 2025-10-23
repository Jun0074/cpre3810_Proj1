.data
.text
.globl main
main:
# init regs
addi t0, x0, 16       # t0 = 16
addi t1, x0, 2        # t1 = 2

sra t2, t0, t1        # t2 = t0 >> 2 = 4
# Expected: t2 = 4 
#Justification: tests super basic functionality of positve number shifted by positive number

addi t3, x0, 255
addi t4, x0, 4

sra t5, t3, t4        # t5 = t3 >> 4 = 15
# Expected: x6 = 15 
#Justification tests mulitple bit shifts with different set of positve numbers

end:
wfi
#j end
