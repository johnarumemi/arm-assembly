//
// Assembler program to print a register in hex
// to stdout.
//
// X0-X2 - parameters to linux function services
// X1 - is also address of byte we are writing
// X4 - register to print
// W5 - loop index
// W6 - current character
// X8 - linux function number
//

.global _start	 // Provide program starting address


// 0x123 | FEDC | 4F5D | x6E3A  is stored to regiser X4
_start: MOV	X4, #0x6E3A
	MOVK	X4, #0x4F5D, LSL #16
	MOVK	X4, #0xFEDC, LSL #32
	MOVK	X4, #0x1234, LSL #48

    // load address of hexstr to X1
	LDR	X1, =hexstr // start of string
    // increment the virtual address by 17 (end of string)
	ADD	X1, X1, #17	    // start at least sig digit

    // The loop is FOR W5 = 16 TO 1 (STEP -1)
	MOV	W5, #16	    // 16 digits to print

// In the below, by using the 4 bit mask, we are only
// extracting the least significant 4 bits of the register / number.
// This is all we need for a hex digit
loop:	
    AND	W6, W4, #0xf // mask of least sig digit, 0xf = 0b1111
    // If W6 >= 10 then goto letter
	CMP	W6, #10	    // is 0-9 or A-F
	B.GE	letter
    // Else its a number so convert to an ASCII digit
	ADD	W6, W6, #'0'
	B	endif	// goto to end if
letter: // handle the digits A to F
    // Assemlber translates `A` to 65, and substracts 10 to get 55,
    // then uses that as Operand2
	ADD	W6, W6, #('A'-10)
endif:	// end if
    // store register value to memory location in X1
	STRB	W6, [X1]	// store ascii digit 
	SUB	X1, X1, #1		// decrement address for next digit
	LSR	X4, X4, #4	// shift off the digit we just processed

	// next W5
	SUBS	W5, W5, #1		// step W5 by -1
	B.NE	loop		// another for loop if not done

// Setup the parameters to print our hex number
// and then call Linux to do it.
	MOV	X0, #1	    // 1 = StdOut
	LDR	X1, =hexstr // string to print
	MOV	X2, #19	    // length of our string
	MOV	X8, #64	    // linux write system call
	SVC	0 	    // Call linux to output the string

// Setup the parameters to exit the program
// and then call Linux to do it.
	MOV     X0, #0      // Use 0 return code
    MOV     X8, #93     // Service command code 93 terminates this program
    SVC     0           // Call linux to terminate the program

.data
hexstr:      .ascii  "0x123456789ABCDEFG\n"

