# Description
This repo is just part of my foray into understanding how things work closer to the
metal. ARM was chosen as the starting instruction set to learn due to the relative
straightforwardness of understanding RISC vs CISC. 

## Directory Layout

- `ch01`: Getting Started - Not much covered here

- `ch02`: Loading and Adding instructions 
-- MOV, MOVK, MOVN, LDR and STR 
-- There are also some helpful notes in `1-moving/debug_output.norg` for how to use
`objdump`

- `ch04`: Program Flow Control
-- looping, condition branching, branch with link (function call) 

- `ch05`: Loading from and Storing to memory (LDR, STR)
-- Also contains new memory directives for use in the `.data` section.
-- covers word alignment for ARM assembly instructions etc.
-- PC relative addressing
-- *Write Back* and *Post-Indexed Addressing*: These are extremely important for chapter
6, where we start dealing with the stack pointer and usage of STP and LDP.

- `ch06`: Functions and Stack - Most important chapter. Covers function calling and
  managing the stack. This is important in situations where you want to write your own
  async runtime and the model is based on that of a stackful coroutine, i.e. fibers /
  green threads.

- `ch07`:Linux Syscalls
- `ch08`: (Skipped) - Programming GPIO Pins
- `ch09`: Interacting with C and Python 
-- TODO: I only covered this briefly, so worth going
  back to again.
- `ch011`: Multiply, Divide and Accumulate - Also worth revisiting.
- `ch012`: Floating-Point Operations and the FPU
- `ch013`: TODO
- `templates`: I got tired of writing very similar makefiles and just wrote a general
purpose template here. Some chapters did require a specific makefile, and so it's
not used everywhere. 

## TODO

1. Finish NEON processors chapter 13 (equivalent of AVX for SIMD on X86_64 ISA).
2. Revision areas: Chapter 5 & 6
3. Atomic instructions. The Rust on atomic and locks has a nice summary page listing out
   the various ISA specific atomic operations. Can use those to understand how things
   work further.
4. More general practice using the various debuggers and dissassemblers is required.
   Though I still do have extensive notes on these in my neorg notes.

## Links
- [GitHub Source - Programming with 64 bit ARM assembly language][1]

[1]: https://github.com/Apress/programming-with-64-bit-ARM-assembly-language

