/* 
    Hello World in ARM Assembly
*/

/*
    Provide program starting address

    Defined as a global symbol so that linker
    has access to it.

    Assembler marks the statement containing _start as the program entry,
    then the linker can find it because it has been defined as a global variable.

    Our program can consist of multiple `.s` files, but only one file can 
    contain `_start`.
*/
.global _start


/*
    X0-X1 - parameters to Linux function services
    X8 - Linux function service number
*/

// Print Hello World to the console
_start: mov X0, #1  // 1 = to stdout, assembler marks this as program entry point
ldr x1, =helloworld // Load the address of the string into x1 register
mov x2, #13         // length of the string
mov x8, #64         // Linux write system call
svc 0               // Software interrupt to call the linux kernel hanlder

// Exit the program
mov x0, #0          // 0 = exit status
mov x8, #93         // Linux exit system call
svc 0               // call linux to terminate this program

.data
helloworld: .ascii "Hello World!\n" // 13 characters long

