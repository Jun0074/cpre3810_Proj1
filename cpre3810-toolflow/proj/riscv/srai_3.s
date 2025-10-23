.data

.text
.globl main

main:

lui t0, 0x55550           #0x55550000
srai t1, t0, 1            #0x2AAA8000
srai t1, t0, 15           #0x0000AAAA

lui t0, 0xCCCC0           #0xCCCC0000
srai t1, t0, 1            #0xE6660000
srai t1, t0, 15           #0xFFFF9998

lui t0, 0x80000 
addi t0, t0, -1           #largest positive number, 0x7FFFFFFF
srai t1, t0, 1            #0x3FFFFFFF
srai t1, t0, 31           #0x00000000

#these tests check the shifting mechanism with larger/more complicated values,
#as well as sign extension 

end:
wfi
#j end
