#Testing Normal Substraction with different variations
# Values cover normal arithmetic

# For each of  the cases:
#	1) Compute Testing Sub
#	2) Compute Expected with xor and add : a + (~b + 1) 
# 	3) Check Difference



    .text
    .globl main

main:

#-------------------------------------------------------
# --- Case 1: 5 - 3 = 2---
#-------------------------------------------------------
# Common subtractino.
  
    #Test
    addi t0, x0, 5          
    addi t1, x0, 3          
    sub  t2, t0, t1         # t0(5) - t1(3) = 2

   #Expected	
    xori t3, t1, -1         # ~t1(3)
    addi t3, t3, 1          # -3 
    add  t4, t0, t3         # t0(5) + t3(-3) = 2
    
    #Check differences between Test and Expected
    xor  t5, t2, t4         # difference t2==t4
    

#-------------------------------------------------------
# --- Case 2: 3 - 5 = -2 ---
#-------------------------------------------------------
#Negative Result

    #Test	
    addi t0, x0, 3
    addi t1, x0, 5
    sub  t2, t0, t1	# t0(3) - t1(5) = -2
    
    #Expected
    xori t3, t1, -1	# ~t1(5)
    addi t3, t3, 1		# -5 
    add  t4, t0, t3	# t0(3) + t3(-5) = -2
        
    #Check differences between Test and Expected
    xor  t5, t2, t4	# difference t2==t4
    

#-------------------------------------------------------
# --- Case 3: 0 - 0 = 0 ---
#-------------------------------------------------------
# Substract zero - zero

    #Test	
    addi t0, x0, 0
    addi t1, x0, 0
    sub  t2, t0, t1	#t0(0) - t1(0)
    
    #Expected
    xori t3, t1, -1	#~t1(0)
    addi t3, t3, 1		#-0
    add  t4, t0, t3	#t0(0) + t3(0)
    
     #Check differences between Test and Expected
    xor  t5, t2, t4	#Difference t2==t4
    

#-------------------------------------------------------
# --- Case 4: 0 - 7 = -7 ---
#-------------------------------------------------------
# Substract zero (Making sure x0 works)

    #Test
    addi t0, x0, 0
    addi t1, x0, 7
    sub  t2, t0, t1	# t0(0) - t1(7) = -7
    
    #Expected
    xori t3, t1, -1
    addi t3, t3, 1
    add  t4, t0, t3
    
    #Check differences between Test and Expected    
    xor  t5, t2, t4	#Difference t2==t4

#-------------------------------------------------------
# --- Case 5: 7 - 0 = 7 ---
#-------------------------------------------------------
# Substract zero pt.2 (Making sure x0 works)

    #Test
    addi t0, x0, 7
    addi t1, x0, 0
    sub  t2, t0, t1	# t0(7) - t1(0) = 7
    
   #Expected	    
    xori t3, t1, -1
    addi t3, t3, 1
    add  t4, t0, t3

    #Check differences between Test and Expected        
    xor  t5, t2, t4	#Difference t2==t4

#-------------------------------------------------------
# --- Case 6: -1 - 1 = -2  ---
#-------------------------------------------------------
#Both Negatives

    #Test
    addi t0, x0, -1
    addi t1, x0, 1
    sub  t2, t0, t1	# t0(-1) - t1(1) = -2
    
   #Expected	    
    xori t3, t1, -1
    addi t3, t3, 1
    add  t4, t0, t3
    
    #Check differences between Test and Expected    
    xor  t5, t2, t4	#Difference t2==t4
      
    #Stop execution
    wfi
