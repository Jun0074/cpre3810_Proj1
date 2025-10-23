#; addi_test_1.s
#; avid421 586544015
#; Test file 1
#; The first file tests the addi instructions for basic addition, subtraction, and the zero register.

    .data
    .text
    .globl main

main:
  #  ;The first test is i load a positive immediate value in the register
 #   ;my justification is that this is the most common use case for the addi creating a small constant
 #   ;this test adds a positive immediate to the zero register so it should do x1 = 0 + 15 = 15
    addi x1, x0, 15

 #   ;the second test loads a negative immediate value in the register
 #   ; my Justification is that this makes sure that the 12 bit immediate is sign extended correct and added to sign register
 #   ;so it would be x2 = 0 + (-10) = -10
    addi x2, x0, -10

 #   ;the third test adds a positive immediate to a non zero register
#    ;my justification is that this tests the ALU addition when the rs1 is not x0 so x3 = 15 + 5 = 20
    addi x3, x1, 5

  #  ;The fourth test adds a negative immediate to the non zero register so the subtraction
 #   ; my justification is that this tests the ALU subtraction when rs1 is not x0 so x4 = 15 + (-5) = 10
    addi x4, x1, -5

  #  ;the last test attempts to write the result to the zero register x0
  #  ;my justification is that this tests when the x0 register must always be zero and it should ignore all the writes
  #  ;so i expect x0 to remain 0
    addi x0, x1, 100

#end:

    wfi

