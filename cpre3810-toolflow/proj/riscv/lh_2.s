.data

vals: .word 0x8000 0xFFFF 0xAAAA 0xD555


.text
.globl main


main:

lui x1, 0x10010

lh x2, 0(x1)
lh x3, 4(x1)
lh x4, 8(x1)
lh x5, 12(x1)


#end:
wfi
#j end
