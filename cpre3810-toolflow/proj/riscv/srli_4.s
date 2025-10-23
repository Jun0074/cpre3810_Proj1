.data

.text
.globl main

main:


    lui x5, 0xFF
    srli x6, x5, 0  # place unshifted value into new reg
    srli x5, x6, 4 # place x6 back into x5 shifted by 4
    #x5 should be 0x0000ff00
    #x5 should be 0x000ff000
    
      end:
    wfi               

