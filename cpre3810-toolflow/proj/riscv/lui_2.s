.data
.text
.globl main

main:
lui t0, 0xFFFFF #loads max value
addi t1, t0, 0x1
# if the above worked, then t1 should be FFFFF001
#these are easy to check values
# this tests the loading because we know addi works (given the
#assignment constraints)
#if it didn't work we know lui did not set the initial values
wfi
