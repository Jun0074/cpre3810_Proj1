# or auhun47 1.s
# Tests: x|0=x, x|x=x, x|y==y|x. PASS if x3==0.

.data
.text
.globl main
main:
    addi s7, x0, 0        # error register

    addi t0, x0, 5        # 0101
    addi t1, x0, 10       # 1010

    # x | 0 = x
    or   t2, t0, x0
    xor  t3, t2, t0
    or   s7, s7, t3

    # x | x = x
    or   t4, t0, t0
    xor  t5, t4, t0
    or   s7, s7, t5

    # commutativity
    or   t6, t0, t1
    or   s0, t1, t0
    xor  s1, t6, s0
    or   s7, s7, s1

    add  x3, s7, x0       # x3==0 => PASS
end:
    wfi			# wait