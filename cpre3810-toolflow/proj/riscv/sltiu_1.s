#sltiu_Annikags_1.s
#Set<Immediate Unsigned R[rd]=(R[rs1]<imm)?1:0
.data
.text
.global main

main:

  #Start Test: Basic Tests/Functions
  
  #Why/Value: These test cover basic fuctions that stliu
  #will be asked to do. It is important that these simple
  #tasks are done correctly.

  #some basic values to use
  addi x1, x0, 0  #x1 = 0
  addi x2, x0, 3  #x2 = 3
  
  #Tests
  sltiu x3, x1, 1  #0<1 is true so x3 = 1
  sltiu x4, x1, 0  #0<0 is false so x4 = 0
  sltiu x5, x2, 2  #3<2 is false so x5 = 0
  sltiu x6, x2, 3  #3<3 is false so x6 = 0
  sltiu x7, x2, 4  #3<4 is true so x7 = 1
  
  #Check answers:
  #x3=1, x4=0, x5=0, x6=0, and x7=1
  
end:
  wfi
  #j end
