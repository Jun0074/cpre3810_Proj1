.text
.globl main

main:
    addi x5,  x0, 0              # x5 = 0
    addi x6,  x0, -1             # x6 = 0xFFFFFFFF

    lui  x7,  0x55555            # x7 = 0x55555000
    addi x7,  x7, 0x555          # x7 = 0x55555555

    lui  x8,  0xAAAAA            # x8 = 0xAAAAA000
    addi x8,  x8, 2047           # x8 = 0xAAAAA7FF
    addi x8,  x8, 683            # x8 = 0xAAAAAAAA

    lui  x9,  0x80000            # x9 = 0x80000000

    lui  x10, 0x7FFFF            # x10 = 0x7FFFF000
    addi x10, x10, 2047          # x10 = 0x7FFFF7FF
    addi x10, x10, 2047          
    addi x10, x10, 1             # x10 = 0x7FFFFFFF

    lui  x11, 0xDEADB            # A = 0xDEADBEEF
    addi x11, x11, 2047          
    addi x11, x11, 1776          

    lui  x12, 0xBADC0            # B = 0xBADC0FFE
    addi x12, x12, 2047          
    addi x12, x12, 2047          


    #1 opposite patterns = all 1s
    xor  x13, x7, x8             # 0x5555 ^ 0xAAAA = 0xFFFFFFFF
    xor  x20, x13, x6            # x20 = 0

    #2 sign vs max = all 1s
    xor  x14, x9, x10            # 0x80000000 ^ 0x7FFFFFFF = 0xFFFFFFFF
    xor  x21, x14, x6            # x20 = 0

    #3 ~0 ^ 0 = ~0
    xor  x15, x6, x5             # ~0 ^ 0 = ~0
    xor  x22, x15, x6            

    #4 (A ^ B) ^ B = A, and A ^ A = 0
    xor  x16, x11, x12           # temp1 = A ^ B
    xor  x17, x16, x12           # temp2 = (A ^ B) ^ B = A
    xor  x23, x17, x11           # A ^ A = 0

end:
    wfi

