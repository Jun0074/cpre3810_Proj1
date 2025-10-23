.data
result: .word 0         # 0 = not taken, 1 = taken

.text
.globl main
main:
    li t0, 5           # rs1 = 5
    li t1, 3           # rs2 = 3

    li t2, 0           # default result = 0
    bge t0, t1, taken  # branch should be taken because 5 >= 3
    j done

taken:
    li t2, 1           # mark branch taken

done:

    wfi                 # wait for interrupt / end

