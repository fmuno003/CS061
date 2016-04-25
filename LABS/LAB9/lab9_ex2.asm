;=================================================
; Name: Munoz, Francisco
; Username: fmuno003    (fmuno003@ucr.edu)
; 
; Lab: Lab 09
; Lab section: 021
; TA: Bryan Marsh
; 
;=================================================
.ORIG x3000
    ;=============
    ;INSTRUCTIONS
    ;=============
	LD R6, PROCESS_3600
    JSRR R6
    
    ADD R2 , R2, #-1
DO_WHILE_LOOP_
	LEA R0, PROMPT_MESSAGE_2
	TRAP x22
	TRAP x20
	
	LD R6, ASCII_CONVERSION_3000
	ADD R0, R0, R6
	BRz ALMOST_DONE_3000
	
    LD R6, SUB_STACK_POP_3400
    JSRR R6
    
    ADD R5, R5, #0
    BRz DO_WHILE_LOOP_
    BRp DONE_3000

ALMOST_DONE_3000
	LEA R0, GOODBYE_MESSAGE
	TRAP x22
	
DONE_3000
    HALT
    ;=====
    ;DATA
    ;=====
    PROCESS_3600			.FILL		x3600
    SUB_STACK_POP_3400		.FILL		x3400
    PROMPT_MESSAGE_2		.STRINGZ	"Do you wish to pop? (1 for yes, 0 for no)\n"
    ASCII_CONVERSION_3000	.FILL		#-48
    GOODBYE_MESSAGE			.STRINGZ	"Have a good day!\n"
;========================================================================
;SUBROUTINE NAME: SUB_STACK_POP_3400
;PARAMETER: (R1) STACK_ADDR: a pointer to the beginning of the stack
;			(R2) top: a pointer to item to POP
;			(R3) capacity: the # of additional items the stack can hold
;POSTCONDITION: The subroutine has popped MEM[top] off of the stack. If
;				an underflow occured, the subroutine has printed an 
;				underflow error message and terminated.
;RETURN VALUE: 	R0 <-- value popped off of the stack
;				R2 <-- updated top value
;				R3 <-- updated capacity value
;========================================================================
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
DO_WHILE_LOOP_3400
    LDR R0, R2, #0
    ADD R2, R2, #-1
    ADD R3, R3, #1
    TRAP x21
        
    LEA R0, NEWLINE_3400
    TRAP x22
    
    LD R6, WRONG_ADDRESS
    NOT R6, R6
    ADD R6, R6, #1
    ADD R6, R2, R6
    
    BRn CONTINUE_3400
	BRzp END_OF_SUBROUTINE_3400
	
CONTINUE_3400
	ADD R0, R0, #0
	BRp ERROR_3400
	BRz END_OF_SUBROUTINE_3400
	
ERROR_3400
	LEA R0, UNDERFLOW_MESSAGE
	TRAP x22
	ADD R2, R2, #1
	ADD R5, R5, #1
	BRnzp END_OF_SUBROUTINE_3400

	
END_OF_SUBROUTINE_3400
    ;========
    ;RESTORE
    ;========
    LD R7, BACKUP_R7_3400
    LD R6, BACKUP_R6_3400
    LD R4, BACKUP_R4_3400
    LD R1, BACKUP_R1_3400
    LD R0, BACKUP_R0_3400
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
	UNDERFLOW_MESSAGE	.STRINGZ	"UNDERFLOW! \n"
	ASCII_CONVERSION_	.FILL		#48
	NEWLINE_3400		.STRINGZ	"\n"
	VALUE_1_3400		.FILL		#1
	WRONG_ADDRESS		.FILL		x3FFF
;=========================================================
;SUBROUTINE NAME: PROCESS_3600
;PARAMETERS: None
;POSTCONDITION: Will process PUSH subroutine
;RETURN VALUE: 	R1, address of stack
;				R2, address of current location of stack
;========================================================

.ORIG x3600
    ;========================
    ;SUBROUTINE INSTRUCTIONS
    ;========================
    ST R7, BACKUP_R7_3600
    ST R6, BACKUP_R6_3600
    ST R5, BACKUP_R5_3600
    ST R4, BACKUP_R4_3600
    ST R3, BACKUP_R3_3600
    ST R2, BACKUP_R2_3600
    ST R1, BACKUP_R1_3600
    ST R0, BACKUP_R0_3600
    ;==========
    ;ALGORITHM
    ;==========
    LD R1, ARRAY_STACK_4000
    LD R2, TOP_POINTER_4000
    LD R4, ASCII_CONVERSION
    
    LEA R0, CAPACITY_MESSAGE
    TRAP x22
    TRAP x20
    TRAP x21
    ADD R3, R0, R4
	LEA R0, NEWLINE
	TRAP x22
	
    LEA R0, PROMPT_MESSAGE
    TRAP x22
DO_WHILE_LOOP     
    TRAP x20
    ADD R0, R0, R4
    BRz DO_WHILE_LOOP
    BRp CONTINUE_
	LD R4, ASCII_CONVERSION_2
	ADD R0, R4, R0
	
    LD R4, ENTER_VALUE
    ADD R0, R4, R0
    BRz DONE
    
    ADD R0, R0, #10
CONTINUE_
    LD R4, ASCII_CONVERSION
    NOT R4, R4
    ADD R4, R4, #1
    ADD R0, R4, R0
    NOT R4, R4
    ADD R4, R4, #1
	TRAP x21
    LD R6, SUB_STACK_PUSH_3200
    JSRR R6
    ADD R5, R5, #0
    BRnz DO_WHILE_LOOP

DONE
	LEA R0, NEWLINE
	TRAP x22
    ;========
    ;RESTORE
    ;========
    LD R7, BACKUP_R7_3600
    LD R6, BACKUP_R6_3600
    LD R5, BACKUP_R4_3600
    LD R4, BACKUP_R1_3600
    LD R3, BACKUP_R0_3600
    LD R0, BACKUP_R4_3600
    ;=======
    ;RETURN
    ;=======
    RET
    
    ;=====
    ;DATA
    ;=====
    BACKUP_R7_3600			.BLKW		#1
    BACKUP_R6_3600			.BLKW		#1
    BACKUP_R5_3600			.BLKW		#1
    BACKUP_R4_3600			.BLKW		#1
    BACKUP_R3_3600			.BLKW		#1
    BACKUP_R2_3600			.BLKW		#1
    BACKUP_R1_3600			.BLKW		#1
    BACKUP_R0_3600			.BLKW		#1
    SUB_STACK_PUSH_3200		.FILL		x3200
    ARRAY_STACK_4000		.FILL		x4000
    TOP_POINTER_4000		.FILL		x4000
    PROMPT_MESSAGE			.STRINGZ	"Please input a number (single digits only). Press ENTER when finished:\n"
    CAPACITY_MESSAGE		.STRINGZ	"Please enter a capacity for the stack (single digit only):\n"
    NEWLINE					.STRINGZ	"\n"
    ASCII_CONVERSION		.FILL		#-48
    ENTER_VALUE				.FILL		#-10
    ASCII_CONVERSION_2		.FILL		#48

;=========================================================================
;SUBROUTINE NAME: SUB_STACK_PUSH_3200
;PARAMETER: (R0) The value to push onto stack
;           (R1) stack_addr: a pointer to the beginning of the stack
;           (R2) top: a pointer to the next place to PUSH an item
;           (R3) capacity: the addional items the stack can hold
;POSTCONDITION: The subroutine has pushed (R0) onto the stack. If an
;               overflow occurred, the subroutine has printed an overflow
;               message and terminated.
;RETURN VALUE: R2 <-- updated top value
;              R3 <-- updated capacity value
;=========================================================================
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
    ADD R3, R3, #0
    BRz	CONTINUE_3200
    BRp PUSH_STACK_3200
    
CONTINUE_3200
    ADD R0, R0, #0
    BRp ERROR_3200
    BRz END_OF_SUB_3200
    
PUSH_STACK_3200    
    STR R0, R2, #0
    ADD R2, R2, #1
    ADD R3, R3, #-1
    BRnzp END_OF_SUBROUTINE_3200

END_OF_SUB_3200
	LD R5, VALUE_1
	BRnzp END_OF_SUBROUTINE_3200
	
ERROR_3200
	LEA R0, NEWLINE_3200
	TRAP x22
	LEA R0, OVERFLOW_MESSAGE
	TRAP x22
	LD R5, VALUE_1
	
END_OF_SUBROUTINE_3200
    ;========
    ;RESTORE
    ;========
    LD R7, BACKUP_R7_3200
    LD R6, BACKUP_R6_3200
    LD R4, BACKUP_R4_3200
    LD R1, BACKUP_R1_3200
    LD R0, BACKUP_R0_3200
    ;=======
    ;RETURN
    ;=======
    RET
    
    ;================
    ;SUBROUTINE DATA
    ;================
    BACKUP_R7_3200      .BLKW       #1
    BACKUP_R6_3200      .BLKW       #1
    BACKUP_R5_3200      .BLKW       #1
    BACKUP_R4_3200      .BLKW       #1
    BACKUP_R3_3200      .BLKW       #1
    BACKUP_R2_3200      .BLKW       #1
    BACKUP_R1_3200      .BLKW       #1
    BACKUP_R0_3200      .BLKW       #1
	OVERFLOW_MESSAGE	.STRINGZ	"OVERFLOW: NOT ENOUGH CAPACITY\n"
	NEWLINE_3200		.STRINGZ	"\n"
	VALUE_1				.FILL		#1

.ORIG x4000
ARRAY_STACK		.BLKW 	#



.END
