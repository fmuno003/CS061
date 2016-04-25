;=================================================
; Name: Munoz, Francisco
; Username: fmuno003    (fmuno003@ucr.edu)
; 
; Lab: Lab 06
; Lab section: 021
; TA: Bryan Marsh
; 
;=================================================
.ORIG x3000
	;==============
	;INSTRUCTIONS
	;==============
	LEA R0, PROMPT_MESSAGE
	TRAP x22
	LEA R0, NEW_LINE
	TRAP x22
	TRAP x20
	ADD R1, R0, #0
	TRAP x21
	LEA R0, NEW_LINE
	TRAP x22
	LD R6, COUNTING_BINARY_3200
	JSRR R6
	ADD R0, R5, #0
	TRAP x21
	LEA R0, NEW_LINE
	TRAP x22
	HALT
	;=====
	;DATA
	;=====
	COUNTING_BINARY_3200		.FILL		x3200
	PROMPT_MESSAGE				.STRINGZ	"Please input a single character from the keyboard"
	NEW_LINE					.STRINGZ	"\n"
;=======================================
;SUBROUTINE NAME: COUNTING_BINARY_3200
;PARAMETER:
;POSTCONDITION:
;RETURN VALUE: N/A
;=======================================
.ORIG x3200
	;========================
	;SUBROUTINE INSTRUCTIONS
	;========================
	ST R7, BACKUP_R7_3200
    ST R6, BACKUP_R6_3200
    ST R5, BACKUP_R5_3200
    ST R4, BACKUP_R4_3200
    ST R3, BACKUP_R3_3200
    ST R2, BACKUP_R2_3200
    ST R1, BACKUP_R1_3200
    ST R0, BACKUP_R0_3200
    ;==========
    ;ALGORITHM
    ;==========	
    LD R3, ASCII_CONVERSION
    LD R5, COUNTER_VALUE_3200
    LD R2, FOR_LOOP_COUNTER_3200 
    
    FOR_LOOP_3200
		IF_STATEMENT_3200
			ADD R1, R1, #0
			BRn ADD_ONE_3200
			BRzp CONTINUE_CODE_3200
ADD_ONE_3200
	ADD R5, R5, #1

CONTINUE_CODE_3200	
	ADD R1, R1, R1	
	ADD R2, R2, #-1
	
	BRzp FOR_LOOP_3200
	END_FOR_LOOP_3200
    
	ADD R5, R5, R3
    ;========
    ;RESTORE
    ;========
    LD R7, BACKUP_R7_3200
    LD R6, BACKUP_R6_3200
    LD R4, BACKUP_R4_3200
    LD R3, BACKUP_R3_3200
    LD R2, BACKUP_R2_3200
    LD R1, BACKUP_R1_3200
    LD R0, BACKUP_R0_3200
    ;=======
    ;RETURN
    ;=======
    RET
    
    ;================
    ;SUBROUTINE DATA
    ;================
    BACKUP_R7_3200      	.BLKW       #1
    BACKUP_R6_3200      	.BLKW       #1
    BACKUP_R5_3200      	.BLKW       #1
    BACKUP_R4_3200      	.BLKW       #1
    BACKUP_R3_3200      	.BLKW       #1
    BACKUP_R2_3200      	.BLKW       #1
    BACKUP_R1_3200      	.BLKW       #1
    BACKUP_R0_3200  	    .BLKW       #1
    COUNTER_VALUE_3200		.FILL		#0
    FOR_LOOP_COUNTER_3200	.FILL		#15
	ASCII_CONVERSION		.FILL		#48

.END
