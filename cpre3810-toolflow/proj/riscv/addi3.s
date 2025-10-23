#; Filename: addi avid42i 3.s
#; avid421
#; Test File 3
#; This file tests the data and register where the destination register and source register are same

    .data
    .text
    .globl main

main:
 #   ;The first test is to make sure that the rd = rs1
  #  ;my justification is that this tests that the processor correctly makes the the result of the first instruction to the second
   # ;so it should be x1 = 100 + 50 = 150
    addi x1, x0, 100        
    addi x1, x1, 50         

   # ;The second test  A chain of dependent additions.
   # ;my justification is that this creates more complex cahined process liekd real world to test if this works good
   # ;so it should be x2=1 x3 = 2 x4=3 x5=4
    addi x2, x0, 1        
    addi x3, x2, 1          
    addi x4, x3, 1          
    addi x5, x4, 1          

    #;The thrid test is that i do bunch of additions to make a larger number
    #;my justification is that this tests the repeated writes and reads to the same register in the sequence
   # ; so x6 = 1000 x6 = 2000 and x6 = 2300
    addi x6, x0, 1000       
    addi x6, x6, 1000       
    addi x6, x6, -200       

#end:
    wfi
 #   j end