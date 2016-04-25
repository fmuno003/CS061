;=================================================
; Name: Munoz, Francisco
; Username: fmuno003	(fmuno003@ucr.edu)
; 
; Lab: LAB 03
; Lab section: 021
; TA: Bryan Marsh
; 
;=================================================
.ORIG x3000						;Program starts here
	;==============
	;Instructions
	;==============
	LD R6, DATA_PTR
	LD R1, DATA_1
	STR R1, R6, #0
	
	ADD R6, R6, #1
	LD R1, DATA_2
	STR R1, R6, #0
	
	HALT

	;=======
	;Data
	;=======
	DATA_PTR	.FILL	x4000
	DATA_1		.FILL	#65
	DATA_2		.FILL	x41
	
	;=============
	;Remote Data
	;=============
	.orig x4000
	.BLKW	#10
	
.END							;Program ends here
	
