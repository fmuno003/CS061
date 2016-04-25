;=================================================
; Name: Munoz, Francisco
; Username: fmuno003	(fmuno003@ucr.edu)
; 
; Lab: Lab 02
; Lab section: 021
; TA: Bryan Marsh
; 
;=================================================
.orig x3000							;Program starts here
	;-----------------
	;Instructions
	;-----------------
	LDI R3, DEC_65			;R3 <-- #65
	LDI R4, HEX_41			;R4 <-- x41
	
	ADD R3, R3, #1			;R3 <-- R3 + #1
	ADD R4, R4, #1			;R4 <-- R4 + #1
	
	STI R3, DEC_65
	STI R4, HEX_41
	
	HALT					;END OF PROGRAM
	;------
	;Data
	;------
	DEC_65	.FILL	x4000					;Put 65 into memory here
	HEX_41	.FILL	x4001					;Put 41 into memory here
				;------------- 
				;Remote Data
				;-------------
				.orig x4000
	NEW_DEC_65	.FILL	#65
	NEW_HEX_41	.FILL	x41
	
.end
