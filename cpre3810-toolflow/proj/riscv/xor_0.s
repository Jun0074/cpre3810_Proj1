.data
.text
.globl main
main:
    addi x5,  x0, 0          # a = 0        
    addi x6,  x0, 1          # b = 1       
    addi x7,  x0, -1         # c = -1        
    addi x8,  x0, 7          # d = 7  (0b111)     
    addi x9,  x0, 10         # e = 10      
# for the first test i am doing the basic xor properties 
    # Checking for the x ^ 0 = x
    xor  x10, x6, x5         # 1 ^ 0 = 1
    add  x11, x10, x0        # x11 = 1
    xor  x12, x11, x6        # x12 = (1^0) ^ 1 = 0
    add  x20, x0, x12        

    # Now i am checking for the identity x^x = 0
    xor  x13, x8, x8         # 7 ^ 7 = 0 
    add  x21, x0, x13        # x21 = 0

    # now zero operand is first 0 ^ x = x
    xor  x14, x5, x9         # 0 ^ 10 = 10
    xor  x22, x14, x9        # z3 = (0^10) ^ 10 = 0 

    # Commutativity property a^b == b^a
    xor  x15, x6, x8         # left = 1^7 = 6 = 0x6
    xor  x16, x8, x6         # right = 7^1 = 6
    xor  x23, x15, x16       # x23 = left ^ right = 0 (it should give zero because both values are same)

    # Associativity property (a^b)^c == a^(b^c)
    xor  x17, x6, x8         # t1 = a^b
    xor  x17, x17, x9        # left = (a^b)^c
    xor  x18, x8, x9         # t2 = b^c
    xor  x18, x6, x18        # right = a^(b^c)
    xor  x24, x17, x18       # z5 = left ^ right = 0 (same as above or x^x = 0 )

end:
    wfi

