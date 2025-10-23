#Dylan Kramer
.data
.text
.globl main
main:
#This test program is conducting basic slt function tests to make sure it is working correctly. Verifies that slt correctly
#sets less than for normal pos and neg numbers
addi x31, x0, 0 #error counter
#test1
# 5 < 7 = 1
#shows slt correctly sets rd=1 when rs1 < rs2.
addi x5, x0, 5
addi x6, x0, 7
slt  x7, x5, x6
addi x8, x0, 1
xor  x9, x7, x8
or   x31, x31, x9 #check for errors
#test2
# 7 < 5 = 0
#shows slt clears rd when rs1 > rs2
addi x5, x0, 7
addi x6, x0, 5
slt  x7, x5, x6
addi x8, x0, 0
xor  x9, x7, x8
or   x31, x31, x9 #Check for errors
#test3
# 0 < 0 = 0
#basic equality test, makes sure slt returns 0 when operands are identical
addi x5, x0, 0
addi x6, x0, 0
slt  x7, x5, x6
addi x8, x0, 0
xor  x9, x7, x8
or   x31, x31, x9 #check for errors
#test4
# -1 < 0 = 1
#checks for correct signed interpretation, unsigned logic would cause failure
addi x5, x0, -1
addi x6, x0, 0
slt  x7, x5, x6
addi x8, x0, 1
xor  x9, x7, x8
or   x31, x31, x9 #check for errors
#test5
# -4 < -3 = 1
#Uses two negative numbers to test for correct two's complement signed comparison. 
addi x5, x0, -4
addi x6, x0, -3
slt  x7, x5, x6
addi x8, x0, 1
xor  x9, x7, x8
or   x31, x31, x9 #check for errors
#test6
# -3 < -4 = 0
#Same as above, using two negatives to test for correct two's complement signed comparison, just swapping 
#the side of the operand the numbers are on
addi x5, x0, -3
addi x6, x0, -4
slt  x7, x5, x6
addi x8, x0, 0
xor  x9, x7, x8
or   x31, x31, x9 #check for errors

end:
wfi #if x31=0, no errors!! If x31 > 0, something is wrong
#j end
