
#Switchums!
#This code tests what happens when the instruction replaces its
#input address register with the byte its loading.

#The only instructions above mine that I 
#used for this test were addi, lui, and lw.

#memory is assumed to begin at 0x10010000, as it does in rars.
.data
pointer_data:
	.word 0x10010004
	.word 0xDEADBEEF
	
.text
.global main

main:
	#First i loaded the base address of the pointer to deadbeef
	lui t0, 0x10010
	
	#Test 1: load a pointer and use that to receive a byte
	#expected: t2 = 0x000000EF
	lw t1, 0(t0)
	lbu t2, 0(t1)
	
	#Test 2: switchums! replace the input address
	#Expected: t0 = 0x00000004
	lbu t0, 0(t0)
	
end:
	wfi
	#j end
