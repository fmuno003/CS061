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
FOR_LOOP
	
	ADD R3, R3, #1
	ADD R1, R1, #1
	STR R3, R1, #0
	
	ADD R4, R4, #-1
	BRp FOR_LOOP
	END_FOR_LOOP

	LD R2, DEC_6	
	HALT
	
	;======
	;Data
	;======
	DEC_0			.FILL	#0
	MEMORY_ARRAY	.FILL	x4000
	DEC_9			.FILL	#9
	DEC_6			.FILL	#6
	;============
	;Remote Data
	;============
	.orig x4000
	.BLKW #10
.end
