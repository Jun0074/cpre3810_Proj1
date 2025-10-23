    .data
    .text
    .globl main
main:
    # repeated doubling
    # checking wrap-around behavior

    addi x1, x0, 1        # x1=1

    # double x1 repeatedly to get 1 << 30
    add x1, x1, x1        # x1=2  (1<<1)
    add x1, x1, x1        # x1=4  (1<<2)
    add x1, x1, x1        # x1=8  (1<<3)
    add x1, x1, x1        # x1=16 (1<<4)
    add x1, x1, x1        # 5      etc.
    add x1, x1, x1        # 6      etc.
    add x1, x1, x1        # 7
    add x1, x1, x1        # 8
    add x1, x1, x1        # 9
    add x1, x1, x1   
    add x1, x1, x1  
    add x1, x1, x1     
    add x1, x1, x1  
    add x1, x1, x1 
    add x1, x1, x1 
    add x1, x1, x1 
    add x1, x1, x1     
    add x1, x1, x1 
    add x1, x1, x1 
    add x1, x1, x1 
    add x1, x1, x1 
    add x1, x1, x1
    add x1, x1, x1     
    add x1, x1, x1 
    add x1, x1, x1     
    add x1, x1, x1   
    add x1, x1, x1     
    add x1, x1, x1    
    add x1, x1, x1
    add x1, x1, x1        # 30 ---> x1=1<<30 

    # copy x1 to x2
    add x2, x1, x0        # x2=x1
    # add x1+x2 --> (1<<31)
    add x3, x1, x2
    # add x3+x3 ---> wrap around
    add x4, x3, x3
    add x5, x4, x0        # x5=0
    add x6, x3, x0        # make sure x6 is preserved

    addi a7, x0, 93
    wfi