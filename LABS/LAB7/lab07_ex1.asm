;=================================================
; Name: Munoz, Francisco
; Username: fmuno003    (fmuno003@ucr.edu)
; 
; Lab: Lab 07
; Lab section: 021
; TA: Bryan Marsh
; 
;=================================================
.ORIG x3000
	;==============
	;INSTRUCTIONS
	;==============
	LD R0, ARRAY_ADDRESS
	LD R6, SUB_GET_STRING_3200
	JSRR R6
	
	HALT
	;=====
	;DATA
	;=====
	SUB_GET_STRING_3200		.FILL	x3200
	ARRAY_ADDRESS			.FILL	x3800

.ORIG x3800
	STRING_ARRAY		.BLKW	#
;============================================================================
; Subroutine: SUB_GET_STRING_3200
; Parameter (R0): The address of where to start storing the string
; Postcondition: The subroutine has allowed the user to input a string,
;				 terminated by the [ENTER] key, and has stored it in 
;				 an array that starts at (R0) and is NULL-terminated.
; Return Value: R5 The number of non-sentinel characters read from the user
;============================================================================
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
    ADD R1, R0, #0					;moved address from register 0 to register 1
    LEA R0, PROMPT_MESSAGE_3200		;load register 0 with prompt message
    TRAP x22						;output the message
    LD R2, ENTER_ASCII_3200			;load register 2 with value of enter key
    NOT R2, R2						;take the two's complement of register 2
    ADD R2, R2, #1
    
DO_WHILE_LOOP_3200
	TRAP x20						;take input from user
    
    ADD R3, R0, R2					;check to see if enter key or not
    BRz STOP_TAKING_INPUTS_3200		;if enter key stop taking inputs

KEEP_GOING_3200
	STR R0, R1, #0					;store the value of register 0 into register 1
	ADD R1, R1, #1					;increment the memory address by 1
	ADD R5, R5, #1					;increment the number of non-sentinel characters by 1
	BRp	DO_WHILE_LOOP_3200			;go back top do while loop

STOP_TAKING_INPUTS_3200
	LD R0, BACKUP_R0_3200			;restore register 0
	TRAP x22						;out put the string
	LEA R0, NEWLINE_3200			;load register 0 with new line
	TRAP x22						;output new line
	;=========
    ;RESTORE
    ;=========
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
    
    ;=================
    ;SUBROUTINE DATA
    ;=================
    BACKUP_R7_3200      .BLKW       #1
    BACKUP_R6_3200      .BLKW       #1
    BACKUP_R5_3200      .BLKW       #1
    BACKUP_R4_3200      .BLKW       #1
    BACKUP_R3_3200      .BLKW       #1
    BACKUP_R2_3200      .BLKW       #1
    BACKUP_R1_3200      .BLKW       #1
    BACKUP_R0_3200      .BLKW       #1
	ENTER_ASCII_3200	.FILL		#10
	PROMPT_MESSAGE_3200	.STRINGZ	"Enter a string then press ENTER key.\n"
	NEWLINE_3200		.STRINGZ	"\n"
.END
    
