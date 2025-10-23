#; addi avid42i 2.s
#; avid421 586544015
#; Test file 2
#; The second file tests the edge cases of the 12 bit signed immediate by chekcing max min and zero imediates

    .data
    .text
    .globl main

main:
 #   ;The first tests is that i try to use the max positive 12 bit immediate value
  #  ;my justifiaction is that this makes sure that the processor correctly reads the immediate 0x7FF which 2047
    addi x1, x0, 2047     

   # ;my second test is that i try to use the min negative 12 bit immediate value
   # ;my justifiaction is that this makes sure that the processor correctly sign extends so -2048
    addi x2, x0, -2048      

    #;My third test is that i try to add the max positive immediate to a a value bigger than 0
    #; my justification is that i try to make sure that the addition works correctly at the upper part so 2047 + 2047= 4094
    addi x3, x1, 2047  

    #;my last test i try to use the zero immediate
    #;my justification is that the immediate of 0 should make addi a move so this tests if x5 can copy x1 so x5 = x1 = 2047
    addi x5, x1, 0      

#end:
    wfi
    #j end