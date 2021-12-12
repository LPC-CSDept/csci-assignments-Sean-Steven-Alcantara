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

        mfc0    $a0, $12            # read from status register
        ori     $a0, 0xff11         # enable all interrupts. This will set the bit for user mode and interrupt enable fields in the status register
        mtco    $a0, $12            # write to status register

        lui     $t0, 0xffff         # base address of MMIO
        ori     $a0, $zero, 0x2     # to enable interrupt in the receiver control
        sw      $a0, 0($t0)         # write to the receiver control
rd_wait:
        lw      $t1, 0($t0)         # get word from the receiver control
        andi    $t1, $t1, 1         # to check if the LSB in receiver control is 1 or 0
        beqz    $t1, rd_wait        # loop back if 0. input is not ready
        nop
        sw      $s0, 4($t0)         # input is ready. Put the word in receiver data into $s0

rd_write:
        lw      $t1, 8($t0)         # get word from the transmitter control
        andi    $t1, $t1, 1         # to check if the LSB in transmitter control is 1 or 0
        beqz    $t1, rd_wait        # loop back if 0. output is not ready
        nop
        sw      $s0, 12($t0)        # print the user input onto console

        j       rd_wait             # wait for the next user input
        nop

        li      $v0, 10             # exit program
        syscall


#Kernel text

    .ktext  800000180

        mfc0    $k0, $13            # get the bit pattern in cause register
        srl     $a0, $k0, 2         # to extract the exception code fields
        andi    $a0, $a0, 0x1f      # get the exception code. This is the lower 5 bits
        bne     $a0, $zero, kEnd    # interrupt only if 0, 0 is hardware exception

kEnd:
## end of file