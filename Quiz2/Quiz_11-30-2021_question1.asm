#
# Quiz_11-30-2021_question1.asm
# Sean Steven Alcantara
# 11/25/2021
# Quiz Due on 11/30/2021 Question #1 for CSCI 21
# Converts single-precision temp from Fahrenheit to Celsius
# Ask user to enter value to be entered, must be an int value then convert it
#

	.data
prompt:	.asciiz	"Enter an integer value of a temperature in Fahrenheit: "
nl:	.asciiz "\n"
Fah:	.asciiz "\nFahrenheit: "
Cel:	.asciiz "\nCelsius: "

	.text
	.globl main

main:	li.s	$f1, 5.0	# constant 5.0
	li.s	$f2, 9.0	# constant 9.0
	li.s	$f3, 32.0	# constant 32.0
	la	$a0, prompt	# address of prompt message
	li	$v0, 4		# print call code
	syscall
	li	$v0, 5		# read int code
	syscall
	move	$t0, $v0	# copy user input to general register
	
	mtc1	$t0, $f0	# copy from $t0 to $f0
	cvt.s.w	$f0, $f0	# convert int in $f0 to single-precision in $f0
	mov.s	$f4, $f0	# $f4 = Fahrenheit
	sub.s	$f4, $f4, $f3	# $f4 = Fahrenheit - 32
	mul.s	$f4, $f4, $f1	# $f4 = (Fahrenheit - 32) * 5
	div.s	$f4, $f4, $f2	# $f4 = ((Fahrenheit - 32) * 5)/9
	
	la	$a0, Fah	# address of Fahrenheit string
	li	$v0, 4		# print string code
	syscall
	mov.s	$f12, $f0	# copy Fahrenheit value to print
	li	$v0, 2		# print float code
	syscall
	la	$a0, Cel	# address of Celsius string
	li	$v0, 4		# print string code
	syscall
	mov.s	$f12, $f4	# copy Celsius value to print
	li	$v0, 2		# print float code
	syscall
	li	$v0, 10		# end program
	syscall
	
## end of file