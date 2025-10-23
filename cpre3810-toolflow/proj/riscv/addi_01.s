.data
.text
.option norvc
.globl main
main:
    # Zeroing destination regs using addi rd, x0, 0
    addi x1, x0, 0      # x1=0
    addi x2, x0, 0      # x2=0

    # Positive immediate max: +2047
    addi x3, x0, 2047   # x3=2047

    # Negative immediate min: -2048
    addi x4, x0, -2048  # x4=0xFFFFF800

    # Crossing zero with negative addi
    addi x5, x3, -2047  # x5=0

    # -1 by 0 + (-1)
    addi x6, x0, -1     # x6=0xFFFFFFFF

    # Wrap behavior: 0xFFFFFFFF + 1 -> 0x00000000
    addi x7, x6, 1      

    # Small positive -> negative via subtract
    addi x8, x0, 1      # x8=1
    addi x9, x8, -2     # x9=0xFFFFFFFF

    # Dependency chain on same rd
    addi x10, x0, 1000
    addi x10, x10, 47
    addi x10, x10, -1047 # x10=0

    # Imm = 0 equivalences
    addi x11, x10, 0    # x11=x10
    addi x0, x0, 0      # NOP
    
    wfi
#end:
 #   j end
