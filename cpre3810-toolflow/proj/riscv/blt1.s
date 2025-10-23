    .data
result:
    .word 0

    .text
    .globl main

main:
    # Test 1: Branch taken (x1 < x2)
    li   x1, 5
    li   x2, 10
    la   x3, result

    blt  x1, x2, less
    li   t0, 0           # not taken
    sw   t0, 0(x3)
    j    done

less:
    li   t0, 1           # taken
    sw   t0, 0(x3)

done:
    wfi

