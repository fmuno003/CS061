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
	LD R6, ARRAY_CHARACTERS
	LD R4, ENTER_KEY
	
	LEA R0, INSTRUCTIONS_1
	TRAP x22
	
	DO_WHILE_LOOP
		TRAP x20
		ADD R1, R0, #0
		
		NOT R4, R4
		ADD R4, R4, #1
		ADD R3, R4, R1
		
		BRz SKIP
		
		TRAP x21
		LEA R0, INSTRUCTIONS_2
		TRAP x22
		STR R1, R6, #0
		ADD R6, R6, #1
		BRp DO_WHILE_LOOP
	END_DO_WHILE_LOOP2
	
SKIP
	END_DO_WHILE_LOOP
	
	HALT
	;=======
	;Data
	;=======
	ARRAY_CHARACTERS		.FILL		x4000
	INSTRUCTIONS_1			.STRINGZ	"Enter as many characters as you would like then press ENTER\n"
	INSTRUCTIONS_2			.STRINGZ	"\n"
	ENTER_KEY				.FILL		xA
	
	;=============
	;Remote Data
	;=============
	.ORIG x4000
	.BLKW #
.END
