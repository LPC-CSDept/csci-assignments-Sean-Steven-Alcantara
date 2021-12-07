#
# Lab3.asm
# Sean Steven Alcantara
# 12/7/2021
# Lab3 for Memory Mapped IO in CS21
# Print the decimal value using Memory-mapped I/O
#

    .text
    .globl main

main:   lui $t0, 0xffff     # base address of Mem-mapIO
        li  $t2, 42         #