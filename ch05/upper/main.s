/*
  Assembler program to convert a string to
  all upper case.
 
  NOTE: uses NULL terminated strings.
  i.e. ASCII code 0 or \0 at end of string.
 
  X0-X2 - parameters to linux function services
  X3 - address of output string
  X4 - address of input string
  W5 - current character being processed
  X8 - linux function number

*/


// Provide program starting address to linker
.global _start	            

_start: 
    LDR	X4, =instr // start of input string
	LDR	X3, =outstr // address of output string

// The loop is until byte pointed to by X1 is non-zero
loop:	
    LDRB	W5, [X4], #1	// load character and increment pointer

    // If W5 > 'z' then goto cont
	CMP	    W5, #'z'	    // is letter > 'z'?
	B.GT	cont

    // << or >>
    
    // Else if W5 < 'a' then goto end if
	CMP	    W5, #'a'
	B.LT	cont	// goto to end if, if < 'a'

    // << then >>
    // if we got here then the letter is lower case, so convert it.
	SUB	W5, W5, #('a'-'A')

cont:	// << end if >>
    // Note below uses post-indexing to update address in X3
	STRB	W5, [X3], #1	// store character to output str
	CMP	    W5, #0		    // stop on hitting a null character
	B.NE	loop		    // loop if character isn't null

end:
    // Setup the parameters to print our hex number
    // and then call Linux to do it.
	MOV	X0, #1	    // 1 = StdOut
	LDR	X1, =outstr // string to print
	SUB	X2, X3, X1  // get the length by subtracting the pointers
	MOV	X8, #64	    // linux write system call
	SVC	0 	        // Call Linux to output the string

    // Setup the parameters to exit the program
    // and then call Linux to do it.
	MOV     X0, #0      // Use 0 return code
    MOV     X8, #93     // Service code 93 terminates
    SVC     0           // Call Linux to terminate the program

.data
instr:  .asciz  "This is our Test String that we will convert.\n"
// 255 elements, size of 1 byte, value of 0
outstr:	.fill	255, 1, 0

