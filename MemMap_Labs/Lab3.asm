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

            lui     $t0, 0xffff     # base address for mem-map I/O
            li      $t2, 2          # number of digits to be printed
            li      $t3, 1          # for comparison to check if 2nd digit is to be printed
wr_wait:    lw      $t1, 8($t0)     # get value from transmitter control address
            nop
            andi    $t1, $t1, 1     # get a 1 for ready 0 for if not
            beqz    $t1, wr_wait    # loop back if not ready
            nop
            beq     $t2, $t3, dig2  # if 1st digit is printed, then print 2nd digit
            nop
            mflo    $v0             # $v0 = 42/10 = 4
            addiu   $v1, $v0, 48    # get ASCII code for the tens digit
            sw      $v1, 12($t0)    # print the tens digit to output
            addiu   $t2, $t2, 1     # 1 less digit to print
            j       wr_wait         # loop back to print next digit
            nop
dig2:       mfhi    $v0             # $v0 = 42%10 = 2
            addiu   $v1, $v0, 48    # get ASCII code for units digit
            sw      $v1, 12($t0)    # print units digit to output
            
end:        li      $v0, 10         # exit program code
            syscall
