;=================================================
; Name: Munoz, Francisco
; Username: fmuno003    (fmuno003@ucr.edu)
; 
; Assignment name: assn 05
; Lab section: 021
; TA: Bryan Marsh
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================
.ORIG x3000
    ;==============
    ;INSTRUCTIONS
    ;==============
    LD R0, INPUT_NUMBER_3200
    JSRR R0
    ADD R2, R1, #0
    JSRR R0
    LD R0, TEST_SIZE_3600
    JSRR R0
    LD R0, MULTIPLY_NUMBER_3400
    JSRR R0
    LD R0, CHECKING_REGISTER_6_4200
    JSRR R0
    LD R0, PRINTING_OUT_4000
    JSRR R0
    
    HALT
    ;=====
    ;DATA
    ;=====
    INPUT_NUMBER_3200   		.FILL   x3200
    MULTIPLY_NUMBER_3400		.FILL   x3400
	TEST_SIZE_3600				.FILL	x3600
	PRINTING_OUT_4000			.FILL	x4000
	CHECKING_REGISTER_6_4200	.FILL	x4200
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
	LD R1, DEC_0_3200
	ADD R1, R1, #10
	NOT R1, R1
	ADD R1, R1, #1
	LEA R0, MESSAGE_PROMPT_3200			;loads prompt message into Register 0
    TRAP x22							;outputs prompt message
    
    LEA R0, NEW_LINE_3200				;loads new line into register 0
    TRAP x22							;outputs new line
    
    TRAP x20							;asks user for input
		IF_STATEMENT_3204
			ADD R1, R1, R0
			BRz	INCORRECT_INPUT_3200
			
THIS_CODE_WORKS_3200
		TRAP x21
		LD R1, DEC_0_3200
        LD R5, POSITIVE_NEGATIVE				;loads the hexadecimal value for negative sign
    	NOT R5, R5							;two's complement of register 5
    	ADD R5, R5, #1						;add one to register 5
    	ADD R2, R0, #0						;move the value from register 0 to register 2
    	ADD R3, R5, R2						;add register 5 and register 2 and store it in register 3
    	BRz		NEGATIVE_3200					;if register 3 is zero, then go to Negative
		BRn		POSITIVE_3200					;if register 3 is negative, then go to positive
		BRp		CONTINUE_CODE				;if register 3 is positive, then continue with the code
	
NEGATIVE_3200								
    TRAP x20							;asks the user for another input
	TRAP x21
	LD R5, NEGATIVE_ONE	
	IF_STATEMENT_3202
		LD R4, NUMBER_CONDITION				;loads the value of #57 to check if just numbers and not letters
    	NOT R4, R4							;take the one's complement of register 4
    	ADD R4, R4, #1						;add one to register 4 to complete two's complement
		ADD R3, R0, R4				;here we will have a if statement checking if the input is a letter or
		BRp	INCORRECT_INPUT_3201
		LD R6, ASCII_CONVERSION
		NOT R6, R6
		ADD R6, R6, #1
		ADD R1, R0, R6
		BRn	INCORRECT_INPUT_3201
		BRzp CONTINUE_THE_CODES

POSITIVE_3200								
	TRAP x20							;asks the user for another input
	TRAP x21
	LD R5, DEC_0_3200
	IF_STATEMENT_3203
		LD R4, NUMBER_CONDITION				;loads the value of #57 to check if just numbers and not letters
    	NOT R4, R4							;take the one's complement of register 4
    	ADD R4, R4, #1						;add one to register 4 to complete two's complement
		ADD R3, R0, R4				;here we will have a if statement checking if the input is a letter or
		BRp		INCORRECT_INPUT_3201
		LD R6, ASCII_CONVERSION
		NOT R6, R6
		ADD R6, R6, #1
		ADD R1, R0, R6
		BRn	INCORRECT_INPUT_3201
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
	
CONTINUE_CODES		
    LD R4, NUMBER_CONDITION				;loads the value of #57 to check if just numbers and not letters
    NOT R4, R4							;take the one's complement of register 4
    ADD R4, R4, #1						;add one to register 4 to complete two's complement
    ADD R3, R4, R2						;add register 4 and register 2 and store it in register 3
    BRp		INCORRECT_INPUT_3201		;if register 3 is positive, it is not a number
    BRnz	CONTINUE_CODING				;if register 3 is zero or negative, the input is a number, continue coding

INCORRECT_INPUT_3200
	LEA R0, INVALID_INPUT				;loads the incorrect messaage into register 0
	TRAP x22							;outputs the invalid statment in register 0
	LEA R0, NEW_LINE_3200
	TRAP x22
	ADD R0, R0, #0
	BRnzp	DO_WHILE_LOOP_3201
    
INCORRECT_INPUT_3201
    LEA R0, NEW_LINE_3200
    TRAP x22
	LEA R0, INVALID_INPUT				;loads the incorrect messaage into register 0
	TRAP x22							;outputs the invalid statment in register 0
	LEA R0, NEW_LINE_3200
	TRAP x22
	ADD R0, R0, #0
	BRnzp	DO_WHILE_LOOP_3201

CONTINUE_CODING
	ADD R1, R1, #0
	BRz HERE_IT_CONTINUES
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
	
HERE_IT_CONTINUES
    ADD R5, R5, #0                      ;checks to see if egister 5 holds a 1 or 0
    BRp NEGATIVE_NUMBER_3200            ;if 1, then register 1 is a negative number
    BRz POSITIVE_NUMBER_3200            ;if 0, then register 1 is a positive number

NEGATIVE_NUMBER_3200
    LD R5, TEN_THOUSAND                 ;loads register 5 with the value #10000
    NOT R5, R5                          ;take the two's complement of register 5
    ADD R5, R5, #1
    ADD R1, R1, R5                      ;add register 5 and 1 into register 1
    BRn PROCEED_3200                    ;if register 1 is negative proceed
    BRp STOP_TAKING_INPUTS_3200         ;if registe 1 is positive, stop taking inputs

POSITIVE_NUMBER_3200
    LD R5, TEN_THOUSAND                 ;loads register 5 with the value #10000
    NOT R5, R5                          ;take he two's complement of register 5
    ADD R5, R5, #1  
    ADD R1, R1, R5                      ;add register 5 and 1 into register 1
    BRn PROCEED_3201                    ;if it is negative, continue to proceed
    BRp STOP_TAKING_INPUTS_3201         ;if register 1 is still positive after subtracting #10000, stop taking inputs
    
PROCEED_3200
    NOT R5, R5
    ADD R5, R5, #1
    ADD R1, R5, R1
    LD R5, NEGATIVE_ONE
    BRp PROCEED_TO_CODE_3200

PROCEED_3201
    NOT R5, R5
    ADD R5, R5, #1
    ADD R1, R5, R1
    LD R5, ZERO_3200
    BRz PROCEED_TO_CODE_3200
    
PROCEED_TO_CODE_3200
	DO_WHILE_LOOP
		TRAP x20						;ask the user for a second input
		TRAP x21
		IF_STATEMENT
			ADD R3, R0, R4				;here we will have a if statement checking if the input is a letter or
			BRp	INCORRECT_INPUT_3201    ;number. if its a number continue with a for_loop to calculate the number
										;if its a letter, output invalid message and start program again.
CONTINUE_THE_CODE
	LD R2, ENTER_KEY					;loads the value of the ENTER key into register 2
	NOT R2, R2							;one's complement of register 2
	ADD R2, R2, #1						;add one to compplete two's complement
    ADD R3, R2, R0					    ;add register 2 and register 0 and store in register 3
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
	BRp HERE_IT_CONTINUES
    
STOP_TAKING_INPUTS_3200
    NOT R5, R5
    ADD R5, R5, #1
    ADD R1, R5, R1
    LEA R0, NEW_LINE_3200
    TRAP x22
    LD R5, NEGATIVE_ONE
    BRp STOP_TAKING_INPUTS


STOP_TAKING_INPUTS_3201
    NOT R5, R5
    ADD R5, R5, #1
    ADD R1, R5, R1
    LEA R0, NEW_LINE_3200
    TRAP x22
    LD R5, ZERO_3200

STOP_TAKING_INPUTS    
	END_DO_WHILE_LOOP
	END_DO_WHILE_LOOP_3201
	
	IF_STATEMENT1
		ADD R5, R5, #0
		BRz	DO_NOTHING
	
DO_SOMETHING
	NOT R1, R1
	ADD R1, R1, #1
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
    TEN_THOUSAND        .FILL       #10000
    MESSAGE_PROMPT_3200	.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER"
;==================================
;SUBROUTINE: MULTIPLY_NUMBER_3400
;PARAMETER:	REGISTER 1 AND REGISTER 2
;POSTCONDITION: The subroutine will multiply the two numbers in register 1 and 2 and store it into register 4.
;RETURN VALUE: REGISTER 4
;==================================
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
	ADD R4, R4, R2
	BRz	ZERO_3400
	
	ADD R3, R1, #0                  ;moves what is in register 1 into register 3
	BRn ADD_1_3400                  ;if register 3 is negative, you will move to ADD_1_3400
	BRp SUBTRACT_1_3400             ;if register 3 is positive, you will move to SUBTRACT_1_3400
	BRz ZERO_3400                   ;if register 3 is zero, you will move to ZERO_3400
	
ADD_1_3400
	ADD R3, R3, #1                      
    FOR_LOOP_3400   
        ADD R4, R4, R2              ;add the value in register 2, into register 4
        ADD R3, R3, #1              ;add register 3 and #1
        ADD R2, R2, #0
        BRp	POSITIVE_NUMBER
        BRn	NEGATIVE_NUMBER
        
POSITIVE_NUMBER
		ADD R4, R4, #0        
        BRn	INCORRECT_VALUE_3400
        BRp	CONTINUE_FOR_LOOP
NEGATIVE_NUMBER
		ADD R4, R4, #0
		BRp	INCORRECT_VALUE_3400

CONTINUE_FOR_LOOP 
		ADD R3, R3, #0       
       	BRn FOR_LOOP_3400           ;if register 3 is still negative begin for loop again
       	NOT R4, R4
       	ADD R4, R4, #1
	   	BRnp LAST_STEP_3400          ;if register 3 is zero move over to LAST_STEP_3400

SUBTRACT_1_3400
	ADD R3, R3, #-1
	FOR_LOOP_3401   
	   	ADD R4, R4, R2               ;add the value in register 2 into register 4
	   	ADD R3, R3, #-1              ;add #-1 to register 3
        ADD R2, R2, #0
        BRp	POSITIVE_NUMBER_3401
        BRn	NEGATIVE_NUMBER_3401
        
POSITIVE_NUMBER_3401
		ADD R4, R4, #0        
        BRn	INCORRECT_VALUE_3400
        BRp	CONTINUE_FOR_LOOP_3401
NEGATIVE_NUMBER_3401
		ADD R4, R4, #0
		BRp	INCORRECT_VALUE_3400

CONTINUE_FOR_LOOP_3401 
		ADD R3, R3, #0   
	   BRp FOR_LOOP_3401            ;if register 3 is positive continue with the for loop
       BRz LAST_STEP_3400           ;if register 3 is zero proceed to LAST_STEP_3400
       
ZERO_3400							;this will load register 4 with zero since the multiplication of a number and zero is zero
    LD R4, DEC_0_3400				;load register with the #0
    BRz END_OF_SUBROUTINE_3400		;if register 4 is zero, go to END_OF_SUBROUTINE_3400

LAST_STEP_3400 						;This step checks if register 1 is positive or negative
	ADD R1, R1, #0					;reestablish register 1
	BRn	NEGATIVE_3400				;branch if negative
	BRp	POSITIVE_3400				;branch if positive

NEGATIVE_3400						;if register 1 is negative it goes to this branch
	ADD R2, R2, #0					;reestablish register 2
	BRn	POSITIVE_VALUE_3400			;branch if register 2 is negative
	BRp	NEGATIVE_VALUE_3400			;branch if register 2 is positive
	
POSITIVE_3400						;if register 1 is positive it goes to this branch
	ADD R2, R2, #0					;reestablish register 2
	BRn	NEGATIVE_VALUE_3400			;branch if negative
	BRp	POSITIVE_VALUE_3400			;branch if positive
	
NEGATIVE_VALUE_3400					;if register register 1 is positive and register 2 is negative, or vice versa, branch here
	ADD R4, R4, #0					;reestablish register 4
	BRn	CORRECT_VALUE_3400			;if register 4 is supposed to be negative branch here
	BRp	INCORRECT_VALUE_3400		;if register 4 is not the correct sign branch here
	
POSITIVE_VALUE_3400					;if register 1 and 2 are both positive or both negative, branch here
	ADD R4, R4, #0					;reestablish register 4
	BRn INCORRECT_VALUE_3400		;branch if register 4 is negative, 
	
CORRECT_VALUE_3400
	LD R5, DEC_0_3400				;if the product is the correct sign, it will load register 5 with zero
	BRz	END_OF_SUBROUTINE_3400	
	
INCORRECT_VALUE_3400
	LD R5, DEC_1_3400				;if the product is the wrong sign, it will load register 5 with 1
	
END_OF_SUBROUTINE_3400
	;========
	;RESTORE
	;========
	LD R7, BACKUP_R7_3400
	LD R6, BACKUP_R6_3400
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
    DEC_0_3400          .FILL   #0
    DEC_1_3400			.FILL	#1
;========================================
;SUBROUTINE: TEST_SIZE_3600
;PARAMETER: REGISTER 1 AND REGISTER 2
;POSTCONDITION: The subroutine will check which of the two numbers is smaller and will put the smaller one into	register 1 and the bigger one into register 2.
;RETURN VALUE: REGISTER 1 AND REGISTER 2 
;========================================
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
	ADD R5, R2, #0						;transfer the value in register 2 to register 5
	BRz ZERO_VALUE_3600					;branch if register 5 is zero
	ADD R4, R1, #0						;transfer the value in register 1 to register 4
	BRz ZERO_VALUE_3601					;branch if register 4 is zero
	ADD R3, R5, R4						;add both the registers and store the value in register 3
	
	IF_STATEMENT_3600					;if it's positive, register 2 will be the bigger number
		BRz LEAVE_NUMBERS_3600			;check to see which is negative
		BRn SMALLER_NUMBER_3600			;will move to check which number is smalle
		BRp	BIGGER_NUMBER_3600			;check which number is bigger
		
LEAVE_NUMBERS_3600
	ADD R5, R5, #0					    ;restablish the register
	BRn CORRECT_PLACES_3600				;branch to correct places if register 5 is negative
	
	ADD R4, R4, #0					    ;establishes the register
	BRz END_OF_SUBROUTINE_3600			;if the register is zero go to end of subroutine
	BRn	CORRECT_PLACES_3601				;branch to correct places if register 4 is negative
	
CORRECT_PLACES_3600                    
    ADD R2, R5, #0						;register 2 will hold the negative number
    ADD R1, R4, #0						;register 1 will hold the postive number
    LD R6, SWAP_PLACES_3600				;if this register is one, the values were swapped, so swap them before printing
	BRnzp END_OF_SUBROUTINE_3600		;branch to the end of the subroutine
	
CORRECT_PLACES_3601
	ADD R2, R4, #0						;register 2 will hold the negative number
	ADD R1, R5, #0						;register 1 will hold the positive number
	LD R6, SWAP_PLACES_3600				;if this register is one, the values were swapped, so swap them before printing
	BRnzp END_OF_SUBROUTINE_3600		;branch to the end of the subroutine
	
SMALLER_NUMBER_3600
	NOT R5, R5							;take the two's complement of the value in register 5
	ADD R5, R5, #1					
	ADD R3, R5, R4						;adds the positive and the negative value together
	BRz	SAME_NUMBER_3600				;if the result is zero, then they are the same number and it does not matter where they are located at
	BRp	BIG_NUMBER_3600					;if the result is positive, the value in register 5 is larger number
	BRn SMALL_NUMBER_3600				;if the result is negative, the value in register 5 is the smaller number
	
SAME_NUMBER_3600
	NOT R5, R5							;reverse the two's complement and transfer the number in register 5 into register 1
	ADD R5, R5, #1
	ADD R1, R5, #0						;transfer the value in register 5 to register 1
	ADD R2, R4, #0						;transfer the value in register 4 to regsiter 2
	BRnzp END_OF_SUBROUTINE_3600		;branch to the end of the subroutine
	
BIG_NUMBER_3600
	NOT R5, R5							;reverse the two's complement and trnsfer the value in regsiter 5 to register 2
	ADD R5, R5, #1
	ADD R2, R5, #0						;transfer the value in register 5 to register 2
	ADD R1, R4, #0						;transfer the value in register 4 to register 1
	BRnzp END_OF_SUBROUTINE_3600		;branch to the end of the subroutine

SMALL_NUMBER_3600
	NOT R5, R5							;reverse the two's complement and transfer the value in register 5 to register 1
	ADD R5, R5, #1
	ADD R1, R5, #0						;transfer the value in register 5 to register 1
	ADD R2, R4, #0						;transfer the value in register 4 to register 2
	LD R6, SWAP_PLACES_3600				;
	BRnzp END_OF_SUBROUTINE_3600		;branch to the end of the subroutine

BIGGER_NUMBER_3600
	ADD R5, R5, #0						;check to see if this value in register 5 is negative
	BRn NEGATIVE_NUMBER_3600
	
	ADD R4, R4, #0						;check to see if this value in register 4 is negative
	BRn NEGATIVE_NUMBER_3601			;if it is negative, branch to negative number
	BRp BOTH_POSITIVE_3600				;if register 4 is positive, branch to both positive
	
NEGATIVE_NUMBER_3600
	ADD R1, R5, #0						;transfer the value in register 5 to register 1
	ADD R2, R4, #0						;transfer the value in register 4 to register 2
	LD R6, SWAP_PLACES_3600				;if this register is one, the values were swapped, so swap them before printing
	BRnzp END_OF_SUBROUTINE_3600		;branch to the end of the subroutine

NEGATIVE_NUMBER_3601
	ADD R1, R4, #0						;transfer the value in register 4 to register 1
	ADD R2, R5, #0						;transfer the value in register 5 to register 2
	BRnzp END_OF_SUBROUTINE_3600		;branch to the end of the subroutine
	
BOTH_POSITIVE_3600
	NOT R5, R5							;take the two's complement of register 5 
	ADD R5, R5, #1
	ADD R3, R5, R4						;add register 4 and 5 and store the value in register 3
	BRz SAME_NUMBER_3601				;if register 3 is zero, the values are the same number
	BRn THE_BIGGER_NUMBER_3600			;is register 3 is negative, register 5 is the bigger number
	BRp	THE_SMALLER_NUMBER_3600			;if register 3 is positive, register 5 is the smaller number
	
SAME_NUMBER_3601
	NOT R5, R5							;reverse the two's complement of register 5
	ADD R5, R5, #1					
	ADD R1, R5, #0						;transfer the value in register 5 to register 1
	ADD R2, R4, #0						;transfer the value in register 4 to register 2
	LD R6, SWAP_PLACES_3600				;if this register is one, the values were swapped, so swap them before printing
	BRnzp END_OF_SUBROUTINE_3600		;branch to the end of the subroutine

THE_BIGGER_NUMBER_3600
	NOT R5, R5							;reverse the two's complement of register 5
	ADD R5, R5, #1
	ADD R2, R5, #0						;transfer the value in register 5 to register 2
	ADD R1, R4, #0						;transfer the value in register 4 to register 1
	BRnzp END_OF_SUBROUTINE_3600		;branch to the end of the subroutine
	
THE_SMALLER_NUMBER_3600
	NOT R5, R5							;reverse the two's complement of register 5
	ADD R5, R5, #1						
	ADD R1, R5, #0						;transfer the value in register 5 to register 1
	ADD R2, R4, #0						;transfer the value in register 4 to register 2
	LD R6, SWAP_PLACES_3600				;if this register is one, the values were swapped, so swap them before printing
	BRnzp END_OF_SUBROUTINE_3600		;branch to the end of the subroutine
	
ZERO_VALUE_3600
	ADD R5, R1, #0						;transfer the value in register 5 to register 1
	ADD R4, R2, #0						;transfer the value in register 4 to register 2
    ADD R1, R4, #0
    ADD R2, R5, #0
    LD R6, SWAP_PLACES_3600
	BRnzp END_OF_SUBROUTINE_3600		;branch to the end of the subroutine

ZERO_VALUE_3601
	ADD R1, R4, #0						;transfer the value in register 4 to register 1
	ADD R2, R5, #0						;transfer the value in register 5 to register 2
    
END_OF_SUBROUTINE_3600	
	;========
	;RESTORE
	;========
	LD R7, BACKUP_R7_3600
	LD R5, BACKUP_R5_3600
	LD R4, BACKUP_R4_3600
	LD R3, BACKUP_R3_3600
	LD R0, BACKUP_R0_3600
	;=======
	;RETURN
	;=======
	RET
	
	;=================
	;SUBROUTINE DATA
	;=================
	BACKUP_R7_3600		.BLKW	#1
	BACKUP_R6_3600		.BLKW	#1
	BACKUP_R5_3600		.BLKW	#1
	BACKUP_R4_3600		.BLKW	#1
	BACKUP_R3_3600		.BLKW	#1
	BACKUP_R2_3600		.BLKW	#1
	BACKUP_R1_3600		.BLKW	#1
	BACKUP_R0_3600		.BLKW	#1
	SWAP_PLACES_3600	.FILL	#1
	NUMBER_ZERO_3600
;=================================
;SUBROUTINE: PRINTING_OUT_4000
;PARAMETER: REGISTER 1, REGISTER 2, REGISTER 4
;CONDITION: THIS SUBROUTINE WILL PRINT OUT THE TWO NUMBERS AND THE RESULT.
;RETURN VALUE: N/A
;=================================
.ORIG x4000
	;========================
	;SUBROUTINE INSTRUCTIONS
	;========================
	ST R7, BACKUP_R7_4000
    ST R6, BACKUP_R6_4000
    ST R5, BACKUP_R5_4000
    ST R4, BACKUP_R4_4000
    ST R3, BACKUP_R3_4000
    ST R2, BACKUP_R2_4000
    ST R1, BACKUP_R1_4000
    ST R0, BACKUP_R0_4000
    ;==========
    ;ALGORITHM
    ;==========
	ADD R2, R2, #0					;REESTABLISHES REGISTER 2
	BRn NEGATIVE_SIGN_OUTPUT_4000	;BRANCH if register 2 is negative
	BRz	CONTINUE_CODING_4000		;branch if register 2 is zero
	BRp	POSITIVE_SIGN_OUTPUT_4000	;branch if regsister 2 is positive
	
NEGATIVE_SIGN_OUTPUT_4000			
	LEA R0, NEGATIVE_SIGN_4000		;load register zero with string for negative sign
	TRAP x22						;output the negative sign
	ADD R2, R2, #0					;reestablish register 2
	BRn CONTINUE_CODING_4000		;branch if register 2 is negative

POSITIVE_SIGN_OUTPUT_4000
	LEA R0, POSITIVE_SIGN_4000		;load register 0 with string for positive sign
	TRAP x22						;output the positive sign
	
CONTINUE_CODING_4000
	ADD R2, R2, #0					;restablish register 2
	BRz	ZERO_4000					;branch if register 2 is zero
	BRp	POSITIVE_NUMBER_4000		;branch if register 2 is positive
	BRn	NEGATIVE_NUMBER_4000		;branch if register 2 is negative

ZERO_4000
	LD R3, ASCII_CONVERSION_4000	;load register 3 with the ascii conversion
	ADD R0, R2, R3					;converts register 2 into an ascii character and loads into register 0
	TRAP x21						;outputs the zero
	LD R3, ZERO_VALUE_4000
	ADD R2, R2, #0
	BRz CONTINUE_CODING_4001		;branch if register 2 is zero

POSITIVE_NUMBER_4000
	ADD R3, R1, #0					;moves the value in register 1 into register 5
	ADD R1, R2, #0					;moves the value in register 2 into register 1
	LD R6, PRINTING_OUT_3800		;loads register 6 with the memory address of PRINTING_OUT_3800
	JSRR R6							;jumps to the memory address in register 6
    LD R6, BACKUP_R6_4000
	ADD R1, R1, #0
	BRp CONTINUE_CODING_4001
	
NEGATIVE_NUMBER_4000			
	ADD R3, R1, #0					;moves the value in register 1 into register 5
	ADD R1, R2, #0					;moves the value in regsiter 2 into register 1
	NOT R1, R1						;since the number is negative, take the two's complement to become positive
	ADD R1, R1, #1					
	LD R6, PRINTING_OUT_3800		;loads register 6 with the memory address of PRINTING_OUT_3800
	JSRR R6							;jumps to the memory address in register 6
    LD R6, BACKUP_R6_4000
	NOT R1, R1						;reverse the two's complement of the value in register 1
	ADD R1, R1, #1
	
CONTINUE_CODING_4001
	LEA R0, MULTIPLY_4000			;load register 0 with the string for the multiplication sign
	TRAP x22 						;output the multiplication sign onto the screen
	
	ADD R2, R1, #0
	ADD R1, R3, #0
    LD R3, ZERO_VALUE_4000
    ADD R2, R2, #0
	BRn NEGATIVE_SIGN_OUTPUT_4002	;BRANCH if register 2 is negative
	BRz	CONTINUE_CODING_4002		;branch if register 2 is zero
	BRp	POSITIVE_SIGN_OUTPUT_4002	;branch if regsister 2 is positive

NEGATIVE_SIGN_OUTPUT_4002
    ADD R1, R1, #0
    BRn NEGATIVE_SIGN_OUTPUT_4003
    BRp POSITIVE_SIGN_OUTPUT_4003
    BRz ZERO_TEST_4000
   
ZERO_TEST_4000
    ADD R6, R6, #0
    BRp HERE_4000
    BRz OVER_HERE_4000

HERE_4000
    ADD R2, R2, #0
    BRp POSITIVE_SIGN_OUTPUT_4003
    BRn NEGATIVE_SIGN_OUTPUT_4003
    BRz ZERO_4001
    
OVER_HERE_4000
    ADD R1, R1, #0
    BRp POSITIVE_SIGN_OUTPUT_4003
    BRn NEGATIVE_SIGN_OUTPUT_4003
    BRz ZERO_4001
    
POSITIVE_SIGN_OUTPUT_4002
    ADD R1, R1, #0
    BRn NEGATIVE_SIGN_OUTPUT_4003
    BRp POSITIVE_SIGN_OUTPUT_4003
    BRz ZERO_TEST_4000

NEGATIVE_SIGN_OUTPUT_4003
    ADD R3, R3, #0
    BRp SKIP_ADDING_NEGATIVE_SIGN_4000
    LD R3, FLAG
    LEA R0, NEGATIVE_SIGN_4000		;load register zero with string for negative sign
	TRAP x22						;output the negative sign
SKIP_ADDING_NEGATIVE_SIGN_4000
	ADD R1, R1, #0					;reestablish register 2
	BRn NEGATIVE_NUMBER_4003

POSITIVE_SIGN_OUTPUT_4003
    ADD R3, R3, #0
    BRp SKIP_ADDING_POSITIVE_SIGN_4000
    LD R3, FLAG
    LEA R0, POSITIVE_SIGN_4000		;load register 0 with string for positive sign
	TRAP x22						;output the positive sign
SKIP_ADDING_POSITIVE_SIGN_4000
	ADD R1, R1, #0
    BRp POSITIVE_NUMBER_4003
    
NEGATIVE_SIGN_OUTPUT_4001			
    ADD R3, R3, #0
    BRp SKIP_ADDING_NEGATIVE_SIGN_4001
    LD R3, FLAG
	LEA R0, NEGATIVE_SIGN_4000		;load register zero with string for negative sign
	TRAP x22						;output the negative sign
SKIP_ADDING_NEGATIVE_SIGN_4001
	ADD R2, R2, #0					;reestablish register 2
	BRn NEGATIVE_NUMBER_4002

POSITIVE_SIGN_OUTPUT_4001
    ADD R3, R3, #0
    BRp SKIP_ADDING_POSITIVE_SIGN_4001
    LD R3, FLAG
	LEA R0, POSITIVE_SIGN_4000		;load register 0 with string for positive sign
	TRAP x22						;output the positive sign
SKIP_ADDING_POSITIVE_SIGN_4001
	ADD R2, R2, #0
    BRp POSITIVE_NUMBER_4002
    
CONTINUE_CODING_4002
	ADD R1, R1, #0					;restablish register 2
	BRz	ZERO_4001					;branch if register 2 is zero
	BRp	POSITIVE_NUMBER_4001		;branch if register 2 is positive
	BRn	NEGATIVE_NUMBER_4001		;branch if register 2 is negative

ZERO_4001
	LD R3, ASCII_CONVERSION_4000	;load register 3 with the ascii conversion
	ADD R0, R1, R3					;converts register 2 into an ascii character and loads into register 0
	TRAP x21						;outputs the zero
	ADD R1, R1, #0
	BRz CONTINUE_CODING_4003		;branch if register 2 is zero
    
POSITIVE_NUMBER_4001
	LD R6, PRINTING_OUT_3800		;loads register 6 with the memory address of PRINTING_OUT_3800
	JSRR R6							;jumps to the memory address in register 6
	ADD R1, R1, #0
	BRp CONTINUE_CODING_4003

POSITIVE_NUMBER_4003
    LD R6, PRINTING_OUT_3800
    JSRR R6
    BRp CONTINUE_CODING_4003
    
NEGATIVE_NUMBER_4003
    LD R6, PRINTING_OUT_3800
    JSRR R6
    ADD R1, R1, #0
    BRn CONTINUE_CODING_4003
    
POSITIVE_NUMBER_4002
    ADD R1, R2, #0
    LD R6, PRINTING_OUT_3800
    JSRR R6
    BRp CONTINUE_CODING_4003
	
NEGATIVE_NUMBER_4001			
	NOT R1, R1						;since the number is negative, take the two's complement to become positive
	ADD R1, R1, #1					
	LD R6, PRINTING_OUT_3800		;loads register 6 with the memory address of PRINTING_OUT_3800
	JSRR R6							;jumps to the memory address in register 6
	NOT R1, R1						;reverse the two's complement of the number in register 1
	ADD R1, R1, #1

NEGATIVE_NUMBER_4002
    ADD R1, R2, #0
    LD R6, PRINTING_OUT_3800
    JSRR R6
    
CONTINUE_CODING_4003
	LEA R0, EQUALS_SIGN_4000		;loads register zero with the string "="
	TRAP x22						;outputs the equal sign
	ADD R5, R5, #0					;establish register 5
	BRp OVERFLOW_ERROR_4000		;if register 5 is positive, branch to overflow 
	BRz CORRECT_NUMBER_4000			;if register 5 is zero, branch to correct number

OVERFLOW_ERROR_4000
	LEA R0, OVERFLOW_4000			;loads register 0 with the overflow message
	TRAP x22						;outputs the overflow message
	ADD R5, R5, #0					;establish register 5
	BRp END_OF_SUBROUTINE_4000		;branch to end of the subroutine is register 5 is positive
	
CORRECT_NUMBER_4000
	ADD R6, R1, #0					;move the value in regsiter 1 into register 6
	ADD R1, R4, #0					;move the value in register 4 into register 1
	ADD R4, R6, #0					;move the value in register 6 into register 4
	ADD R1, R1, #0					;reestablish register 1
	BRn NEGATIVE_RESULT_4000		;if register 1 is negative, branch to negative result
	BRp	POSITIVE_RESULT_4000		;if register 1 is positive, branch to positive result
	BRz	ZERO_RESULT_4000			;if register 1 is zero, branch to zero result

NEGATIVE_RESULT_4000
	LEA R0, NEGATIVE_SIGN_4000		;load register 0 with the negative sign string
	TRAP x22						;output the negative sign
	NOT R1, R1						;take the two's complement of the value in register 1
	ADD R1, R1, #1
	BRp LAST_STEP_4000
	
POSITIVE_RESULT_4000
	LEA R0, POSITIVE_SIGN_4000		;load register 0 with the positive sign string
	TRAP x22						;output the positive sign
	ADD R1, R1, #0					;reestablish register 1
	BRp LAST_STEP_4000				;if register 1 is positive then branch to last step
 
ZERO_RESULT_4000
 	LD R3, ASCII_CONVERSION_4000	;load register 3 with the ascii conversion					
	ADD R0, R3, R1					;convert the value of register 1 into an ascii character and transfer it to register 0
	TRAP x21						;output the ascii character which in this case is 0
	ADD R1, R1, #0					;reestablish register 1
	BRz END_OF_SUBROUTINE_4000		;branch to the end of the subroutine if register 1 is zero
	
LAST_STEP_4000
	LD R6, PRINTING_OUT_3800		;load register 6 with the memory address labeled PRINTING_OUT_3800
	JSRR R6							;jump to the memory address in register 6
	
END_OF_SUBROUTINE_4000
	LEA R0, NEW_LINE_4000			;load register 0 with the string for new line
	TRAP x22						;output the string for new line
    ;========
    ;RESTORE
    ;========
	LD R7, BACKUP_R7_4000
    LD R6, BACKUP_R6_4000
    LD R5, BACKUP_R5_4000
    LD R4, BACKUP_R4_4000
    LD R3, BACKUP_R3_4000
    LD R2, BACKUP_R2_4000
    LD R1, BACKUP_R1_4000
    LD R0, BACKUP_R0_4000
    ;=======
    ;RETURN
    ;=======
    RET
    
    ;================
    ;SUBROUTINE DATA
    ;================
	BACKUP_R7_4000			.BLKW		#1
	BACKUP_R6_4000			.BLKW		#1
	BACKUP_R5_4000			.BLKW		#1
	BACKUP_R4_4000			.BLKW		#1
	BACKUP_R3_4000			.BLKW		#1
	BACKUP_R2_4000			.BLKW		#1
	BACKUP_R1_4000			.BLKW		#1
	BACKUP_R0_4000			.BLKW		#1
	MULTIPLY_4000			.STRINGZ	" * "
	EQUALS_SIGN_4000		.STRINGZ	" = "
	POSITIVE_SIGN_4000		.STRINGZ	"+"
	NEGATIVE_SIGN_4000		.STRINGZ	"-"
	ASCII_CONVERSION_4000	.FILL		#48
	OVERFLOW_4000			.STRINGZ	" Overflow!"
	NEW_LINE_4000			.STRINGZ	"\n"
	PRINTING_OUT_3800		.FILL		x3800
	ZERO_VALUE_4000			.FILL		#0
    FLAG                    .FILL       #1
;===================================
;SUBROUTINE NAME: PRINTING_OUT_3800
;PARAMETER: REGISTER 1
;POSTCONDITION: THIS WILL PRINT OUT THE NUMBER WITHOUT ANY LEADING ZEROES.
;RETURN VALUE:N/A
;==================================
.ORIG x3800
	;========================
	;SUBROUTINE INSTRUCTIONS
	;========================
	ST R7, BACKUP_R7_3800
    ST R6, BACKUP_R6_3800
    ST R5, BACKUP_R5_3800
    ST R4, BACKUP_R4_3800
    ST R3, BACKUP_R3_3800
    ST R2, BACKUP_R2_3800
    ST R1, BACKUP_R1_3800
    ST R0, BACKUP_R0_3800
    ;==========
    ;ALGORITHM
    ;==========
    ADD R1, R1, #0
    BRn CONVERT_NUMBER_3800
    BRzp CONTINUE_SUBROUTINE_3800
    
CONVERT_NUMBER_3800
    NOT R1, R1
    ADD R1, R1, #1
    
CONTINUE_SUBROUTINE_3800
    LD R6, ZERO_3800				;load register 6 with the value #0
    LD R2, COUNTER_VALUE_3800		;load register 2 with the counter value #0
    LD R3, ASCII_CONVERSION_3800
    ADD R4, R1, #0					;REGISTER 4 HOLDS THE NEW NUMBER TO BE OUTPUTTED
    
    LD R5, TEN_THOUSAND_3800		;load register 5 with the value #10000
    NOT R5, R5						;take the two's complement of register 5
    ADD R5, R5, #1
    
    DO_WHILE_LOOP_3800				;DO_WHILE_LOOP OF TEN_THOUSANDS
    	ADD R4, R5, R4				;ADD #-10000 TO REGISTER 4
    	BRp INCREMENT_COUNTER_3800	;if register 4 is positive branch here
    	BRn	CONTINUE_LOOP_3800		;if register 4 is negative branch here
    	
INCREMENT_COUNTER_3800				;this branch will increment the counter
		ADD R2, R2, #1				;increment the value by one
			
CONTINUE_LOOP_3800					;this continues the loop
    	ADD R4, R4, #0
    	BRp DO_WHILE_LOOP_3800		;checks if REGISTER 4 IS negative or positive
    	
CONTINUE_CODING_3800				;this continues the code of the first loop
	LD R5, TEN_THOUSAND_3800		;loads register 5 with #10000
	ADD R4, R5, R4
	ADD R2, R2, #0
	BRz CONTINUE_THE_CODE_3800
	
PRINT_OUT_COUNTER_3800
	ADD R0, R3, R2
	TRAP x21
	LD R6, START_PRINTING_3800
	LD R2, COUNTER_VALUE_3800

CONTINUE_THE_CODE_3800				;
	LD R5, ONE_THOUSAND_3800
	NOT R5, R5
	ADD R5, R5, #1
	
    DO_WHILE_LOOP_3801
    	ADD R4, R5, R4
    	BRp INCREMENT_COUNTER_3801
    	BRn	CONTINUE_LOOP_3801
    	
INCREMENT_COUNTER_3801
		ADD R2, R2, #1
			
CONTINUE_LOOP_3801
		ADD R4, R4, #0
    	BRp DO_WHILE_LOOP_3801

CONTINUE_CODING_3801
	LD R5, ONE_THOUSAND_3800
	ADD R4, R5, R4
	ADD R6, R6, #0
	BRp PRINT_OUT_COUNTER_3801
	ADD R2, R2, #0
	BRz CONTINUE_THE_CODE_3801

PRINT_OUT_COUNTER_3801
	ADD R0, R3, R2
	TRAP x21
	LD R6, START_PRINTING_3800
	LD R2, COUNTER_VALUE_3800
	
CONTINUE_THE_CODE_3801					;
	LD R5, ONE_HUNDRED_3800
	NOT R5, R5
	ADD R5, R5, #1
	
    DO_WHILE_LOOP_3802
    	ADD R4, R5, R4
    	BRp INCREMENT_COUNTER_3802
    	BRn	CONTINUE_LOOP_3802
    	
INCREMENT_COUNTER_3802
		ADD R2, R2, #1
			
CONTINUE_LOOP_3802
		ADD R4, R4, #0
    	BRp DO_WHILE_LOOP_3802

CONTINUE_CODING_3802
	LD R5, ONE_HUNDRED_3800
	ADD R4, R5, R4
	ADD R6, R6, #0
	BRp PRINT_OUT_COUNTER_3802
	ADD R2, R2, #0
	BRz CONTINUE_THE_CODE_3802

PRINT_OUT_COUNTER_3802
	ADD R0, R3, R2
	TRAP x21
	LD R6, START_PRINTING_3800
	LD R2, COUNTER_VALUE_3800
		
CONTINUE_THE_CODE_3802					;
	LD R5, TENS_3800
	NOT R5, R5
	ADD R5, R5, #1
	
    DO_WHILE_LOOP_3803
    	ADD R4, R5, R4
		BRp INCREMENT_COUNTER_3803
    	BRn	CONTINUE_LOOP_3803
    	
INCREMENT_COUNTER_3803
		ADD R2, R2, #1
			
CONTINUE_LOOP_3803
		ADD R4, R4, #0
    	BRp DO_WHILE_LOOP_3803

CONTINUE_CODING_3803
	ADD R4, R4, #0
	BRz OUTPUT_VALUE_3800
	LD R5, TENS_3800
	ADD R4, R5, R4

OUTPUT_VALUE_3800
	ADD R6, R6, #0
	BRp PRINT_OUT_COUNTER_3803
	ADD R2, R2, #0
	BRz CONTINUE_THE_CODE_3803

PRINT_OUT_COUNTER_3803
	ADD R0, R3, R2
	TRAP x21
	LD R6, START_PRINTING_3800
	LD R2, COUNTER_VALUE_3800

CONTINUE_THE_CODE_3803					;
	ADD R0, R3, R4
	TRAP x21
    ;=========
    ;RESTORE
    ;=========
   	LD R7, BACKUP_R7_3800
    LD R6, BACKUP_R6_3800
    LD R5, BACKUP_R5_3800
    LD R4, BACKUP_R4_3800
    LD R3, BACKUP_R3_3800
    LD R2, BACKUP_R2_3800
    LD R1, BACKUP_R1_3800
    LD R0, BACKUP_R0_3800
    ;=======
    ;RETURN
    ;=======
    RET
    
    ;================
    ;SUBROUTINE DATA
    ;================
    BACKUP_R7_3800  	    .BLKW       #1
    BACKUP_R6_3800  	    .BLKW       #1
    BACKUP_R5_3800  	    .BLKW       #1
    BACKUP_R4_3800  	    .BLKW       #1
    BACKUP_R3_3800  	    .BLKW       #1
    BACKUP_R2_3800  	    .BLKW       #1
    BACKUP_R1_3800  	    .BLKW       #1
    BACKUP_R0_3800  	    .BLKW       #1
    COUNTER_VALUE_3800		.FILL		#0
    TEN_THOUSAND_3800		.FILL		#10000
    ONE_THOUSAND_3800		.FILL		#1000
    ONE_HUNDRED_3800		.FILL		#100
    TENS_3800				.FILL		#10
    ONES_3800				.FILL		#1
    ASCII_CONVERSION_3800	.FILL		#48
    START_PRINTING_3800		.FILL		#1
    ZERO_3800				.FILL		#0
;============================================
;SUBROUTINE NAME: CHECKING_REGISTER_6_4200
;PARAMETER: REGISTER 6
;POSTCONDITION: IF REGISTER 6 IS POSITIVE, SWAP THE NUMBERS, IF ZERO LEAVE NUMBERS AS IS
;RETURN VALUE: REGISTER 1 AND REGISTER 2
;=============================================
.ORIG x4200
	;========================
	;SUBROUTINE INSTRUCTIONS
	;========================
	ST R7, BACKUP_R7_4200
    ST R6, BACKUP_R6_4200
    ST R5, BACKUP_R5_4200
    ST R4, BACKUP_R4_4200
    ST R3, BACKUP_R3_4200
    ST R2, BACKUP_R2_4200
    ST R1, BACKUP_R1_4200
    ST R0, BACKUP_R0_4200
	;==========
	;ALGORITHM
	;==========
	ADD R6, R6, #0
	BRp SWAP_PLACES_4200
	BRz	END_OF_SUBROUTINE_4200

SWAP_PLACES_4200
	ADD R5, R2, #0
	ADD R4, R1, #0
	ADD R1, R5, #0
	ADD R2, R4, #0
	
END_OF_SUBROUTINE_4200	
	;========
	;RESTORE
	;========
	LD R7, BACKUP_R7_4200
    LD R6, BACKUP_R6_4200
    LD R5, BACKUP_R5_4200
    LD R4, BACKUP_R4_4200
    LD R3, BACKUP_R3_4200
    LD R0, BACKUP_R0_4200
    ;=======
    ;RETURN
    ;=======
    RET
    
    ;================
    ;SUBROUTINE DATA
    ;================
    BACKUP_R7_4200  	    .BLKW       #1
    BACKUP_R6_4200  	    .BLKW       #1
    BACKUP_R5_4200  	    .BLKW       #1
    BACKUP_R4_4200  	    .BLKW       #1
    BACKUP_R3_4200  	    .BLKW       #1
    BACKUP_R2_4200  	    .BLKW       #1
    BACKUP_R1_4200  	    .BLKW       #1
    BACKUP_R0_4200  	    .BLKW       #1
.END
