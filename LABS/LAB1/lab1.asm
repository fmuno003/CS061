;=================================================
;Munoz, Francisco
;Login: fmuno003 (fmuno003@ucr.edu) 
;Section: 021
;TA: Bryan Marsh
;Lab 01
;=================================================
.orig x3000
	;-------------------
	;Instructions
	;-------------------
	LD R1, DEC_0				;R1 <-- #0
	LD R2, DEC_12				;R2 <-- #12
	LD R3, DEC_6				;R3, <-- #6
	
	DO_WHILE_LOOP
		ADD R1, R1, R2			;R1 <-- R1 + R2
		ADD R3, R3, #-1			;R3 <-- R3 - #1
		BRp DO_WHILE_LOOP		;if (R3 > 0): goto DO_WHILE_LOOP
	END_DO_WHILE_LOOP
	
	HALT						;halt program (like exit() in C++)
	;----------------
	;Local Data
	;----------------
	DEC_0		.FILL	#0		;PUT #0 INTO MEMORY HERE
	DEC_12		.FILL	#12		;PUT #12 INTO MEMORY HERE
	DEC_6		.FILL	#6		;PUT #6 INTO MEMORY HERE
	
.end
