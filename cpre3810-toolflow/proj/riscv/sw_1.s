# sw negative offset test
# This tests that sw can store a value in memory
# at various negative offsets from a base address
# I am including this test becuase it is a
# good test of basic sw functionality when provided 
# a negative immidiate value to the ALU

.data

.text
.globl main

main:
    lui s0, 0x10010 # Base address (0x10010000)
    addi s0, s0, 0x1C

    addi t0, x0, 42  # Value to store (0x2A)
    
    # Test negative offset storing 8 bit value
    sw t0, 0(s0) # MEM[0x1001001C] = 0x2A
    sw t0, -4(s0) # MEM[0x10010018] = 0x2A
    sw t0, -8(s0) # MEM[0x10010014] = 0x2A
    sw t0, -12(s0) # MEM[0x10010010] = 0x2A
    sw t0, -16(s0) # MEM[0x1001000C] = 0x2A
    sw t0, -20(s0) # MEM[0x10010008] = 0x2A
    sw t0, -24(s0) # MEM[0x10010004] = 0x2A
    sw t0, -28(s0) # MEM[0x10010000] = 0x2A

    # Memory should now be:
    # MEM[0x10010000] = 0x2A
    # MEM[0x10010004] = 0x2A
    # MEM[0x10010008] = 0x2A
    # MEM[0x1001000C] = 0x2A
    # MEM[0x10010010] = 0x2A
    # MEM[0x10010014] = 0x2A
    # MEM[0x10010018] = 0x2A
    # MEM[0x1001001C] = 0x2A

end:
    wfi

