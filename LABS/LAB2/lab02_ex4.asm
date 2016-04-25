;=================================================
; Name: Munoz, Francisco
; Username: fmuno003	(fmuno003@ucr.edu)
; 
; Lab: Lab 02
; Lab section: 021
; TA: Bryan Marsh
; 
;=================================================
.orig x3000
	;-------------
	;Instructions
	;-------------
	LD R0, HEX_61				;R0 <-- x61
	LD R1, HEX_1A				;R1 <-- x1A
	
	DO_WHILE_LOOP
		TRAP x21				;print (R0) 
		ADD R0, R0, #1			;R0 <-- R0 + #1
		ADD R1, R1, #-1			;R1 <-- R1 - #1
		BRp DO_WHILE_LOOP		;If (R1 <= 1A): goto DO_WHILE_LOOP 
	END_DO_WHILE_LOOP
	
	HALT						;halt program
	;------
	;Data
	;------
	HEX_61	.FILL	x61			;Put x61 into memory here
	HEX_1A	.FILL	x1A			;Put x1A into memory here

.end
