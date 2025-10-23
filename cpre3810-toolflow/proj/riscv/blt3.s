    .data
result_equal:
    .word 0
result_greater:
    .word 0

    .text
    .globl main

main:
    # Test 3A: Equal operands → no branch
    li   x1, 7
    li   x2, 7
    la   x3, result_equal

    blt  x1, x2, less_equal
    li   t0, 0
    sw   t0, 0(x3)
    j    next_test

less_equal:
    li   t0, 1
    sw   t0, 0(x3)

next_test:
    # Test 3B: x1 > x2 → no branch
    li   x1, 12
    li   x2, 5
    la   x3, result_greater

    blt  x1, x2, less_greater
    li   t0, 0
    sw   t0, 0(x3)
    j    done

less_greater:
    li   t0, 1
    sw   t0, 0(x3)

done:
    wfi

