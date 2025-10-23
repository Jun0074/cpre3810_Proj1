.data

.text
.globl main

main:

    # Start Test

    lui x5, 0xFFFFF # using lui to add data to upper half in order to shift bits over x1 = 0xFFFFF000
    		    # these next instructions will verify the loaded bits will shift to the right
    		    # verifying basic use of shifting bits - when shifting by multiples of 4 it will keep the bit structure
    srli x5, x5, 4  # 0x0FFFFF00
    srli x5, x5, 4  # 0x00FFFFF0 
    srli x5, x5, 4  # 0x000FFFFF
    srli x5, x5, 4  # 0x0000FFFF
    srli x5, x5, 4  # 0x00000FFF
    srli x5, x5, 4  # 0x000000FF
    srli x5, x5, 4  # 0x0000000F
    srli x5, x5, 4 # register x1 should now be empty (0x00000000) - testing basic functionality
    
    
    
      end:
    wfi               

