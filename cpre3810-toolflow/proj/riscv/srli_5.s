.data

.text
.globl main

main:


    lui x6, 0xAAAAA #0xAAAAA000
    srli x6, x6, 1  #should now be 0x55555000
    
    #srli x5, x5, -1 # should not be able to load negative values at all
    #srli x5, x5, 32   # should not be able to load values over 31
    
      end:
    wfi               

