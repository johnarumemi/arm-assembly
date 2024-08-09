
// Program start
.global _start

_start: movn w0, #2     // w0 = 2 x -1
        add w0, w0, #1  // w0 = w0 + 1

// Program exit
mov x8, #93 // syscall number for exit
svc 0      

