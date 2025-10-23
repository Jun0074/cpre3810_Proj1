    .data
result:
    .word 0

    .text
    .globl main

main:
    la   x3, result
    la   x4, base_label
    addi x4, x4, 8         # set up target = base_label + 8
    jalr ra, 0(x4)



base_label:
    nop
    nop
    nop
    li   t0, 1
    sw   t0, 0(x3)
    addi x4, x4, 0x14        # set up target = base_label + 16
    jalr ra, 0(x4)

after_return:
    li   t0, 3
    sw   t0, 0(x3)
    wfi
