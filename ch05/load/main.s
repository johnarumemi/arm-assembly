// Program entry point
.global _start

_start:
	LDR X1, =mynumber // addreses are 64 bit, so store in X register
	LDR W12, [X1]     // load data at addres of X1 into w12

	LDR X1, =arr1 // load address of arr1 into memory using PC-relative addressing

	// loads 32 bits = 4 bytes = 1 word
	LDR W2, [X1]           // load first element
	LDR W4, [X1, #(2 * 4)] // 8 byte offset to access 3rd element (index 2)

	// offsets using registers, must use an X register
	MOV X3, #(2 * 4) // 8 byte offset using an immediate instruction
	LDR W4, [X1, X3] // [base, offset in bytes]

	MOV X2, #2
	LDR W4, [X1, X2, LSL 2] // w2=2 LSL 2, = 2 * 2^2 = 8 bytes offset

	// instruct CPU to save the calculated address back into X1
	// only works for immediate offsets, not when a register is used
	LDR w2, [x1, #(2 * 4)]! // save address [x1, #(2 * 4)] back into X1

endprogram:
	mov x0, #0
	mov x8, #93
	svc 0

	// assemlber lays these our byte by byte.
	// So might need to manually specify alignment

	.data

mynumber:
	.quad  0x123456789ABCDEF0 // quad word = 8 bytes = 64 bits
	.align 4                  // align next data to 4 byte boundary

arr1:
	.fill 10, 4, 0 // 10 elements, 4 bytes each, values of 0
