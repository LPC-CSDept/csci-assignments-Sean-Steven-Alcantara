#
# Lab2.asm
# Sean Steven Alcantara
# 12/7/2021
# Lab2 for Memory Mapped IO in CS21
# Read two digits using memory-mapped IO and print decimal value through syscall
#

    .text
    .globl main

main:   lui     $t0, 0xffff     # base address for memory-mapped IO
        li      $t2, 2          # how many digits is being taken from input
rd_wait:
        lw      $t1, 0($t0)     # load word from receiver control address
        nop
        andi    $t1, $t1, 1     # get 1 or 0 to check if input is ready
        beqz    $t1, rd_wait    # if input not yet taken then loop back
        nop
        lw      $s0, 4($t0)     # store the digit in $s0
        addiu   $t2, $t2, -1    # 1 less digit to take
        addiu   $s0, $s0, -48   # get the decimal value of 2nd digit
        beqz    $t2, end        # if all digits are taken then end loop
        nop
        li      $t4, 10 
        mult    $s0, $t4        # get tens value of printed output
        mflo    $s1
        j       rd_wait         # loop back to get next digit
end:
        add     $a0, $s1, $s0   # get a 2 digit decimal by combining the inputs
        li      $v0, 1          # print integer code
        syscall

        li      $v0, 10         # exit program code
        syscall

## end of file