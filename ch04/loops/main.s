
// export program entry point for linker to use
.global _start

_start: mov w2, #1  // W2 holds loop variable "I"
        mov w3, #10 // W3 holds the termination value / criteria
        
// Start of our loop
loop:
    // Increment loop variable
    ADD w2, w2, #1

    // Do a substraction via twos complement
    // movn w4, w2
    // add w4, w4, #1 
    // add w4, w4, w2
    // subs wzr, w3, w2

    // use CMP to set relevant flags
    // CMP is a SUBS without storing the result (uses wzr)
    CMP w2, w3


    // Branch if w2 < w3
    B.LE loop


// start new loop
mov w2, #10
// Start of our loop
loop_again:

    // Do a substraction via twos complement
    movn w4, #1 // store !1 in w4
    add w4, w4, #1  // this is now twos complement: -1

    // Below should decrement w2 by -1
    adds w2, w2, w4

    // or use below
    //SUBS w2, w2, #1
    B.NE loop_again


mov w4, #0
// X < 5
while_loop: CMP w4, #5  // does subs wzr, w4, #5. Answer = w4 - 5
    // GE = Greater than or Equal Unsigned `>=` 
    // IF X >= 5, then goto whle_loop_done
    B.GE while_loop_done

    // increment the loop variable
    ADD w4, w4, #1


    // unconditionally branch back to top
    B while_loop


// arrive here when while loop is completed
while_loop_done:
mov w0, w2 // Return the result
mov x8, #93 // Exit syscall
svc 0
