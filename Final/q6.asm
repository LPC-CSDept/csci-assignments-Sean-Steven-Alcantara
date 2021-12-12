#
# q6.asm
# Sean Steven Alcantara
# 12/11/2021
# Question 1 for Final Exam(Programming QUestions) in CS21
# Read a char through MM I/O and print until q is typed
# make the interrupt handler(kernel text program)
#

    .text
    .globl main

main:

        mfc0    $a0, $12        # read from status register
        ori     $a0, 0xff11     # enable all interrupts. This will set the bit for user mode and interrupt enable fields in the status register
        mtco    $a0, $12        # write to status register
## end of file