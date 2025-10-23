.data

vals: .word 0x0 0x1 0x7FFF 0x5555 0x2AAA


.text
.globl main


main:

lui x1, 0x10010

lh x2, 0(x1)
lh x3, 4(x1)
lh x4, 8(x1)
lh x5, 12(x1)
lh x6, 16(x1)


#end:
wfi
#j end
