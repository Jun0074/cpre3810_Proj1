#Dylan Kramer
.data
.text
.globl main
main:
#This specific test program does immediate boundary and carry tests. Pretty much it is making sure slt is working
#correctly near the limit of a 12-bit immediate, and also if it is correct after addition that create carries
addi x31, x0, 0 #Adds up num of errors
#test1
# 0 vs 0 = 0
#basic equality check for boundary of zero
addi x5,  x0, 0
addi x6,  x0, 0
slt  x7,  x5, x6
addi x8,  x0, 0
xor  x9,  x7, x8
or   x31, x31, x9 #check for errors
#test2
# -2048 vs 0 = 1
#test with smallest 12-bit immediate. Sign extension check
addi x5,  x0, -2048
addi x6,  x0, 0
slt  x7,  x5, x6
addi x8,  x0, 1
xor  x9,  x7, x8
or   x31, x31, x9 #check for errors
#test3
# +2047 vs 0 = 0
#test with largest 12-bit immediate. Verifies slt is handling edge cases correctly
addi x5,  x0, 2047
addi x6,  x0, 0
slt  x7,  x5, x6
addi x8,  x0, 0
xor  x9,  x7, x8
or   x31, x31, x9 #check for errors
#test4
# -2048 vs +2047 = 1
#Compares both signed 12-bit maximums (neg and pos). Verifies slt is handling signs and extremes correctly
addi x5,  x0, -2048
addi x6,  x0, 2047
slt  x7,  x5, x6
addi x8,  x0, 1
xor  x9,  x7, x8
or   x31, x31, x9 #check for errors
#test5
# carry: 2047 + 1 = 2048; 2048 vs -2048 = 0
#Testing overflow
addi x5,  x0, 2047
addi x5,  x5, 1
addi x6,  x0, -2048
slt  x7,  x5, x6
addi x8,  x0, 0
xor  x9,  x7, x8
or   x31, x31, x9 #check for errors

end:
wfi # x31 == 0 => all passed. x31 holds our num of errors, so if it is >0, something is wrong!