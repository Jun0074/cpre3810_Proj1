.data

.text
.globl main

# Shifting left by 32 bits to clear registers
# The test's goal is to test the ability to clearfully clear registers, dispite the current content of the registers
main:

    # Start Test

    # Clear the first bit by shifting left by 32 bits
    addi, x1, x0, 1 #  Load x1 with 0x00000001
    slli x1, x1, 16	
    slli x1, x1, 16	# Expected: 0, Verify that x1 is cleared
    
    # Clear all bits by shifting left by 32 bits
    addi, x2, x0, -1 #  Load x1 with 0xFFFFFFFF
    slli x2, x2, 16	
    slli x2, x2, 16	# Expected: 0, Verify that x2 is cleared
    
    # Clear first three bytes by shifting left by 32
    addi, x3, x0, 0x123 #  Load x1 with 0x00000123
    slli x3, x3, 16	
    slli x3, x3, 16	# Expected: 0, Verify that x2 is cleared
    
    # Clear first 4 bytes by shifting Left by 32 (can be done by shifting by 16)
    addi, x4, x0, 0
    lui x4, 0xDEAD	#  Load x1 with 0xDEAD0000
    slli x4, x4, 16	
    slli x4, x4, 16	# Expected: 0, Verify that x2 is cleared
    
    # Clear register containing anything by shifting Left by 32
    addi x5, x0, 0
    lui x5, 0xF00D0 
    addi x5, x5, 0x101 #  Load x1 with 0xF00D0101
    slli x5, x5, 16	
    slli x5, x5, 16	# Expected: 0, Verify that x2 is cleared
    
  end:
    wfi               
  #  j end             
