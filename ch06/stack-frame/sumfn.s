/*

*/
// Define variables, var1, var2, sum and their values
    .EQU VAR1, 0
    .EQU VAR2, 4
    .EQU SUM, 8


// Provide program starting address to linker
.global sumfn	            

sumfn:
    /*  Grow stack by 16-bytes and save following:
        - Callee's LR (this is the LR we need to return to Caller instructions)
        - Caller's FP (Caller's current FP address)
    */ 
    STP LR, FP, [SP, #-16]! 

    // Grow new Stack Frame for Current Function
    SUB FP, SP, #16

    // Adjust SP to top of Stack Frame
    SUB SP, SP, #16

    // Access variables as offsets from the Frame Pointer
    STR W0, [FP, VAR1] // store 1st parameter into memory on stack
    STR W1, [FP, VAR2] // store 2nd parameter into memory on stack

    // We can do a bunch of other work and even have SP change
    // here, however, FP must be unchanged.
    LDR W4, [FP, VAR1] // load VAR1 from memory into w4
    LDR W5, [FP, VAR2] // load VAR2 from memory into w5

    ADD W6, W4, W5      // add VAR1 and VAR2 into w6

    // Store result into stack frame 'SUM' variable
    STR W6, [FP, SUM]

    // <.. do more work ..>

    // Epilogue
    LDR X0, [FP, SUM]
    ADD SP, SP, #16 // pop stack / shrink 

    // restore LR and FP from stack
    LDP LR, FP, [SP], #16 // note use of post-indexing

    RET
