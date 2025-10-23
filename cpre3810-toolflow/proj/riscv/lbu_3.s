.data
byte_data: .byte 0xAB, 0xCD, 0xEF, 0x12, 0xCD, 0xEF, 0x12   # same 4 bytes
result:    .word 0                         # to store loaded value

.text
.globl main
main:
    la t0, byte_data      # load base address
    la t2, result      # load base address
    
    lbu t1, 4(t0)         # load third byte (0xEF) unsigned

    sw t1, 0(t2)      # store loaded value
    wfi                   # end / wait for interrupt

