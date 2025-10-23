#Proof that it the instruction zero extends and not a negative hex
.data
value:   .half 0x8000   #16 bit value for memory

.text
.globl main

main:

    la   x5, value      #load address of value into x5
    lhu  x6, 0(x5)       #load halfword into x6

    # Start Test

    lhu   x0,  0(x5)
    lhu   x1,  0(x5)
    lhu   x2,  0(x5)
    lhu   x3,  0(x5)
    lhu   x4,  0(x5)
    #ignore register x5 because it holds the address
    lhu   x6,  0(x5)
    lhu   x7,  0(x5)
    lhu   x8,  0(x5)
    lhu   x9,  0(x5)
    lhu   x10, 0(x5)
    lhu   x11, 0(x5)
    lhu   x12, 0(x5)
    lhu   x13, 0(x5)
    lhu   x14, 0(x5)
    lhu   x15, 0(x5)
    lhu   x16, 0(x5)
    lhu   x17, 0(x5)
    lhu   x18, 0(x5)
    lhu   x19, 0(x5)
    lhu   x20, 0(x5)
    lhu   x21, 0(x5)
    lhu   x22, 0(x5)
    lhu   x23, 0(x5)
    lhu   x24, 0(x5)
    lhu   x25, 0(x5)
    lhu   x26, 0(x5)
    lhu   x27, 0(x5)
    lhu   x28, 0(x5)
    lhu   x29, 0(x5)
    lhu   x30, 0(x5)
    lhu   x31, 0(x5)
    #now address x5
    lhu   x5,  0(x5)   
    #So expecting 0x00008000, not some negative sign extend

  end:
    wfi               
  #  j end             
