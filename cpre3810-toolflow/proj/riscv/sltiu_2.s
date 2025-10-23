#sltiu_Annikags_2.s
#Set<Immediate Unsigned R[rd]=(R[rs1]<imm)?1:0
.data
.text
.global main

main:

  #Start Test: Using sltiu written registers, rewriting them, and x0 writting
  
  #Why/Value: These tests ensure that the values are written, can be
  #used, and can be over written as well (excluding x0).

  #Basic value to use
  addi x1, x0, 0  #x1 = 0
  
  #using sltiu writen registers, and rewritting over registers
  sltiu x2, x1, 1  #0<1 is true so x2 = 1 (used for comparison with line 21)
  sltiu x1, x2, 2  #1<2 is true so x1 = 1 (rewritten x1)
  sltiu x3, x1, 1  #1<1 is false so x3 = 0 (same as line 19 but x1 should have a new value)
  
  #More basic values to use
  sltiu x0, x0, 1  #0<1 is true(so = 1) BUT x0 should still = 0
  sltiu x4, x0, 1  #0<1 is true so x4 = 1
  
  #Check answers(in order):
  #x1=0, x2=1, (rewritten)x1=1, x3=0
  #ensre x0=0(regardless of write), x4 =1

end:
  wfi
 # j end
