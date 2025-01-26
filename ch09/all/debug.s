// Various macros to help with debugging
// 1. printReg reg - print the value of a register
// 2. printStr str - print a string

// These macros preseve all registers.
// Beware they will change the condition flags.

// ============ MACRO START ===================
// 1. print register value
.macro printReg reg

// Store register X0-X18 and LR
// These hold function parameters,
// scratch data and return address to caller
stp X0, X1, [SP, #-16]!
stp X2, X3, [SP, #-16]!
stp X4, X5, [SP, #-16]!
stp X6, X7, [SP, #-16]!
stp X8, X9, [SP, #-16]!
stp X10, X11, [SP, #-16]!
stp X12, X13, [SP, #-16]!
stp X14, X15, [SP, #-16]!
stp X16, X17, [SP, #-16]!
stp X18, LR, [SP, #-16]!

// -- All callee owned registers saved by this point

// - Setup function parameters
// Note, we move into X2 and X3 first. If \reg is X1
// and we did X0, =ptrStr first, the X0 would be overwritten
// and not available for us to move into X1, X2 and X3.
mov X2, X\reg    // for the %d
mov X3, X\reg    // for the %x
mov X1, #\reg
add X1, X1, #'0' // for %c
ldr X0, =ptfStr  // printf format string

bl printf // call printf

// Restore registers
ldp X18, LR, [SP], #16
ldp X16, X17, [SP], #16
ldp X14, X15, [SP], #16
ldp X12, X13, [SP], #16
ldp X10, X11, [SP], #16
ldp X8, X9, [SP], #16
ldp X6, X7, [SP], #16
ldp X4, X5, [SP], #16
ldp X2, X3, [SP], #16
ldp X0, X1, [SP], #16
.endm

// ================= MACRO END ===================

// ============ MACRO START ===================
// 2. Print a string
.macro printStr str
stp    X0, X1, [SP, #-16]!
stp    X2, X3, [SP, #-16]!
stp    X4, X5, [SP, #-16]!
stp    X6, X7, [SP, #-16]!
stp    X8, X9, [SP, #-16]!
stp    X10, X11, [SP, #-16]!
stp    X12, X13, [SP, #-16]!
stp    X14, X15, [SP, #-16]!
stp    X16, X17, [SP, #-16]!
stp    X18, LR, [SP, #-16]!

// -- All registers stored

ldr X0, =1f // load address of string to print

// Call printf to print a string (no format)
// this is essentially just like following:
// printf("hello, world!\n") <- only 1 argument
bl  printf              // call printf
ldp X18, LR, [SP], #16
ldp X16, X17, [SP], #16
ldp X14, X15, [SP], #16
ldp X12, X13, [SP], #16
ldp X10, X11, [SP], #16
ldp X8, X9, [SP], #16
ldp X6, X7, [SP], #16
ldp X4, X5, [SP], #16
ldp X2, X3, [SP], #16
ldp X0, X1, [SP], #16
b   2f                  // branch around str

1:
	// NOTE \str is the macro parameter
	// also use \n to ensure it is null terminated
	.asciz "\str\n"

	// string above is of an unknown size, so ensure we
	// align to a word boundary afterwards for the next
	// "instruction" (which must be word aligned)
	.align 4

2:
	.endm

	// ================= MACRO END ===================

	// Data Section
	.data

	// embed string in code via use of an `.asciz` directive
	// note that this data was added to the "code" section
ptfStr:
	.asciz "X%c = %32ld, 0x%016lx\n" // format string
	.align 4                         // instructions must be word aligned

	.text // resume code section
