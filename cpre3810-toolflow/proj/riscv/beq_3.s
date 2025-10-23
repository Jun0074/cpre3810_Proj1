.data
.text
.globl main
main:
# Test 1: Forward branch
# Tests PC-relative forward offset calculation.
addi x1, x0, 1
addi x2, x0, 1
beq x1, x2, target
addi x3, x0, -1

target:
# Test 2: Backward branch (loop)
# Tests negative PC offset for loop behavior.
addi x4, x0, 0
addi x5, x0, 2

loop:
    addi x4, x4, 1
    beq x4, x5, done
    beq x0, x0, loop

done:
    addi x6, x0, 1

end:
    wfi
    #j end
