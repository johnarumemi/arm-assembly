/*

    the `.S` file extension allows the use of  
    C include directives.

    The fd parameter needs to be a register
    X0 = return code
    X1 = scratch register
    X2
    x3
    X8 = syscall number
*/
#include <asm/unistd.h>

.equ O_RDONLY, 0    // read only
.equ O_WRONLY, 1    // write only
.equ O_CREAT, 0100  // 64 - create file if it does not exist
.equ O_EXCL, 0200   // 128 - exclusive use
.equ S_RDWR, 0666   // 438 - read and write access
.equ AT_FDCWD, -100 // 0xFFFFFF9C, -100

# AT_FDCWD: folder descriptor that the file we are opening is relative to.
# if equal to ATFDCWD, then open relative to current working directory.

// 1. Macro to open a file

.macro openFile fileName, flags
mov    X0, #AT_FDCWD            // #-100, uses the two complement of -100
ldr    X1, =\fileName           // File to open as a null terminated string
mov    X2, #\flags              // flags to specify mode
mov    X3, #S_RDWR              // Read and write access
mov    X8, #__NR_openat
svc    0
.endm

.macro readFile fd, buffer, length
mov    X0, \fd                     // filer descriptor is an integer
ldr    X1, =\buffer
mov    X2, #\length
mov    X8, #__NR_read
svc    0
.endm

.macro writeFile fd, buffer, length
mov    X0, \fd                      // filer descriptor is an integer
ldr    X1, =\buffer
mov    X2, #\length
mov    X8, #__NR_write
svc    0
.endm

.macro flushClose fd

// fsync syscall
mov x0, \fd
mov x8, #__NR_fsync
svc 0

// close syscall
mov x0, \fd
mov x8, #__NR_close
svc 0
.endm

