# Test: Verify branch is taken when rs1 > rs2.

.global main
.text
main:
    addi x1, x0, 10       # rs1 = 10
    addi x2, x0, 5        # rs2 = 5
    bge  x1, x2, label    # should branch (10 ≥ 5)
    addi x3, x0, 1        # skipped if branch works
label:
    addi x3, x0, 2        # executed if branch taken

wfi