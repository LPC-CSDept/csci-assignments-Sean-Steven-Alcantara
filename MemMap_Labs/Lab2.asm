#
# Lab2.asm
# Sean Steven Alcantara
# 12/7/2021
# Lab1 for Memory Mapped IO in CS21
# Read two digits using memory-mapped IO and print decimal value through syscall
#

    .text
    .globl main

main:   lui $t0, 0xffff         # base address for memory-mapped IO
        li  $t1, 0              # how many digits is being taken from input
rd_wait:
        lw  $t1, 0($t0)         # load word from receiver control address
        nop
        andi    $t1, $t1, 1     # get 1 or 0 to check if input is ready
        beqz     $t1, rd_wait   # if input not yet taken then loop back
        nop
        lw      $s0, 4($t0)     # store the first digit in $s0
        subiu   $t1, $t1, 1     # 1 less digit to taken
        beqz     $t1, rd_wait   # if not all digits are taken yet then loop back
        nop
