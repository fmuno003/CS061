;=================================================
; Name: Munoz, Francisco
; Username: fmuno003    (fmuno003@ucr.edu)
; 
; Lab: LAB 05
; Lab section: 021
; TA: Bryan Marsh
; 
;=================================================
.ORIG x3000
	;==============
	;INSTRUCTIONS
	;==============
	LD R5, INPUT_BINARY_3400
	JSRR R5
	
	LEA R0, NEW_LINE
	TRAP x22

	HALT
	;======
	;DATA
	;======
	NEW_LINE				.STRINGZ	"\n"
	INPUT_BINARY_3400		.FILL	x3400	
;===============================
;SUBROUTINE: INPUT_BINARY_3400
;PARAMETER:
;POSTCONDITION:
;RETURN VALUE: REGISTER 2
;===============================
.ORIG x3400
	;=========================
	;SUBROUTINE INSTRUCTIONS
	;=========================
	ST R7, BACKUP_R7_3400
    ST R6, BACKUP_R6_3400
    ST R5, BACKUP_R5_3400
    ST R4, BACKUP_R4_3400
    ST R3, BACKUP_R3_3400
    ST R1, BACKUP_R1_3400
    ST R0, BACKUP_R0_3400
    ;===========
    ;ALGORITHM
    ;===========
DO_WHILE_LOOP	
	LEA R0, PROMPT_USER_3400
	TRAP x22
	LEA R0, NEW_LINE_3400
	TRAP x22
	LD R6, DEC_15_3400
	LD R5, ASCII_CONVERSION_3400
	NOT R5, R5
	ADD R5, R5, #1
	TRAP x20
	TRAP x21
FOR_LOOP_3400    
    TRAP x20
    TRAP x21
    
    IF_STATEMENT_3400
		ADD R1, R5, R0
		BRz ZERO_3400
		BRp ONE_3400
    
ZERO_3400    
	ADD R2, R2, R2
	ADD R2, R2, #0
	BRzp	CONTINUE_3400
ONE_3400
    ADD R2, R2, R2	
    ADD R2, R2, R1

CONTINUE_3400	
    ADD R6, R6, #-1
    BRzp FOR_LOOP_3400
    END_FOR_LOOP_3400
    
END_DO_WHILE_LOOP    
    ;=========
    ;RESTORE
    ;=========
	LD R7, BACKUP_R7_3400
    LD R6, BACKUP_R6_3400
    LD R5, BACKUP_R5_3400
    LD R4, BACKUP_R4_3400
    LD R3, BACKUP_R3_3400
    LD R1, BACKUP_R1_3400
    LD R0, BACKUP_R0_3400
	;=======
	;RETURN
	;=======
	RET
	
	;=================
	;SUBROUTINE DATA
	;=================
    BACKUP_R7_3400      	.BLKW		#1
    BACKUP_R6_3400      	.BLKW		#1
    BACKUP_R5_3400      	.BLKW		#1
    BACKUP_R4_3400      	.BLKW		#1
    BACKUP_R3_3400      	.BLKW		#1
    BACKUP_R1_3400      	.BLKW		#1
    BACKUP_R0_3400      	.BLKW		#1
	DEC_15_3400				.FILL		#15
	ASCII_CONVERSION_3400	.FILL		x30
	DEC_0_3400				.FILL		#0
	NEW_LINE_3400			.STRINGZ	"\n"
	PROMPT_USER_3400		.STRINGZ	"Please enter b followed by the 16 bit binary:"
	
.END
