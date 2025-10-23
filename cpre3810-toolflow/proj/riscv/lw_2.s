.data
#pre adding data to memory to call later
test_word:
    .word 0x00000000
.text
.globl main

main:

    # Start Test
    #using lui (and addi above lw) to initialize some addresses for memory loading
    lui   t0, %hi(test_word)
    addi  t0, t0, %lo(test_word)
    
    lw x1, 0(t0)     # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x2, 0(t0)     # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x3, 0(t0)     # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x4, 0(t0)     # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x6, 0(t0)     # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x7, 0(t0)     # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x8, 0(t0)     # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x9, 0(t0)     # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x10, 0(t0)    # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x11, 0(t0)    # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x12, 0(t0)    # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x13, 0(t0)    # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x14, 0(t0)    # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x15, 0(t0)    # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x16, 0(t0)    # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x17, 0(t0)    # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x18, 0(t0)    # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x19, 0(t0)    # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x20, 0(t0)    # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x21, 0(t0)    # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x22, 0(t0)    # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x23, 0(t0)    # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x24, 0(t0)    # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x25, 0(t0)    # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x26, 0(t0)    # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x27, 0(t0)    # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x28, 0(t0)    # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x29, 0(t0)    # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x30, 0(t0)    # verify that one can load zero value from memory into registers (essentially clearing a register)
    lw x31, 0(t0)    # verify that one can load zero value from memory into registers (essentially clearing a register)
    
    #as x5 is where t0 is correlated, it will be loaded last since it contains the main address for the word
    lw x5, 0(t0)     # verify that one can load zero value from memory into registers (essentially clearing a register)
    
    #Expected result of test: value of "word" 0x00000000 (zero value) loaded into every register
    #This test also ensures that every register can handle zero values being loaded and that memory can store values

 # end:
    wfi               
 #   j end             
