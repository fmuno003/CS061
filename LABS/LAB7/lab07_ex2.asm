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
	;=============
	;INSTRUCTIONS
	;=============
	LD R0, ARRAY_ADDRESS
	LD R6, SUB_GET_STRING_3200
	JSRR R6
	
	LD R6, SUB_IS_A_PALINDROME_3400
	JSRR R6
	
	HALT
	;======
	;DATA
	;======
	SUB_GET_STRING_3200			.FILL		x3200
	ARRAY_ADDRESS				.FILL		x3800
	SUB_IS_A_PALINDROME_3400	.FILL		x3400
	
.ORIG x3800
	STRING_ARRAY_3800 	.BLKW		#
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

;============================================================================
; Subroutine: SUB_IS_A_PALINDROME_3400
; Parameter (R0): The address of a string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R0) is
; a palindrome or not returned a flag indicating such.
; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;============================================================================
.ORIG x3400
	;=======================
	;SUBROUTINE INSTRUCTIONS
	;=======================
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
    ADD R1, R0, #0			;move the starting address of the string to register 1
    ADD R2, R0, R5			;try to figure out the ending address of string and store it in register 2
    ADD R2, R2, #-1			;decrement the address by 1 since the string is using x3800
    
DO_WHILE_LOOP_3400
	LDR R3, R1, #0			;load the value at memory location of register 1 into register 3
    LDR R6, R2, #0			;load the value at memory location of register 2 into register 6
    
    NOT R6, R6				;take the two's complement of register 6
    ADD R6, R6, #1
    ADD R4, R3, R6			;add them together and if they are zero then that part is a palindrome
    BRz	CONTINUE_3400		;if register 4 is zero continue with the loop
    BRnp NOT_A_PALINDROME	;if register 4 is negative or positive, it is not a palindrome and finish the loop
    
CONTINUE_3400    
    ADD R1, R1, #1			;increment the memory location in register 1 by 1
    ADD R2, R2, #-1			;decrement the memory location in register 2 by 1
   	ADD R5, R5, #-1			;decrement the size of the string by 1
 	BRp DO_WHILE_LOOP_3400	;if register 5 is still positive, continue with the loop
 	BRz	PALINDROME			;if register 5 is zero, it is a palindrome
  
PALINDROME
	LD R4, PALINDROME_3400	;load register 4 with 1 to signify it is a palindrome
	BRp ALL_DONE_3400		;branch to all done
	
NOT_A_PALINDROME
	LD R4, ZERO_3400    	;load register 4 with 0 to signify it is not a palindrome
	
ALL_DONE_3400
    ;========
	;RESTORE
	;========
	LD R7, BACKUP_R7_3400
	LD R6, BACKUP_R6_3400
	LD R5, BACKUP_R5_3400
	LD R3, BACKUP_R3_3400
    LD R2, BACKUP_R2_3400
	LD R1, BACKUP_R1_3400
	LD R0, BACKUP_R0_3400
	;=======
	;RETURN
	;=======
	RET
	
	;=================
	;SUBROUTINE DATA
	;=================
	BACKUP_R7_3400		.BLKW	#1
	BACKUP_R6_3400		.BLKW	#1
	BACKUP_R5_3400		.BLKW	#1
	BACKUP_R4_3400		.BLKW	#1
	BACKUP_R3_3400		.BLKW	#1
	BACKUP_R2_3400		.BLKW	#1
	BACKUP_R1_3400		.BLKW	#1
	BACKUP_R0_3400		.BLKW	#1
	PALINDROME_3400		.FILL	#1
	ZERO_3400			.FILL	#0
.END
