.data
.text
.globl main
main:
# Start Test initialize regs

# Double shift negative number
lui t0, 0xF0000
addi t1, x0, 20
sra t2, t0, t1      
sra t2, t2, t1	     # t2 = -1 
# Justification: tests double shifting of a negative number

# Double shift positive number
lui t3, 0x0FFFF  # t31 = 0x0FFFF000
#use t1 from before which is 20
sra t4, t3, t1      
sra t4, t4, t1 #t4 = 0
# Justification: tests double shifting of a positive number "clearing" the register

end:
wfi
#j end
