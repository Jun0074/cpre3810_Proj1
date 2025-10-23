.data
byte_data: .byte 0xAB, 0xCD, 0xEF, 0x12   # 4 bytes
result:    .word 0                         # to store loaded value

.text
.globl main
main:
    la t0, byte_data      # load base address
    la t2, result
    lbu t1, 0(t0)         # load first byte (0xAB) unsigned

    sw t1, 0(t2)      # store loaded value
    wfi                   # end / wait for interrupt

