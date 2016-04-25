;=================================================
; Name: Munoz, Francisco
; Username: fmuno003	(fmuno003@ucr.edu)
; 
; Lab: Lab04
; Lab section: 021
; TA: Bryan Marsh
; 
;=================================================
.orig x3000
	;==============
	;Instructions
	;==============
	LD R1, MEMORY_ARRAY
	LD R3, DEC_0
	STR R3, R1, #0

	
	LD R4, DEC_9
	LD R6, ASCII_DEC
	ADD R0, R3, R6
	TRAP x21
FOR_LOOP
	
	ADD R3, R3, #1
	ADD R1, R1, #1
	STR R3, R1, #0
	
	ADD R5, R3,	R6
	ADD R0, R5, #0
	TRAP x21

	ADD R4, R4, #-1
	BRp FOR_LOOP
	END_FOR_LOOP
	
	LD R2, DEC_6
	
	LEA R0, NEW_LINE
	TRAP x22
	HALT
	
	;======
	;Data
	;======
	DEC_0			.FILL		#0
	MEMORY_ARRAY	.FILL		x4000
	DEC_9			.FILL		#9
	ASCII_DEC		.FILL		x30
	DEC_6			.FILL		#6
	NEW_LINE		.STRINGZ	"\n"
	;============
	;Remote Data
	;============
	.orig x4000
		.BLKW #10
.end
