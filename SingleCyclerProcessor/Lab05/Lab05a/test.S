
.section .text
.globl test

test:
	movz	X1, #0x1234, LSL #48
	movz	X2, #0x5678, LSL #32
	movz	X3, #0x9abc, LSL #16
	movz	X4, #0xdef0, LSL #0
	AND	X5, XZR, XZR
	ADD	X9, X5, X1
	ADD	X9, X9, X2
	ADD	X9, X9, X3
	ADD	X9, X9, X4

2:	STUR X9, [X5,0x28]

3:	LDUR X10, [X5,0x28]
	
	br	X30

