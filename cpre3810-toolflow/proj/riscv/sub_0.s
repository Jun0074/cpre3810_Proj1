.data

.text
.globl main

main:

    # This file covers common cases

    # postive minus smaller positive
    addi x1, x0, 120     # load test values
    addi x2, x0, 60     
    sub x1, x1, x2     # perform test
    
    # larger positives
    addi x3, x0, 0     # load test values
    lui x3, 0x7FAB0
    addi x4, x0, 11     
    lui x4, 0x6E9A1
    sub x3, x3, x4     # perform test

    # positive minus negative
    addi x1, x0, 120     # load test values
    addi x2, x0, -60     
    sub x1, x1, x2     # perform test
    
    # larger positive and negative
    addi x3, x0, 0     # load test values
    lui x3, 0x7FAB0
    addi x4, x0, 11     
    lui x4, 0xEE9A1
    sub x3, x3, x4     # perform test
    
    # negative minus positive
    addi x1, x0, -120     # load test values
    addi x2, x0, 60     
    sub x1, x1, x2     # perform test
    
    # negative minus negative    
    addi x1, x0, -120     # load test values
    addi x2, x0, -60     
    sub x1, x1, x2     # perform test
    
  end:
    wfi               

