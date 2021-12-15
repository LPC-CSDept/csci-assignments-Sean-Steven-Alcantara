#
# q6.asm
# Sean Steven Alcantara
# 12/11/2021
# Question 2 for Final Exam(Programming QUestions) in CS21
# Read a char through MM I/O and print until q is typed
# make the interrupt handler(kernel text program)
#

    .text
    .globl main

main:

        mfc0    $a0, $12            # read from status register
        ori     $a0, 0xff11         # enable all interrupts. This will set the bit for user mode and interrupt enable fields in the status register
        mtc0    $a0, $12            # write to status register

        lui     $t0, 0xffff         # base address of MMIO
        ori     $a0, $zero, 0x2     # to enable interrupt in the receiver control
        sw      $a0, 0($t0)         # write to the receiver control
        
        li      $t0, 10000000       # number of executions for the loop
loop:   addiu   $t0, $t0, -1        # to avoid an "infinite loop"
        bgtz    $t0, loop           # end loop if $t0 <= 0
        nop

        li      $v0, 10             # exit program
        syscall

# Kernel data

    .kdata

s1: .word   0       # these will be used to store whatever is in the general registers
s2: .word   0       # ($t and $s) whenever in the interrupt handler
s3: .word   0       # the general registers will eventually be restored near the kernel text end
s4: .word   0
s5: .word   0
s6: .word   0

# Kernel text

    .ktext  0x80000180

        sw      $t0, s1             # store the values in the general registers... 
        sw      $t1, s2             # used, to restore later
        sw      $s0, s3             
        sw      $a0, s4
        sw      $v0, s5
        mfc0    $k0, $13            # get the bit pattern in cause register
        srl     $a0, $k0, 2         # to extract the exception code fields
        andi    $a0, $a0, 0x1f      # get the exception code. This is the lower 5 bits
        bne     $a0, $zero, kEnd    # interrupt only if 0, 0 is hardware exception
        
        lui     $t0, 0xffff         # base address of MMIO
        lw      $s0, 4($t0)         # get word from receiver data
        li      $t1, 113            # ASCII for "q"
        bne     $t1, $s0, write     # $s0 has the user input. If this is not q then end interrupt.
        nop
        li      $v0, 10             # exit program, if q was the input
        syscall
write:  
        sw      $s0, 12($t0)        # print the user input on console
kEnd:
        lw      $t0, s1             # restore the original values of the...
        lw      $t1, s2             # general registers used
        lw      $s0, s3             
        lw      $a0, s4
        lw      $v0, s5
        mtc0    $zero, $13          # clear cause register
        mfc0    $k0, $12            # Get bit pattern in status register
        andi    $a0, $k0, 0xfffd    # clear exception level field
        mtc0    $a0, $12            # write back to status register
        eret                        # return from interrupt
        nop

## end of file