#Dylan Kramer
.data
.text
.globl main
main:
#This test program will check for working edge values and overflows. This is a stress test for signed edge cases and where normal subtraction
#could cause overflow. Some basic overflow and boundary checks were done is slt_dkramer1_2.s, but this is more in-depth.
addi x31, x0, 0 #This will be our error counter
#test1
# INT_MIN < INT_MAX = 1
#testing lowest negative with highest positive and ensuring correct output from slt
lui  x5, 0x80000
lui  x6, 0x80000
addi x6, x6, -1
slt  x7, x5, x6
addi x8, x0, 1
xor  x9, x7, x8
or   x31, x31, x9 #check for errors
#test2
# INT_MAX < INT_MIN = 0
#testing highest positive and lowest negative to ensure correct output from slt (reverse of test1)
slt  x7, x6, x5
addi x8, x0, 0
xor  x9, x7, x8
or   x31, x31, x9 #check for errors
#test3
# INT_MIN < -1 = 1
#testing lowest negative and -1 to test large negative and small negative for correct output
addi x10, x0, -1
slt  x7, x5, x10
addi x8, x0, 1
xor  x9, x7, x8
or   x31, x31, x9 #check for errors
#test4
# -1 < INT_MIN = 0
#testing -1 and lowest negative to test small negative and large negative for correct output (reverse of test3)
slt  x7, x10, x5
addi x8, x0, 0
xor  x9, x7, x8
or   x31, x31, x9 #check for errors
#test5
# INT_MAX < 0 = 0
#testing the highest positive and lowest positive to check for correct output
addi x10, x0, 0
slt  x7, x6, x10
addi x8, x0, 0
xor  x9, x7, x8
or   x31, x31, x9 #check for errors
#test6
# 0 < INT_MIN = 0
#checking to ensure 0 is greater than lowest negative for correct output
slt  x7, x10, x5
addi x8, x0, 0
xor  x9, x7, x8
or   x31, x31, x9 #check for errors

end:
wfi #if x31 = 0, test is good and nothing is broken. If x31 > 0, houston we got a problem!
#j end
