.data

.text
.globl main

main:
    # simple slli functionality
    # this test verifies that slli shifts left by different amounts correctly
    # and fills shifted bits with zeros
    
    # only using addi and lui
    
    # test shifting zero
    addi x1, x0, 0          # x1 = 0 (adding 0 to x1)
    slli x2, x1, 0          # x2 = 0 << 0 = 0 (shift by 0, no change)
    slli x3, x1, 5          # x3 = 0 << 5 = 0 (shifting zero always gives zero)
    slli x4, x1, 31         # x4 = 0 << 31 = 0 (max shift of zero)
    
    # test shifting 1 by different amounts (powers of 2)
    # this test should work like multiplication, multiplying by multiples of 2.
    addi x5, x0, 1          # x5 = 1 (loading 1 into x5)
    slli x6, x5, 0          # x6 = 1 << 0 = 1 (no shift, this would be 2^0=1, so it would be x5 * 1 put into x7)
    slli x7, x5, 1          # x7 = 1 << 1 = 2 (shift to the left by 1 bit, same as multiplying by 2)
    slli x8, x5, 2          # x8 = 1 << 2 = 4 (shift to the left by 2 bits, same as multiplying by 4)
    slli x9, x5, 3          # x9 = 1 << 3 = 8 (shift to the left by 3 bits, same as multiplying by 8)
    slli x10, x5, 4         # x10 = 1 << 4 = 16 (shift to the left by 4 bits, same as multiplying by 16)
    slli x11, x5, 8         # x11 = 1 << 8 = 256 (shift to the left by 8 bits, same as multiplying by 256)
    slli x12, x5, 16        # x12 = 1 << 16 = 65536 (shift to the left by 16 bits, same as multiplying by 65536)

end:
    wfi
  #  j end
