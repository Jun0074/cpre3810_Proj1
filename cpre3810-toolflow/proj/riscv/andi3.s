    .data
result_zero:
    .word 0
result_id:
    .word 0
result_x0:
    .word 0

    .text
    .globl main

main:
    # Test 3: edge cases
    # Case A: andi with immediate 0 should zero out
    li   t0, 0xDEADBEEF
    andi t1, t0, 0          # t1 = 0
    la   t2, result_zero
    sw   t1, 0(t2)

    # Case B: andi with imm = -1 (0xFFF) -> sign-extended all ones -> identity
    li   t0, 0xCAFEBABE
    andi t1, t0, -1         # -1 (12-bit 0xFFF) sign-extended -> all 1s -> t1 == t0
    la   t2, result_id
    sw   t1, 0(t2)

    # Case C: andi with rs1 = x0 (zero register) should produce zero regardless of imm
    # andi t1, x0, 0x7FF (some imm) -> 0
    andi t3, x0, 0x7FF
    la   t2, result_x0
    sw   t3, 0(t2)

    wfi

