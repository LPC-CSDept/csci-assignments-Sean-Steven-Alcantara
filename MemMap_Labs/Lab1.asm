#
# Lab1.asm
# Sean Steven Alcantara
# 12/7/2021
# Lab1 for Memory Mapped IO in CS21
# Take one character from user then display it using Memory Mapping
#

    .text
    .globl main

main:
        lui $t0, 0xffff     # memory mapped IO base address
rd_wait:
        lw  $t1, 0($t0)     # get 4 bytes from receiver control
        nop                 # delay slot
        andi    $t1, $t1, 1 # get 1 or 0 from LSB
        beq $t1, $zero, rd_wait # if 0 that means no input yet so loop back
        nop
        lw  $v0, 4($t0)     # get stored input from receiver data

wr_wait:
        lw  $t1, 8($t0)     # get stored 4 bytes of data from transmitter control address
        nop                 # delay slot
        andi    $t1, $t1, 1 # get 1 or 0 from LSB
        beq $t1, $zero, wr_wait #