/*
  Assembler program to convert a string to
  all upper case.
 
  NOTE: uses NULL terminated strings.
  i.e. ASCII code 0 or \0 at end of string.
 
  Parameters:
    X0 - address of input string
    X1 - address of output string
  
  Return:
    X0 - Length of output string
      
  Other registers:
    W5 - current character being processed
*/


// Allow other files to call this routine
.global toupper 

toupper: 
    // Save starting address of output string
    MOV X4, X1 

    // PUSH LR to stack
    STR LR, [SP, #-16]! // move SP, store LR and update SP

// The loop is until byte pointed to by X0 is non-zero
loop:	
    LDRB	W5, [X0], #1	// load input string character and increment pointer

    // If W5 > 'z' then goto `cont`
	CMP	    W5, #'z'	    // is letter > 'z'?
	B.GT	cont

    // << or >>
    
    // Else if W5 < 'a' then goto `cont`
	CMP	    W5, #'a'
	B.LT	cont	// goto to end if, if < 'a'

    // << then >>
    // if we got here then the letter is lower case, so convert it.
	SUB	W5, W5, #('a'-'A')

cont:	// << end if >>
    // Note below uses post-indexing to update address in X3
	STRB	W5, [X1], #1	// store character to output str
	CMP	    W5, #0		    // stop on hitting a null character
	B.NE	loop		    // loop if character isn't null

    // Get length by subtracting pointers,
    // and place value in return registers
    // X0 = end_address - start_address
    SUB X0, X1, X4


    // POP LR from stack
    LDR LR, [SP], #16 // load SP into LR, shrink SP
    // return to address held in LR
    RET
