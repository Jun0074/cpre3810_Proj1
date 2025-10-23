    .data
result:
    .word 0

    .text
    .globl main

main:
    # Test 2: Negative < Positive → branch taken
    li   x1, -5
    li   x2, 3
    la   x3, result

    blt  x1, x2, less
    li   t0, 0
    sw   t0, 0(x3)
    j    done

less:
    li   t0, 1
    sw   t0, 0(x3)

done:
    wfi

