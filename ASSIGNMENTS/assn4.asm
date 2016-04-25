;=================================================
; Name: Munoz, Francisco
; Username: fmuno003    (fmuno003@ucr.edu)
; 
; Assignment name: assn04
; Lab section: 021
; TA: Bryan Marsh
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================
.orig x3000								;Program starts here
	;==============
	;Instructions
	;==============
DO_WHILE_LOOP1
	LD R1, DEC_10
	NOT R1, R1
	ADD R1, R1, #1
	LEA R0, MESSAGE_PROMPT				;loads prompt message into Register 0
    	TRAP x22							;outputs prompt message
    
    	LEA R0, NEW_LINE					;loads new line into register 0
    	TRAP x22							;outputs new line
    
    	TRAP x20							;asks user for input
		TRAP x21
		IF_STATEMENT4
			ADD R1, R1, R0
			BRz		INCORRECT_INPUT
			BRnp	THIS_CODE_WORKS
			
THIS_CODE_WORKS
		LD R1, DEC_0
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
	IF_STATEMENT2
		LD R6, ASCII_CONVERSION
		NOT R6, R6
		ADD R6, R6, #1
		ADD R0, R0, R6
		BRn	INCORRECT_INPUT
		BRzp		CONTINUE_THE_CODES

POSITIVE								
	TRAP x20							;asks the user for another input
	TRAP x21
	LD R5, DEC_0
	IF_STATEMENT3
		LD R6, ASCII_CONVERSION
		NOT R6, R6
		ADD R6, R6, #1
		ADD R0, R0, R6
		BRn	INCORRECT_INPUT
		BRzp		CONTINUE_CODES

CONTINUE_CODE
	LD R6, ASCII_CONVERSION
	NOT R6, R6
	ADD R6, R6, #1
	ADD R1, R0, R6
	LD R5, DEC_0
	BRz	CONTINUE_CODES
	
CONTINUE_THE_CODES
	LD R5, NEGATIVE_ONE					;loads the value #1 into register 5
	BRp CONTINUE_CODES
	
CONTINUE_CODES		
    LD R4, NUMBER_CONDITION					;loads the value of #57 to check if just numbers and not letters
    NOT R4, R4							;take the one's complement of register 4
    ADD R4, R4, #1						;add one to register 4 to complete two's complement
    ADD R3, R4, R2						;add register 4 and register 2 and store it in register 3
    BRp		INCORRECT_INPUT					;if register 3 is positive, it is not a number
    BRnz	CONTINUE_CODING					;if register 3 is zero or negative, the input is a number, continue coding

INCORRECT_INPUT
	LEA R0, NEW_LINE
	TRAP x22
	LEA R0, INVALID_INPUT					;loads the incorrect messaage into register 0
	TRAP x22						;outputs the invalid statment in register 0
	LEA R0, NEW_LINE
	TRAP x22
	ADD R0, R0, #0
	BRnzp	DO_WHILE_LOOP1

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
		TRAP x20					;ask the user for a second input
		TRAP x21
		IF_STATEMENT
			ADD R3, R0, R4				;here we will have a if statement checking if the input is a letter or
			BRp		INCORRECT_INPUT1
			BRnz	CONTINUE_THE_CODE		;number. if its a number continue with a for_loop to calculate the number
									;if its a letter, output invalid message and start program again.
INCORRECT_INPUT1
	LEA R0, NEW_LINE
	TRAP x22
	LEA R0, INVALID_INPUT					;loads the invalid message into register 0
	TRAP x22						;outputs the invalid message
	LEA R0, NEW_LINE
	TRAP x22
	LD R0, DEC_9
	BRp		DO_WHILE_LOOP1
	
CONTINUE_THE_CODE
	LD R2, ENTER_KEY					;loads the value of the ENTER key into register 2
	NOT R2, R2						;one's complement of register 2
	ADD R2, R2, #1						;add one to compplete two's complement
    	ADD R3, R2, R0						;add register 2 and register 0 and store in register 3
    BRp	CONTINUE						;if register 3 is positive continue with the code
    BRz	STOP_TAKING_INPUTS					;if register 3 is negative, move to stop taking inputs
    
CONTINUE
	LD R6, ASCII_CONVERSION					;loads the ascii conversion into register 6
	NOT R6, R6						;one's complement of register 6
	ADD R6, R6, #1						;add one to register 6 to complete two's complement
	ADD R0, R0, R6						;add what is in register 0 and register 6 and stores it into register 3
	LD R6, DEC_9						;load register 6 with the value #10
	ADD R3, R1, #0
	FOR_LOOP
		ADD R3, R1, R3

		ADD R6, R6, #-1
		BRp	FOR_LOOP
		END_FOR_LOOP
		ADD R1, R3, R0
		LD R6, DEC_9
	BRp DO_WHILE_LOOP
	
	
STOP_TAKING_INPUTS    
	END_DO_WHILE_LOOP
	END_DO_WHILE_LOOP1
	
	IF_STATEMENT1
		ADD R5, R5, #0
		BRz	DO_NOTHING
		BRp	DO_SOMETHING
	
DO_SOMETHING
	NOT R1, R1
	ADD R1, R1, #1
	BRz DO_NOTHING
	
DO_NOTHING
	

    HALT
    ;======
    ;Data
    ;======
	MESSAGE_PROMPT		.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER"
	NEW_LINE			.STRINGZ	"\n"
	POSITIVE_NEGATIVE	.FILL		x2D
	NUMBER_CONDITION	.FILL		#57
	NEGATIVE_ONE		.FILL		#1
	INVALID_INPUT		.STRINGZ	"ERROR INVALID INPUT"
	DEC_0				.FILL		#0
	DEC_9				.FILL		#9
	ENTER_KEY			.FILL		x0A
	ASCII_CONVERSION	.FILL		x30
	ZERO				.FILL		#0
	DEC_3				.FILL		#3
	DEC_10				.FILL		#10
	;register 5 is set with the number 1 or 0 to signify negative or positive
	;register 1 is set with the number that is being processed for the user
	;register 4 is set with the number for checking if letter or number
	;register 2 is set with the number for checking if ENTER key has been inputted
	;register 6 is set with number for the for loop
.end
