# or auhun47 3.s
# Tests:
#   (1) x0 write ignored
#   (2) chained OR == reference
#   (3) self-OR no-op
# PASS if x3 == 0.

.data
.text
.globl main
main:
    addi s7, x0, 0

    # m0 = 0x0000000F, m1 = 0x00FF0000, m2 = 0x80000000
    addi s0, x0, 15
    lui  s1, 0x00FF0
    lui  s2, 0x80000

    # reference = m0 | m1 | m2  => 0x80FF000F
    or   s3, s0, s1
    or   s3, s3, s2

    # (2) chained to match reference
    addi t0, x0, 0
    or   t0, t0, s0
    or   t0, t0, s1
    or   t0, t0, s2
    xor  t1, t0, s3           # expect 0
    or   s7, s7, t1

    # (3) self-OR: x|x = x
    or   t2, s0, s0
    xor  t3, t2, s0           # expect 0
    or   s7, s7, t3

    # (1) x0 write ignored
    or   x0, s0, s1           # x0 must remain 0
    addi t4, x0, 0
    or   s7, s7, t4           # any nonzero => fail

    add  x3, s7, x0           # x3 == 0 => PASS
end:
    wfi
