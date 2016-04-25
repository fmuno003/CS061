;=================================================
; Name: Munoz, Francisco
; Username: fmuno003	(fmuno003@ucr.edu)
; 
; Lab: LAB 03
; Lab section: 021
; TA: Bryan Marsh
; 
;=================================================
.ORIG x3000
	;==============
	;Instructions
	;==============
	LD R5, DEC_10
	LD R6, ARRAY_CHARACTERS
	
	
	LEA R0, INSTRUCTIONS_1
	TRAP x22
	
	DO_WHILE_LOOP
		TRAP x20
		ADD R1, R0, #0
		STR R1, R6, #0
		ADD R6, R6, #1
		
		ADD R5, R5, #-1
		BRp DO_WHILE_LOOP
	END_DO_WHILE_LOOP
	
	LD R5, DEC_10 
	Add R6, R6, #-10
	
	DO_WHILE_LOOP2
		LDR R0, R6, #0
		TRAP x21
		
		LEA R0, INSTRUCTIONS_2
		TRAP x22
		
		ADD R6, R6, #1
		ADD R5, R5, #-1
		BRp DO_WHILE_LOOP2
	END_DO_WHILE_LOOP2
	
	
	HALT
	;========
	;Data
	;========
	DEC_10				.FILL		#10
	ARRAY_CHARACTERS	.FILL		x4000
	INSTRUCTIONS_1		.STRINGZ	"ENTER 10 Characters\n"
	INSTRUCTIONS_2		.STRINGZ	"\n"
	
    ;=============
    ;Remote Data
    ;=============
    .ORIG x4000
    .BLKW #10
    
.END
