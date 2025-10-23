.data

.text
.globl main

main:

lui t0, 0x80000 #largest negative number
srai t1, t0, 0            #no change
srai t1, t0, 1            #0xC0000000
srai t1, t0, 2            
srai t1, t0, 3           
srai t1, t0, 4
srai t1, t0, 5
srai t1, t0, 6
srai t1, t0, 7
srai t1, t0, 8
srai t1, t0, 9
srai t1, t0, 10
srai t1, t0, 11
srai t1, t0, 12
srai t1, t0, 13
srai t1, t0, 14
srai t1, t0, 15
srai t1, t0, 16
srai t1, t0, 17
srai t1, t0, 18
srai t1, t0, 19
srai t1, t0, 20
srai t1, t0, 21
srai t1, t0, 22
srai t1, t0, 23
srai t1, t0, 24
srai t1, t0, 25
srai t1, t0, 26
srai t1, t0, 27
srai t1, t0, 28
srai t1, t0, 29
srai t1, t0, 30 
srai t1, t0, 31           #0xFFFFFFFF

#This test checks every shift, as well as sign extension


end:
wfi
#j end
