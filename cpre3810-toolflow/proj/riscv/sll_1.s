# Basic Unit Tests, typical function
# Using Addi in test cases

.data
.text
.globl main

main:
# typical case
# shift left by small number
addi t0, zero, 5
addi t1, zero, 2
sll a0, t0, t1 #expected b101 (x5) to be shifted left 2 -> b10100 (x14)

# typical case
addi t0, zero, 7
addi t1, zero, 4
sll a3, t0, t1 #expected to be x70

# typical case
addi t0, zero, 1
addi t1, zero, 10
sll a4, t0, t1 #expected to be 400

# shift by zero
addi t0, zero, 5
addi t1, zero, 0
sll a1, t0, t1 #expected to be x5 since shift value is 0

# value to be shifted is zero
addi t0, zero, 0
addi t1, zero, 10
sll a2, t0, t1 #expected to be 0x0 still

end:
wfi
#j end
