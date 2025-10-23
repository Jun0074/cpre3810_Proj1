.data

.text
.globl main

main:
    # testing shifts with small numbers
    addi x13, x0, 15        # x13 = 15 (0b1111, putting F into x13)
    slli x14, x13, 1        # x14 = 15 << 1 = 30 (0b11110)
    slli x15, x13, 4        # x15 = 15 << 4 = 240 (0b11110000)
    
    # testing that zeros are shifted in from right
    addi x16, x0, 1         # x16 = 1
    slli x17, x16, 5        # x17 = 1 << 5 = 32 (0b100000)

end:
    wfi
   # j end
