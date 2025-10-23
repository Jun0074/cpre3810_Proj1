.data
#pre adding data to memory to call later
test_word:
    .word 0x12345678
.text
.globl main

main:

    # Start Test
    #using lui (and addi above lw) to initialize some addresses for memory loading
    lui   t0, %hi(test_word)
    addi  t0, t0, %lo(test_word)
    
    lw x1, 0(t0)     # verify that one can load into registers and memory is accessible through ALU
    lw x2, 0(t0)     # verify that one can load into registers and memory is accessible through ALU
    lw x3, 0(t0)     # verify that one can load into registers and memory is accessible through ALU
    lw x4, 0(t0)     # verify that one can load into registers and memory is accessible through ALU
    lw x6, 0(t0)     # verify that one can load into registers and memory is accessible through ALU
    lw x7, 0(t0)     # verify that one can load into registers and memory is accessible through ALU
    lw x8, 0(t0)     # verify that one can load into registers and memory is accessible through ALU
    lw x9, 0(t0)     # verify that one can load into registers and memory is accessible through ALU
    lw x10, 0(t0)    # verify that one can load into registers and memory is accessible through ALU
    lw x11, 0(t0)    # verify that one can load into registers and memory is accessible through ALU
    lw x12, 0(t0)    # verify that one can load into registers and memory is accessible through ALU
    lw x13, 0(t0)    # verify that one can load into registers and memory is accessible through ALU
    lw x14, 0(t0)    # verify that one can load into registers and memory is accessible through ALU
    lw x15, 0(t0)    # verify that one can load into registers and memory is accessible through ALU
    lw x16, 0(t0)    # verify that one can load into registers and memory is accessible through ALU
    lw x17, 0(t0)    # verify that one can load into registers and memory is accessible through ALU
    lw x18, 0(t0)    # verify that one can load into registers and memory is accessible through ALU
    lw x19, 0(t0)    # verify that one can load into registers and memory is accessible through ALU
    lw x20, 0(t0)    # verify that one can load into registers and memory is accessible through ALU
    lw x21, 0(t0)    # verify that one can load into registers and memory is accessible through ALU
    lw x22, 0(t0)    # verify that one can load into registers and memory is accessible through ALU
    lw x23, 0(t0)    # verify that one can load into registers and memory is accessible through ALU
    lw x24, 0(t0)    # verify that one can load into registers and memory is accessible through ALU
    lw x25, 0(t0)    # verify that one can load into registers and memory is accessible through ALU
    lw x26, 0(t0)    # verify that one can load into registers and memory is accessible through ALU
    lw x27, 0(t0)    # verify that one can load into registers and memory is accessible through ALU
    lw x28, 0(t0)    # verify that one can load into registers and memory is accessible through ALU
    lw x29, 0(t0)    # verify that one can load into registers and memory is accessible through ALU
    lw x30, 0(t0)    # verify that one can load into registers and memory is accessible through ALU
    lw x31, 0(t0)    # verify that one can load into registers and memory is accessible through ALU
    
    #as x5 is where t0 is correlated, it will be loaded last since it contains the main address for the word
    lw x5, 0(t0)     # verify that one can load into registers and memory is accessible through ALU
    
    #Expected result of test: value of "word" 0x12345678 loaded into every register
    #This test ensures that memory can hold a basic positive value and that each register can in turn have this expected value loaded into it

  #end:
    wfi               
   # j end             
