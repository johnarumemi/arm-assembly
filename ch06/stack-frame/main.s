/*
  Assembler program to convert a string to
  all upper case by calling a function.
 
  NOTE: uses NULL terminated strings.
  i.e. ASCII code 0 or \0 at end of string.
 
  X0-X2 - parameters to linux function services
  W0 - address of input string
  W1 - address of output string
  X8 - linux function number

*/


// Provide program starting address to linker
.global _start	            

_start: 
    MOV	X0, 1 // start of input string
	MOV	X1, 2 // address of output string

    BL sumfn
    // X0 holds return value = length


end:

    // Store return value into X2
    // Return code is the SUM value
    MOV	X3, X0      

    // Setup the parameters to print our hex number
    // and then call Linux to do it.
	MOV	X0, #1	    // 1 = StdOut
	LDR	X1, X2      // string to print
    ; MOV X2, X3      // length of string
	MOV	X8, #64	    // linux write system call
	SVC	0 	        // Call Linux to output the string

    // Setup the parameters to exit the program
    // and then call Linux to do it.
	MOV     X0, X3      // Use 0 return code
    MOV     X8, #93     // Service code 93 terminates
    SVC     0           // Call Linux to terminate the program

