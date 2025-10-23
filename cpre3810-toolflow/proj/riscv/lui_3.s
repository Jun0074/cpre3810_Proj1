.data
.text
.globl main

main:
addi t0, x0, 0x1 # sets t0 to 0x00000001
lui t0, 0x98765 #loads value over the above
# if the above worked, then t0 should be 98765000
#these are easy to check values
# this tests the loading because we know addi works (given the
#assignment constraints)
#if it didn't work we know lui is not working as intended
#a possible wrong result you may see is if it adds not loads in
wfi
