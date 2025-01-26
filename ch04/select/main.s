/* 
    SELECT number
        CASE 1:
            << statements if number is 1 >>
        CASE 2:
            << statements if number is 2 >>
        CASE ELSE:
            << statements if not any other case >>
    END SELECT
*/

// export program entry point for linker to use
.global _start

_start: 
        mov w5, #10 //  W3 our comparison value
    
select: 
    CMP w5, #1
    B.EQ case1

    CMP w5, #2
    B.EQ case2

    // << .. else statements .. >>
    mov w3, #3

    B endselect

case1:
    mov w3, #1
    B endselect

case2:
    mov w3, #2
    B endselect

endselect:
    mov w0, w3 // Return the result
    mov x8, #93 // Exit syscall
    svc 0
