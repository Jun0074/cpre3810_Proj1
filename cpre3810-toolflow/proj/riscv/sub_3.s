.data

.text
.globl main

main:

    # sequential subtractions (for testing pipelining later)

    addi x1, x0, 1     # load test values
    addi x2, x0, 2
    addi x3, x0, 3
    addi x4, x0, 4
    addi x5, x0, 5
    addi x6, x0, 6
    addi x7, x0, 7
    addi x8, x0, 8
    addi x9, x0, -9
    addi x10, x0, -10
    addi x11, x0, -11
    addi x12, x0, -12
    addi x13, x0, -13
    addi x14, x0, -14
    addi x15, x0, -15
    addi x16, x0, -16
    
    sub x2, x1, x2     # perform tests
    sub x3, x2, x3
    sub x4, x3, x4
    sub x5, x4, x5
    sub x6, x5, x6
    sub x7, x6, x7
    sub x8, x7, x8
    sub x9, x8, x9
    sub x10, x9, x10
    sub x11, x10, x11
    sub x12, x11, x12
    sub x13, x12, x13
    sub x14, x13, x14
    sub x15, x14, x15
    sub x16, x15, x16


  end:
    wfi               

