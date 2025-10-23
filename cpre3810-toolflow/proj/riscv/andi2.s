    .data
result:
    .word 0

    .text
    .globl main

main:
    # Test 2: sign-extension of 12-bit immediate (negative immediate)
    # Use imm = -16 (12-bit encoding 0xFF0). It should sign-extend and clear low 4 bits.
    # t0 <- 0x1234567F
    li   t0, 0x1234567F
    # andi t1, t0, -16  => expect 0x12345670 (clears low 4 bits)
    andi t1, t0, -16
    la   t2, result
    sw   t1, 0(t2)
    wfi

