/*
  Assembler program to convert a string to
  all upper case by calling a function.
 
  NOTE: uses NULL terminated strings.
  i.e. ASCII code 0 or \0 at end of string.
 
  X0-X2 - parameters to linux function services
  X0 - address of input string
  X1 - address of output string
  X8 - linux function number

*/


// Provide program starting address to linker
.global _start	            

_start: 
    LDR	X0, =instr // start of input string
	LDR	X1, =outstr // address of output string

    BL toupper
    // X0 holds return value = length


end:

    // Store return value into X2
    // Return code is length of string
    MOV	X2, X0      

    // Setup the parameters to print our hex number
    // and then call Linux to do it.
	MOV	X0, #1	    // 1 = StdOut
	LDR	X1, =outstr // string to print
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

