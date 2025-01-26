
// "include" takes contents of "uppermacro.s" and 
// inserts it into the code at this location.
.include "uppermacro.s"

.global _start



_start: 

    // macro invocation
    toupper tststr, buffer

    // Setup paramters to print and call Linux
    MOV X2, X0 // save length of string

    MOV X0, #1 // 1 = Stdout
    LDR x1, =buffer // address of string
    MOV x8, #64 // syscall 64 is write
    SVC 0

    // Setup parameters for seoncd string
    toupper tststr2, buffer

    // Setup paramters to print and call Linux
    MOV X2, X0 // save length of string

    MOV X0, #1 // 1 = Stdout
    LDR x1, =buffer // address of string
    MOV x8, #64 // syscall 64 is write
    SVC 0


    // Setup paramters to exit program
end:
    MOV X0, #0 
    MOV x8, #93 
    SVC 0

.data
    tststr: .asciz "This is our Test String that we will convert.\n"
    tststr2: .asciz "A second string to upper case!!\n"
    buffer: .fill 255, 1, 0

