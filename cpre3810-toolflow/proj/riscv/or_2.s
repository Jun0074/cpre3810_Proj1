# or auhun47 2.s
# Tests:
#   (1) 0x80000000 | 0x7FFFFFFF = 0xFFFFFFFF
#   (2) rd == rs1
#   (3) rd == rs2
#   (4) x | ~0 = ~0
# PASS if x3 == 0.

.data
.text
.globl main
main:
    addi s7, x0, 0          # error accumulator

    lui  t0, 0x80000        	# t0 = 0x80000000
    addi t1, x0, -1  		# t1 = 0xFFFFFFFF
    xor  t3, t1, t0         	# t3 = 0x7FFFFFFF

    # (1) MSB + all-ones = 0xFFFFFFFF
    or   t4, t0, t3
    xor  t5, t4, t1
    or   s7, s7, t5

    # (2) rd == rs1
    addi s1, x0, 0
    or   s1, s1, t0
    xor  s2, s1, t0
    or   s7, s7, s2

    # (3) rd == rs2
    addi s3, x0, 0
    or   s3, t3, s3
    xor  s4, s3, t3
    or   s7, s7, s4

    # (4) x | ~0 = ~0
    or   s5, t0, t1
    xor  s6, s5, t1
    or   s7, s7, s6

    add  x3, s7, x0         # x3 == 0 => PASS
end:
    wfi                     # wait
