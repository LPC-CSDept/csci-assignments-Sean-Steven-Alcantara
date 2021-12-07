#
# Lab3.asm
# Sean Steven Alcantara
# 12/7/2021
# Lab3 for Memory Mapped IO in CS21
# Print the decimal value using Memory-mapped I/O
#

    .text
    .globl main

main:
        li      $t2, 42         # number to be printed
        li      $t3, 10         # will be used to get the tens and unit digit from num to print
        div     $t2, $t3        # 42/10 or 42%10
        mflo    $v1             # $v1 = 42/10
        mfhi    $v0             # $v0 = 42%10
        