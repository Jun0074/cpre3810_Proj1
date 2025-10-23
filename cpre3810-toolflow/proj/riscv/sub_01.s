# Testing Overflow (Wrap around)Subtraction
# Values: 2's complement and large numbers

# For each of  the cases:
#	1) Compute Testing Sub
#	2) Compute Expected with xor and add : a + (~b + 1) 
# 	3) Check Difference

    .text
    .globl main
main:

#-------------------------------------------------------
# --- Case 1: INT_MAX - (-1) = INT_MIN ---
#-------------------------------------------------------
# Overflow upwards gives a wrap down.

    # a = 0x7fffffff
    lui  t0, 0x80000         
    addi t0, t0, -1  
    
    # b = -1
    addi t1, x0, -1

    # Test
    sub  t2, t0, t1	# t00x7fffffff  - t1(-1) = 0x80000000

    # Expected
    xori t3, t1, -1	
    addi t3, t3, 1		
    add  t4, t0, t3	# t0(0x7fffffff)  + t1(1) = 0x80000000

    # Check
    xor  t5, t2, t4	

#-------------------------------------------------------
# --- Case 2: INT_MIN - 1 = INT_MAX---
#-------------------------------------------------------
# Wrap from most negative minus one

    # a = INT_MIN 
    lui  t0, 0x80000
    
    # b = 1
    addi t1, x0, 1

    # Test
    sub  t2, t0, t1          # t0(0x80000000) - t1(1) = 0x7fffffff

    # Expected
    xori t3, t1, -1
    addi t3, t3, 1
    add  t4, t0, t3          # t0(0x80000000) + t1(-1) = 0x7fffffff

    # Check
    xor  t5, t2, t4

#-------------------------------------------------------
# --- Case 3: INT_MIN - INT_MIN = 0 ---
#-------------------------------------------------------
# Sub of extreme

    # a = INT_MIN
    lui  t0, 0x80000

    # b = INT_MIN
    lui  t1, 0x80000

    # Test
    sub  t2, t0, t1	# t0(0x80000) - t1(0x80000) = 0

    # Expected
    xori t3, t1, -1
    addi t3, t3, 1          
    add  t4, t0, t3

    # Check
    xor  t5, t2, t4

#-------------------------------------------------------
# --- Case 4: (-1234) - (1234) ---
#-------------------------------------------------------
# Large Similar numbers  (Random)

    # a = -1234
    lui  t0, -1234
    addi t0, t0, -1234

    # b =  1234
    lui  t1, 1234
    addi t1, t1, 1234

    # Test
    sub  t2, t0, t1

    # Expected
    xori t3, t1, -1
    addi t3, t3, 1
    add  t4, t0, t3

    # Check
    xor  t5, t2, t4

    # Stop 
    wfi