.data

vals: .word 0xFFFF0000 0xFFFF0001 0xFFFF7FFF 0xFFFF5555 0xFFFF2AAA


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
