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
	LD R6, INPUT_NUMBER_3200
	JSRR R6
	ADD R1, R1, #1
	
	LD R6, OUTPUT_NUMBER_3400
	JSRR R6
	
	HALT
	;=====
	;DATA
	;=====
	INPUT_NUMBER_3200	.FILL	x3200
	OUTPUT_NUMBER_3400	.FILL	x3400
	
	
;===============================
;SUBROUTINE: INPUT_NUMBER_3200
;PARAMETER:
;POSTCONDITION: The subroutine will ask the user for an input and store it into register 1.
;RETURN VALUE: REGISTER 1
;===============================
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
    ;===========
    ;ALGORITHM
    ;===========
DO_WHILE_LOOP_3201
	LD R1, DEC_10_3200
	NOT R1, R1
	ADD R1, R1, #1
	LEA R0, MESSAGE_PROMPT_3200				;loads prompt message into Register 0
    TRAP x22							;outputs prompt message
    
    LEA R0, NEW_LINE_3200					;loads new line into register 0
    TRAP x22							;outputs new line
    
    TRAP x20							;asks user for input
    TRAP x21
		IF_STATEMENT_3204
			ADD R1, R1, R0
			BRz		INCORRECT_INPUT_3200
			BRnp	THIS_CODE_WORKS_3200
			
THIS_CODE_WORKS_3200
		LD R1, DEC_0_3200
    	LD R5, POSITIVE_NEGATIVE				;loads the hexadecimal value for negative sign
    	NOT R5, R5							;two's complement of register 5
    	ADD R5, R5, #1						;add one to register 5
    	ADD R2, R0, #0						;move the value from register 0 to register 2
    	ADD R3, R5, R2						;add register 5 and register 2 and store it in register 3
    	BRz		NEGATIVE					;if register 3 is zero, then go to Negative
		BRn		POSITIVE					;if register 3 is negative, then go to positive
		BRp		CONTINUE_CODE				;if register 3 is positive, then continue with the code
	
NEGATIVE								
    TRAP x20							;asks the user for another input
	TRAP x21
	LD R5, NEGATIVE_ONE	
	IF_STATEMENT_3202
		LD R6, ASCII_CONVERSION
		NOT R6, R6
		ADD R6, R6, #1
		ADD R0, R0, R6
		BRn	INCORRECT_INPUT_3200
		BRzp		CONTINUE_THE_CODES

POSITIVE								
	TRAP x20							;asks the user for another input
	TRAP x21
	LD R5, DEC_0_3200
	IF_STATEMENT_3203
		LD R6, ASCII_CONVERSION
		NOT R6, R6
		ADD R6, R6, #1
		ADD R0, R0, R6
		BRn	INCORRECT_INPUT_3200
		BRzp		CONTINUE_CODES

CONTINUE_CODE
	LD R6, ASCII_CONVERSION
	NOT R6, R6
	ADD R6, R6, #1
	ADD R1, R0, R6
	LD R5, DEC_0_3200
	BRz	CONTINUE_CODES
	
CONTINUE_THE_CODES
	LD R5, NEGATIVE_ONE					;loads the value #1 into register 5
	BRp CONTINUE_CODES
	
CONTINUE_CODES		
    LD R4, NUMBER_CONDITION				;loads the value of #57 to check if just numbers and not letters
    NOT R4, R4							;take the one's complement of register 4
    ADD R4, R4, #1						;add one to register 4 to complete two's complement
    ADD R3, R4, R2						;add register 4 and register 2 and store it in register 3
    BRp		INCORRECT_INPUT_3200		;if register 3 is positive, it is not a number
    BRnz	CONTINUE_CODING				;if register 3 is zero or negative, the input is a number, continue coding

INCORRECT_INPUT_3200
	LEA R0, NEW_LINE_3200
	TRAP x22
	LEA R0, INVALID_INPUT				;loads the incorrect messaage into register 0
	TRAP x22							;outputs the invalid statment in register 0
	LEA R0, NEW_LINE_3200
	TRAP x22
	ADD R0, R0, #0
	BRnzp	DO_WHILE_LOOP_3201

CONTINUE_CODING
	ADD R1, R0, R1						;add what is register 0 into register 1
	ADD R1, R1, R6
	BRp	RE_WORK
	BRnz RE_DO
	
	
RE_WORK
	ADD R1, R0, R6
	BRp HERE_IT_CONTINUES

RE_DO
	NOT R6, R6
	ADD R6, R6, #1
	ADD R1, R1, R6
	NOT R6, R6
	ADD R6, R6, #1
	BRn HERE_IT_CONTINUES
	
HERE_IT_CONTINUES
	DO_WHILE_LOOP
		TRAP x20						;ask the user for a second input
		TRAP x21
		IF_STATEMENT
			ADD R3, R0, R4				;here we will have a if statement checking if the input is a letter or
			BRp		INCORRECT_INPUT_3200
			BRnz	CONTINUE_THE_CODE	;number. if its a number continue with a for_loop to calculate the number
										;if its a letter, output invalid message and start program again.
										
CONTINUE_THE_CODE
	LD R2, ENTER_KEY					;loads the value of the ENTER key into register 2
	NOT R2, R2							;one's complement of register 2
	ADD R2, R2, #1						;add one to compplete two's complement
    	ADD R3, R2, R0					;add register 2 and register 0 and store in register 3
    BRp	CONTINUE						;if register 3 is positive continue with the code
    BRz	STOP_TAKING_INPUTS				;if register 3 is negative, move to stop taking inputs
    
CONTINUE
	LD R6, ASCII_CONVERSION				;loads the ascii conversion into register 6
	NOT R6, R6							;one's complement of register 6
	ADD R6, R6, #1						;add one to register 6 to complete two's complement
	ADD R0, R0, R6						;add what is in register 0 and register 6 and stores it into register 3
	LD R6, DEC_9_3200					;load register 6 with the value #10
	ADD R3, R1, #0
	FOR_LOOP
		ADD R3, R1, R3

		ADD R6, R6, #-1
		BRp	FOR_LOOP
		END_FOR_LOOP
		ADD R1, R3, R0
		LD R6, DEC_9_3200
	BRp DO_WHILE_LOOP
	
	
STOP_TAKING_INPUTS    
	END_DO_WHILE_LOOP
	END_DO_WHILE_LOOP_3201
	
	IF_STATEMENT1
		ADD R5, R5, #0
		BRz	DO_NOTHING
		BRp	DO_SOMETHING
	
DO_SOMETHING
	NOT R1, R1
	ADD R1, R1, #1
	BRz DO_NOTHING
	
DO_NOTHING
    ;=========
    ;RESTORE
    ;=========
    LD R7, BACKUP_R7_3200
    LD R6, BACKUP_R6_3200
    LD R5, BACKUP_R5_3200
    LD R4, BACKUP_R4_3200
    LD R3, BACKUP_R3_3200
    LD R2, BACKUP_R2_3200
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
    MESSAGE_PROMPT_3200	.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER"
	NEW_LINE_3200		.STRINGZ	"\n"
	POSITIVE_NEGATIVE	.FILL		x2D
	NUMBER_CONDITION	.FILL		#57
	NEGATIVE_ONE		.FILL		#1
	INVALID_INPUT		.STRINGZ	"ERROR INVALID INPUT"
	DEC_0_3200			.FILL		#0
	DEC_9_3200			.FILL		#9
	ENTER_KEY			.FILL		x0A
	ASCII_CONVERSION	.FILL		x30
	ZERO_3200   		.FILL		#0
	DEC_3_3200			.FILL		#3
	DEC_10_3200			.FILL		#10

;====================================
;SUBROUTINE NAME: OUTPUT_NUMBER_3400
;PARAMETER:
;POSTCONDITION:
;RETURN VALUE:
;====================================
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
    LD R6, ZERO_3400
    LD R2, COUNTER_VALUE_3400		;REGISTER 2 HOLDS THE COUNTER VALUE
    LD R3, ASCII_CONVERSION_3400
    ADD R4, R1, #0					;REGISTER 4 HOLDS THE NEW NUMBER TO BE OUTPUTTED
    
    LD R5, TEN_THOUSAND_3400		;TEN THOUSANDS PLACE
    NOT R5, R5						;TWO'S COMPLEMENT OF REGISTER 5
    ADD R5, R5, #1
    
    DO_WHILE_LOOP_3400				;DO_WHILE_LOOP OF TEN_THOUSANDS
    	ADD R4, R5, R4				;ADD #-10000 TO REGISTER 4
    	
    	BRp INCREMENT_COUNTER_3400	;IF REGISTER 4 IS POSITIVE BRANCH HERE
    	BRn	CONTINUE_LOOP_3400		;IF REGISTER 4 IS NEGATIVE BRANCH HERE
    	
INCREMENT_COUNTER_3400				;this branch will increment the counter
		ADD R2, R2, #1				;increment the value by one
			
CONTINUE_LOOP_3400					;this continues the loop
    	ADD R4, R4, #0
    	BRp DO_WHILE_LOOP_3400		;checks if REGISTER 4 IS negative or positive
    	
CONTINUE_CODING_3400				;this continues the code of the first loop
	LD R5, TEN_THOUSAND_3400		;loads register 5 with #10000
	ADD R4, R5, R4
	ADD R2, R2, #0
	BRz CONTINUE_THE_CODE_3400
	
PRINT_OUT_COUNTER_3400
	ADD R0, R3, R2
	TRAP x21
	LD R6, START_PRINTING_3400
	LD R2, COUNTER_VALUE_3400

CONTINUE_THE_CODE_3400				;
	LD R5, ONE_THOUSAND_3400
	NOT R5, R5
	ADD R5, R5, #1
	
    DO_WHILE_LOOP_3401
    	ADD R4, R5, R4
    	
    	BRp INCREMENT_COUNTER_3401
    	BRn	CONTINUE_LOOP_3401
    	
INCREMENT_COUNTER_3401
		ADD R2, R2, #1
			
CONTINUE_LOOP_3401
		ADD R4, R4, #0
    	BRp DO_WHILE_LOOP_3401

CONTINUE_CODING_3401
	LD R5, ONE_THOUSAND_3400
	ADD R4, R5, R4
	ADD R6, R6, #0
	BRp PRINT_OUT_COUNTER_3401
	ADD R2, R2, #0
	BRz CONTINUE_THE_CODE_3401


PRINT_OUT_COUNTER_3401
	ADD R0, R3, R2
	TRAP x21
	LD R6, START_PRINTING_3400
	LD R2, COUNTER_VALUE_3400
	
CONTINUE_THE_CODE_3401					;
	LD R5, ONE_HUNDRED_3400
	NOT R5, R5
	ADD R5, R5, #1
    DO_WHILE_LOOP_3402
    	ADD R4, R5, R4
    	
    	BRp INCREMENT_COUNTER_3402
    	BRn	CONTINUE_LOOP_3402
    	
INCREMENT_COUNTER_3402
		ADD R2, R2, #1
			
CONTINUE_LOOP_3402
		ADD R4, R4, #0
    	BRp DO_WHILE_LOOP_3402

CONTINUE_CODING_3402
	LD R5, ONE_HUNDRED_3400
	ADD R4, R5, R4
	ADD R6, R6, #0
	BRp PRINT_OUT_COUNTER_3402
	ADD R2, R2, #0
	BRz CONTINUE_THE_CODE_3402


PRINT_OUT_COUNTER_3402
	ADD R0, R3, R2
	TRAP x21
	LD R6, START_PRINTING_3400
	LD R2, COUNTER_VALUE_3400
		
CONTINUE_THE_CODE_3402					;
	LD R5, TENS_3400
	NOT R5, R5
	ADD R5, R5, #1
	
    DO_WHILE_LOOP_3403
    	ADD R4, R5, R4
		BRp INCREMENT_COUNTER_3403
    	BRn	CONTINUE_LOOP_3403
    	
INCREMENT_COUNTER_3403
		ADD R2, R2, #1
			
CONTINUE_LOOP_3403
		ADD R4, R4, #0
    	BRp DO_WHILE_LOOP_3403
    	BRn	CONTINUE_CODING_3403

CONTINUE_CODING_3403
	LD R5, TENS_3400
	ADD R4, R5, R4
	ADD R6, R6, #0
	BRp PRINT_OUT_COUNTER_3403
	ADD R2, R2, #0
	BRz CONTINUE_THE_CODE_3403


PRINT_OUT_COUNTER_3403
	ADD R0, R3, R2
	TRAP x21
	LD R6, START_PRINTING_3400
	LD R2, COUNTER_VALUE_3400

CONTINUE_THE_CODE_3403					;
	ADD R0, R3, R4
	TRAP x21
	
    ;=========
    ;RESTORE
    ;=========
   	LD R7, BACKUP_R7_3400
    LD R6, BACKUP_R6_3400
    LD R5, BACKUP_R5_3400
    LD R4, BACKUP_R4_3400
    LD R3, BACKUP_R3_3400
    LD R2, BACKUP_R2_3400
    LD R1, BACKUP_R1_3400
    LD R0, BACKUP_R0_3400
    ;=======
    ;RETURN
    ;=======
    RET
    
    ;================
    ;SUBROUTINE DATA
    ;================
    BACKUP_R7_3400  	    .BLKW       #1
    BACKUP_R6_3400  	    .BLKW       #1
    BACKUP_R5_3400  	    .BLKW       #1
    BACKUP_R4_3400  	    .BLKW       #1
    BACKUP_R3_3400  	    .BLKW       #1
    BACKUP_R2_3400  	    .BLKW       #1
    BACKUP_R1_3400  	    .BLKW       #1
    BACKUP_R0_3400  	    .BLKW       #1
    COUNTER_VALUE_3400		.FILL		#0
    TEN_THOUSAND_3400		.FILL		#10000
    ONE_THOUSAND_3400		.FILL		#1000
    ONE_HUNDRED_3400		.FILL		#100
    TENS_3400				.FILL		#10
    ONES_3400				.FILL		#1
    ASCII_CONVERSION_3400	.FILL		#48
    START_PRINTING_3400		.FILL		#1
    ZERO_3400
.END
