    .option norvc
    .text
    .globl main
main:
  
    # Confirm x0 is always zero and immutable
    addi x1, x0, 123    # x1 = 123; load small positive via x0
    addi x0, x1, 1      # Attempt to write to x0; must remain 0
    addi x2, x0, 0      # x2 = 0; verify x0 unchanged

    # Load negative constants from x0 using sign-extension
    addi x3, x0, -1     # x3 = 0xFFFFFFFF; small negative constant
    addi x4, x0, -2048  # x4 = 0xFFFFF800; largest negative 12-bit immediate

    

    addi x5, x3, 1      # -1 + 1 = 0; wraps correctly, no trap
    addi x6, x4, 2047   # (-2048) + 2048 = 0; checks ALU sum with extremes

    # Confirm addi doesn't trap on overflow; only low XLEN bits kept
    addi x7, x3, 2047   # 0xFFFFFFFF + 2047 = 2046 (mod 2^32)
    addi x8, x0, 2047   # x8 = 2047; positive max immediate reference



    addi x9,  x0, 2046  # x9 = 2046; near positive immediate limit
    addi x9,  x9, 1     # x9 = 2047; step to upper boundary
    addi x9,  x9, 1     # x9 = 2048; ensure ALU handles sum beyond 12-bit imm

    addi x10, x0, 0     # x10 = 0; dependency chain start
    addi x10, x10, 100  # x10 = 100
    addi x10, x10, -50  # x10 = 50; tests negative immediate in chain
    addi x10, x10, -50  # x10 = 0; ensure proper ALU forwarding

 

    addi x11, x10, 0    # x11 = x10; tests mv alias behavior
    addi x0,  x0,  0    # NOP; ensure x0 remains immutable

    wfi
#end:
 #   j end               # Infinite loop to terminate test
