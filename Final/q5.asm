#
# q5.asm
# Sean Steven Alcantara
# 12/7/2021
# Question 1 for Final Exam(Programming QUestions) in CS21
# Read 3 digits through MM I/O then print the real decimal value of the 3 digit input
# using syscall. If you get 1, 2, and 3 then print 123 using one syscall
#

    .data
message:    .asciiz "The number you typed is:"

    .text
    .globl main

main:   lui     $t0, 0xffff         # base address of MM I/O
        li      $t5, 3              # how many digits are being from input
rd_wait:
        lw      $t1, 0($t0)         # get word stored from address of receiver control
        nop
        andi    $t1, $t1, 1         # clear all bits except LSB to check if 0 or 1
        beqz    $t1, rd_wait        # loop back if 0, input not ready
        nop

        lw      $t4, 4($t0)         # input is ready so get word from receiver data
        nop
        addiu   $t4, $t4, -48       # to get decimal value of digit entered. 48 ASCII is 0 decimal
        addiu   $t5, $t5, -1        # one less digit to take
        beqz    $t5, end            # if $t5 == 0 then all 3 digits already taken. End loop
        nop

end:



## end of file