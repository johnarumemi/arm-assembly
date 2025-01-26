// Include our debug macros
.include "debug.s"

// Program entry point for C Runtime to link to
.global main

// Restructured as a function
//
// follows calling convention and stores LR at start
// and restores it at the end, then uses `RET`.
main:
	// grow stack and store LR (8 byte) to stack
	str lr, [sp, #-16]!        // pre-indexing with writeback
	mov x2, 0x3                // x2 = 3
	mov x3, 0xffffffffffffffff // will change to MOVN
	mov x4, 0x5
	mov x5, 0x1

	; MOV X2, #0x0000000000000003
	; MOV X3, #0xFFFFFFFFFFFFFFFF // Assembler will change to MOVN

	// Second 64-bit number is 0x00000000000000050000000000000001
	; MOV X4, #0x0000000000000005
	; MOV X5, #0x0000000000000001

	printStr "Inputs:"
	printReg 2
	printReg 3
	printReg 4
	printReg 5

	// ADDS - enable carry flags
	// ADC  - add with carry flags
	ADDS x1, x3, x5 // lower order word
	ADC  x0, x2, x4 // higher order word

	printStr "Outputs:"

	printReg 1
	printReg 0

	mov x0, #0 // return code from our program

	// restore LR and shrink stack
	ldr lr, [sp], #16 // post-indexing

	// grow the stack by 16 bytes
	// use post-indexing to store calculated value to SP

	ret

