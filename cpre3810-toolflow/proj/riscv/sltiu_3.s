#sltiu_Annikags_3.s
#Set<Immediate Unsigned R[rd]=(R[rs1]<imm)?1:0
.data
.text
.global main

main:

  #Start Test: Unsigned test (negatives) and edge cases
  
  #Why/Value: These tests ensure that the values taken are treated as
  #their unsigned values rather than signed ones. The edge cases are
  #important to ensure they still work the same.

  #Basic values to use
  addi x1, x0, -1  #x1 = xFFFFFFFF (NOT -1)
  
  sltiu x2, x1, 0  #xFFFFFFFF<0 is false so x2 = 0
  sltiu x3, x0, -1  #0<xFFFFFFFF(NOT -1) is true so x3 = 1
  
  #More basic values to use
  addi x4, x0, 2046
  addi x5, x0, 2047
  
  #High edge case
  sltiu x6, x4, 2047  #2046<2047 is true so x6 = 1
  sltiu x7, x5, 2047  #2047<2047 is false so x7 = 0
  
  #Check answers:
  #x1=2047, x2=0, x3=1
  #x4=2046, x5=2047, x6=1, x7=0

end:
  wfi
#  j end
