
/*
    X0 = Address of input string
    X1 = address of output string
    X2 = original output string length

    W3 = current character being processed

    label 1 = loop
    lavel 2 = cont
*/

.MACRO toupper instr, outstr
    LDR x0, =\instr
    LDR x1, =\outstr
    mov x2, x1 // store addres ot oustr into x2

// loop
1: 
    LDRB w3, [x0], #1 // load into w3 and increment address in x0
    CMP W3, #'z'   // is letter > z
    B.GT 2f         // true -> go to the next label "2" in forward direction

    // else
    CMP W3, #'a'   // is letter < a
    B.LT 2f       // true -> go to 2f

    // else -> letter is lowercase, so convert to upper
    SUB W3, W3, #('a' - 'A')

// cont
2:
    STRB w3, [x1], #1 // store w3 into x1 and increment address in x1
    cmp w3, #0 // stop on hitting a null char
    B.NE 1b     // true > go to next label "1" in the backwards direction

    // else
    // length = x1 - x2 = (oustr_end_ptr + 1) - outstr_start-ptr
    SUB x0, x1, x2 // calculate length of new string
.ENDM
