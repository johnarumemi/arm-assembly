
// Program starting address for linker
.global _start

# load X2 with 0x1234FEDC4F5D6E3A using mov and movk
#   63-48  47-32  31-16  15-0
# | 1234 | FEDC | 4F5D | 6E3A | using mov and movk
_start: mov x2, #0x6E3A 
        movk x2, #0x4F5D, LSL #16
        movk x2, #0xFEDC, LSL #32
        movk x2, #0x1234, LSL #48

// just move w1 into w2
mov w2, w1

mov x1, x2, LSL #1 
mov x1, x2, LSR #1
mov x1, x2, ASR #1
mov x1, x2, ROR #1


LSL x1, x2, #1
LSR x1, x2, #1
ASR x1, x2, #1
ROR x1, x2, #1

// Example that works with 8 bit immediate and shift
mov x1, #0xAB000000 // too big for #imm16

// Example of MOVN
movn w1, #45 


// Program Exit
mov x0, #0 // exit code
mov x8, #93 // exit syscall number
svc 0

