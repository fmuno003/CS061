;=================================================
; Name: Munoz, Francisco
; Username: fmuno003    (fmuno003@ucr.edu)
; 
; Lab: Lab 08
; Lab section: 021
; TA: Bryan Marsh
; 
;=================================================
.ORIG x3000
    ;==============
    ;INSTRUCTIONS
    ;==============
    LD R0, ARRAY_ADDRESS
    LD R6, SUB_TEST_HARNESS
    JSRR R6
    
    LD R6, SUB_TO_UPPER_3200
    JSRR R6
    
    TRAP x22
    
    LEA R0, NEW_LINE_3000
    TRAP x22
    
    HALT
    ;=====
    ;DATA
    ;=====
    SUB_TO_UPPER_3200   .FILL       x3200
    SUB_TEST_HARNESS    .FILL       x3400
    ARRAY_ADDRESS       .FILL       x5000
    NEW_LINE_3000       .STRINGZ    "\n"
;=======================================================================
;SUBROUTINE NAME: SUB_TO_UPPER_3200
;PARAMETER (R0): Address to store a string at
;POSTCONDITION: The subroutine has allowed the user to input a string,
;               terminated by the [ENTER] key, has converted the string
;               to upper-case, and has stored it in a null-terminated 
;               array that starts at (R0).
;RETURN VALUE: R0 ← The address of the now upper case string.
;=======================================================================
.ORIG x3200
    ;=========================
    ;SUBROUTINE INSTRUCTIONS
    ;=========================
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
    ADD R1, R0, #0
    LD R2, UPPERCASE_ADDRESS
    LD R3, HEX_CONVERSION
    
DO_WHILE_LOOP_3200
    LDR R4, R1, #0
    ADD R6, R4, R3
    BRp LOWERCASE_3200
    BRnz UPPER_CASE_ALREADY_3200
    
LOWERCASE_3200
    ADD R6, R4, #-16
    ADD R6, R6, #-16
    ADD R6, R6, #-16
    ADD R6, R6, #-16
    ADD R6, R6, #-16
    ADD R6, R6, #-10
    BRnz UPPER_CASE_ALREADY_3200
    
    ADD R4, R3, R4
    STR R4, R2, #0
    BRnzp KEEP_GOING_3200

UPPER_CASE_ALREADY_3200
    STR R4, R2, #0
    
KEEP_GOING_3200
    ADD R2, R2, #1
    ADD R1, R1, #1
    
    ADD R5, R5, #-1
    BRzp DO_WHILE_LOOP_3200

    LD R5, BACKUP_R5_3200
    NOT R5, R5
    ADD R5, R5, #0
    ADD R0, R2, R5
    ;========
    ;RESTORE
    ;========
    LD R7, BACKUP_R7_3200
    LD R6, BACKUP_R6_3200
    LD R5, BACKUP_R5_3200
    LD R4, BACKUP_R4_3200
    LD R3, BACKUP_R3_3200
    LD R2, BACKUP_R2_3200
    LD R1, BACKUP_R1_3200
    
    ;=======
    ;RETURN
    ;=======
    RET
    
    ;================
    ;SUBROTUINE DATA
    ;================
    BACKUP_R7_3200      .BLKW       #1
    BACKUP_R6_3200      .BLKW       #1
    BACKUP_R5_3200      .BLKW       #1
    BACKUP_R4_3200      .BLKW       #1
    BACKUP_R3_3200      .BLKW       #1
    BACKUP_R2_3200      .BLKW       #1
    BACKUP_R1_3200      .BLKW       #1
    BACKUP_R0_3200      .BLKW       #1
    HEX_CONVERSION      .FILL       #-32
    UPPERCASE_ADDRESS   .FILL       x6000
;================================================================
; Test Harness for SUB_TO_UPPER subroutine:
; 
; (1) R0 ← Some address where we will store a user-input string
; (2) Call SUB_TO_UPPER subroutine
; (3) Trap x22 (i.e. print out the now-uppercase string)
;================================================================
.ORIG x3400
    ;========================
    ;SUBROUTINE INSTRUCTIONS
    ;========================
    ST R7, BACKUP_R7_3400
    ST R6, BACKUP_R6_3400
    ST R5, BACKUP_R5_3400
    ST R4, BACKUP_R4_3400
    ST R3, BACKUP_R3_3400
    ST R2, BACKUP_R2_3400
    ST R1, BACKUP_R1_3400
    ST R0, BACKUP_R0_3400
    ;==========
    ;ALGORITHM
    ;==========
    ADD R1, R0, #0					;moved address from register 0 to register 1
    LEA R0, PROMPT_MESSAGE_3400		;load register 0 with prompt message
    TRAP x22						;output the message
    LEA R0, NEWLINE_3400
    LD R2, ENTER_ASCII_3400			;load register 2 with value of enter key
    NOT R2, R2						;take the two's complement of register 2
    ADD R2, R2, #1
    
DO_WHILE_LOOP_3400
	TRAP x20						;take input from user
    TRAP x21
    ADD R3, R0, R2					;check to see if enter key or not
    BRz STOP_TAKING_INPUTS_3400		;if enter key stop taking inputs

KEEP_GOING_3400
	STR R0, R1, #0					;store the value of register 0 into register 1
	ADD R1, R1, #1					;increment the memory address by 1
	ADD R5, R5, #1					;increment the number of non-sentinel characters by 1
	BRp	DO_WHILE_LOOP_3400			;go back top do while loop

STOP_TAKING_INPUTS_3400
    NOT R5, R5
    ADD R5, R5, #1
    ADD R0, R5, R1
    NOT R5, R5
    ADD R5, R5, #1
    
    NOT R5, R5
    ADD R5, R5, #1
    ADD R0, R5, R1
    NOT R5, R5
    ADD R5, R5, #1
    ;========
    ;RESTORE
    ;========
    LD R7, BACKUP_R7_3400
    LD R6, BACKUP_R6_3400
    LD R4, BACKUP_R4_3400
    LD R3, BACKUP_R3_3400
    LD R2, BACKUP_R2_3400
    LD R1, BACKUP_R1_3400
    ;=======
    ;RETURN
    ;=======
    RET
    
    ;================
    ;SUBROUTINE DATA
    ;================
    BACKUP_R7_3400      .BLKW       #1
    BACKUP_R6_3400      .BLKW       #1
    BACKUP_R5_3400      .BLKW       #1
    BACKUP_R4_3400      .BLKW       #1
    BACKUP_R3_3400      .BLKW       #1
    BACKUP_R2_3400      .BLKW       #1
    BACKUP_R1_3400      .BLKW       #1
    BACKUP_R0_3400      .BLKW       #1
    ENTER_ASCII_3400	.FILL		#10
	PROMPT_MESSAGE_3400	.STRINGZ	"Enter a string then press ENTER key.\n"
	NEWLINE_3400		.STRINGZ	"\n"

.ORIG x5000
    .BLKW   #
    
.ORIG x6000
    .BLKW   #
