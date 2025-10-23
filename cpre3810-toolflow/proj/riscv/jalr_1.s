.data

.text
.globl main

main:
    la x4, target           # load address of target
    jalr ra, 8(x4)          # jump to target; save next PC to ra

target:
    addi x6, x0, 99         # dummy compute
    jr ra                   # return to after_return
    

after_return:
    addi x5, x0, 1          # instruction after return
    wfi                     # optional, will just wait if not terminated

