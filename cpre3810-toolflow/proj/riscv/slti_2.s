#Test 1
#Test basic less/equal/greater cases
# 
#Covers when rs1 < imm (should set rd = 1)
#Covers when rs1 == imm (should set rd = 0)
#Covers when rs1 > imm (should set rd = 0)

        .text
        .globl _start
_start:
        # rs1 < imm
        addi x1, x0, 3        # x1 = 3
        slti x2, x1, 5        # expect x2 = 1

        # rs1 == imm
        addi x3, x0, 5        # x3 = 5
        slti x4, x3, 5        # expect x4 = 0

        # rs1 > imm
        addi x5, x0, 7        # x5 = 7
        slti x6, x5, 5        # expect x6 = 0
        
        wfi
