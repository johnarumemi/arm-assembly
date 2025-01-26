// Program entry point
// since we are using gcc with C runtime,
// we use `main` rather than `_start`
.global main

.include "debug.s"

main:
	// -- Exampe 1: MUL - multiply 64bit registers
	// load registers with small +ve numbers
	mov x2, #25
	mov x3, #4

	printStr "Inputs:"
	printReg 2
	printReg 3

	mul      x4, x2, x3      // 25 * 4 = 100
	printStr "MUL X4=X2*X3:"
	printReg 4

	// -- Exampe 2: MUL - multiply 32bit registers
	// load registers with small +ve numbers
	mul      w4, w2, w3      // 25 * 4 = 100
	printStr "MUL W4=W2*W3:"
	printReg 4

	// -- Example 3: MNEG - multiply 64bit registers and negate result
	mneg     x4, x2, x3
	printStr "MNEG X4=-(X2*X3):"
	printReg 4

	// -- Example 4: SMULL - Signed multiplication of 32bit numbers
	SMULL    x4, w2, w3        // note use of only first 32 bits of x2 and x3
	printStr "SMULL X4=W2*W3:"
	printReg 4

	// -- Example 5: SMNEGL - Signed multiplication of 32bit numbers and negate result
	SMNEGL   X4, W2, W3
	printStr "SMNEGL X4=-(W2*W3):"
	printReg 4

	// -- Example 6: UMULL - Unsigned multiplication of 32bit numbers
	UMULL    X4, W2, W3
	printStr "UMULL X4=W2*W3:"
	printReg 4

	// -- Example 7: UMNEGL - Unsigned multiplication of 32bit numbers and negate result
	UMNEGL   X4, W2, W3
	printStr "UMNEGL X4=-(W2*W3):"
	printReg 4

	// -- With large numbers
	LDR X2, =A   // load address of A into X2
	LDR X2, [X2] // load value at address in X2 into X2
	LDR X3, =B   // load address of B into X3
	LDR X3, [X3] // load value at address in X3 into X3

	printStr "Inputs:"
	printReg 2
	printReg 3

	MUL      X4, X2, X3
	printStr "MUL X4 = bottom 64 bits of X2*X3"
	printReg 4

	SMULH    X4, X2, X3
	printStr "SMULH X4 = top 64 bits of X2*X3 (signed)"
	printReg 4

	UMULH    X4, X2, X3
	printStr "UMULH X4 = top 64 bits of X2*X3 (unsigned)"
	printReg 4

	mov x1, #0 // exit code
	ret

// Below is appended to data section of the program
.data

A:
	.dword 0x7812345678

B:
	.dword 0xFABCD12345678901
