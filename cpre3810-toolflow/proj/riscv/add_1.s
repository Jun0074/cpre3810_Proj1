    .data
    .text
    .globl main
main:
    # clear registers
    add x5, x0, x0        # x5=0
    add x6, x0, x0        # x6=0

    # test case: adding when both are zero
    add x1, x0, x0        # x1=0+0=0

    # test case: adding a positive imm and zero
    addi x2, x0, 7        # x2=7
    add x3, x2, x0        # x3=7+0=7

    # test case: adding negative and positive immediates
    addi x4, x0, -3       # x4= 3
    add x5, x4, x2        # x5=(-3)+7=4

    # test case: commutativity
    add x6, x2, x4        # x6=7+(-3)=4

    addi a7, x0, 93
    #ecall
    wfi