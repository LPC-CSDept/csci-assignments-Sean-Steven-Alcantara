#
# Lab6_NewtonsMethod.asm
# Sean Steven Alcantara
# 11/21/2021
# Lab for CSCI 21
# Write a program that does the same thing as newton's method
# Newton's method is a way to compute the square root of a number
# formula is x' = ( x+ (n/x) )/2 with "n" as a real number whose square root is being solved
#

	.data
n:	.float	144.0
nval:	.asciiz	"n = "
nroot:	.asciiz "\nsquare root of n = "

	.text
	.globl main

main:	l.s	$f2, n		# get n
	li.s	$f3, 1.0	# constant 1.0
	li.s	$f4, 2.0	# constant 2.0
	li.s	$f5, 1.0	# x = first approx.
	li.s	$f10, 1.0e-5	# accuracy limit

loop:	mov.s	$f6, $f2	# copy n to another register
	div.s	$f6, $f6, $f5	# n/x
	add.s	$f6, $f5, $f6	# x' = x + n/x
	nop
	div.s	$f6, $f6, $f4	# x' = (x + n/x)/2
	sub.s	$f7, $f6, $f5	# x' - x to check if next approx is accurate enough
	abs.s	$f7, $f7	# absolute value of x' - x
	c.lt.s	$f7, $f10	# if x' - x <= .00001 then it is accurate enough
	bc1t	end		# end the loop if approx is accurate enough
	nop
	mov.s	$f5, $f6	# x = x'
	j	loop		# go back to loop
	nop

end:	la	$a0, nval	# address of "n = "
	li	$v0, 4		# print string code
	syscall
	mov.s	$f12, $f2	# copy n as print float arg
	li	$v0, 2		# print float code
	syscall
	la	$a0, nroot	# print "square root of n = "
	li	$v0, 4		# print string code
	syscall
	mov.s	$f12, $f6	# copy x' as print float arg
	li	$v0, 2		# print float code
	syscall
	li	$v0, 10		# end program code
	syscall
	
## end of file
# what if I right this here

