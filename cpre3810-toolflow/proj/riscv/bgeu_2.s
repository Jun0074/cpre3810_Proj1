.data

.text
.globl main

main:

# ensuring all registers are zero
addi t2, zero, 0
addi t3, zero, 0

# Name: Warren Murphy
# Reason: Unsigned Edge Cases : Unsigned Comparison / Ensuring the Unsigned part of the bgeU < unsigned works | basically proving unsigned arithmetic

# Case 1: t0 = 0xFFFFFFFF [Reason for: should branch because t0 will NOT be -1 but a really big number comparatively to t1] / Proves we are using unsigned arithmetic.
addi t0, zero, -1 # t0 = 0xFFFFFFFF < should be treated as a really big value
addi t1, zero, 0

bgeu t0, t1, skipOne

addi t2, zero, 2

skipOne: # the value of t2 should be zero after this runs, the branch should skip the addi t2 line

# Case 2: t1 = 0xFFFFFFFF [Reason for: should NOT branch is the value of t0 less than t1] / Proves we are using unsigned arithmetic both ways.
addi t0, zero, 0
addi t1, zero, -1

bgeu t0, t1, skipTwo

addi t3, zero, 2

skipTwo: # the value of t3 should be 0x00000002 after this runs, the branch should NOT skip the addi t3 line

# values of the important registers should be: t2 = 0, t3 = 2

end:
wfi
#j end
