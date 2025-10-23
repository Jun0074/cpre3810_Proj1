.text
.globl main

main:
    lui  x5,  0x12345         # x5 = 0x12345000
    addi x5,  x5, 0x678       # x5 = 0x12345678

    addi x6,  x0, 1           # mask bit 0   = 0x00000001
    addi x7,  x0, 2           # mask bit 1   = 0x00000002
    addi x8,  x0, 128         # mask bit 7   = 0x00000080
    lui  x9,  0x8             # mask bit 15  = 0x00008000
    addi x9,  x9, 0
    lui  x10, 0x80000         # mask bit 31  = 0x80000000

    #1 flip bit 0 twice 
    xor  x11, x5,  x6         # x11 = base ^ m0
    xor  x12, x11, x6         # x12 = T0 ^ m0 
    xor  x20, x12, x5         # x13 = U0 ^ base = want 0

    #2 flip bit 1 twice 
    xor  x13, x5,  x7         # x13
    xor  x14, x13, x7         # x14
    xor  x21, x14, x5         # x21 = 0

    #3 flip bit 7 twice
    xor  x15, x5,  x8         # x15
    xor  x16, x15, x8         # x16
    xor  x22, x16, x5         # x22 = 0

    #4 flip bit 15 twice
    xor  x17, x5,  x9         # x17
    xor  x18, x17, x9         # x18
    xor  x23, x18, x5         # x23 = 0

    #5 flip bit 31 twice sign bit
    xor  x19, x5,  x10        # x19
    xor  x24, x19, x10        # x24
    xor  x25, x24, x5         # x25 = 0

end:
    wfi                      

