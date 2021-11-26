#
# Quiz_11-30-2021_question2.asm
# Sean Steven Alcantara
# 11/25/2021
# Quiz Due on 11/30/2021 Question #2 for CSCI 21
# calculate ax2+bx+c
# x, a, b, and c must be user input
#

    .data

xprom:  .asciiz "Enter value for x: "
aprom:  .asciiz "Enter value for a: "
bprom:  .asciiz "Enter value for b: "
cprom:  .asciiz "Enter value for c: "

    .text
    .globl main

main:   la  $a0, xprom  # address for x prompt message
        li  $v0, 4      # syscall print code
        syscall
        li  $v0, 6      # syscall read float code
        syscall
        mov.s   $f1, $f0    # copy x in $f0 to $f1
        la  $a0, aprom  # address for a prompt message
        li  $v0, 4      # syscall print code
        syscall
        li  $v0, 6      # syscall read float code
        syscall
        mov.s   $f2, $f0    # copy a in $f0 to $f2
        la  $a0, bprom  # address for b prompt message
        li  $v0, 4      # syscall print code
        syscall
        li  $v0, 6      # syscall read float code
        syscall
        mov.s   $f3, $f0    # copy b in $f0 to $f3
        la  $a0, cprom  # address for c prompt message
        li  $v0, 4      # syscall print code
        syscall
        li  $v0, 6      # syscall read float code
        syscall
        mov.s   $f4, $f0    # copy c in $f0 to $f4