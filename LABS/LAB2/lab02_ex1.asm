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
	LD R3, DEC_65					;R3 <-- #65
	LD R4, HEX_41					;R4 <-- x41
	
	HALT
	;------
	;Data
	;------
	DEC_65		.FILL	#65			;Put 65 into memory here
	HEX_41		.FILL	x41			;Put 41 into memory here
	
.end
	
