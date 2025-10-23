.data

.text
.globl main

main:

    lui x5, 0xF #testing other shifting value
    srli x5, x5, 1 #should create a more visual cascading shift of f -> 78 -> 3c -> 1e -> f
    srli x5, x5, 1
    srli x5, x5, 1
    srli x5, x5, 1
    srli x5, x5, 1
    srli x5, x5, 1
    srli x5, x5, 1
    srli x5, x5, 1 # should be 0x000000f0 - testing values other than multiples of 4
    
    srli x5, x5, 0 # should be no change - testing as imm edge case
    srli x5, x5, 31 # x5 will be 0x00000000 - testing as edge case with value in reg
    
      end:
    wfi               

