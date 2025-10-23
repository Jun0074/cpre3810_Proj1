.data

.text
.globl main

main:

    # These cases cross zero (positve input -> negative output and vise-versa)
    
    # positive minus positive
    addi x1, x0, 60     # load test values
    addi x2, x0, 120     
    sub x1, x1, x2     # perform test
    
    # negative minus negative    
    addi x3, x0, -60     # load test values
    addi x4, x0, -120     
    sub x3, x3, x4     # perform test
    
  end:
    wfi               

