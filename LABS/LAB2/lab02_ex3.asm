;=================================================
; Name: Munoz, Francisco
; Username: fmuno003	(fmuno003@ucr.edu)
; 
; Lab: Lab 02
; Lab section: 021
; TA: Bryan Marsh
; 
;=================================================
.orig x3000					;Program starts here
	;-----------------
	;Instructions
	;-----------------
	LD R5, DEC_65			;R5 <-- ADDRESS_4000
	LD R6, HEX_41			;R6 <-- ADDRESS_4001
	
	LDR R3, R5, #0
	LDR R4, R6, #0
	
	ADD R3, R3, #1			;R3 <-- R3 + #1
	ADD R4, R4, #1			;R4 <-- R4 + #1
	
	STR R3, R5, #0			
	STR R4, R6, #0			
	
	HALT					;END OF PROGRAM
	;------
	;Data
	;------
	DEC_65	.FILL	x4000			;Put x4000 into memory here
	HEX_41	.FILL	x4001			;Put x4001 into memory here
				;------------- 
				;Remote Data
				;-------------
				.orig x4000
	ADDRESS_4000	.FILL	#65		;PUT 65 INTO MEMORY HERE
	ADDRESS_4001	.FILL	x41		;PUT 41 INTO MEMORY HERE
	
.end
