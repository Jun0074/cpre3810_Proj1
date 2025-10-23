.data
.text
.globl main
main:
lui t0 0xFFFFF
lui t1 0xF0F0F
and t2, t0, t1 # result should be 0xF0F0F000
lui t1, 0x0F0F0
and t2, t0, t1
#end:
wfi
#j end
#this tests anding some bits that are one and zero and one and one together to form a pattern. This is to make sure the operation works properly to and when it is 1 and 1 and to clear to zeor when it is 1 and 0 or 0 and 0. 
