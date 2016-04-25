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
	ADD R5, R5, #0
	BRp COMPLETELY_DONE
	LEA R0, NEWLINE___
	TRAP x22
	LD R6, SECOND_MENU_6000
	JSRR R6
	STR R1, R2, #0

COMPLETELY_DONE
	HALT
    ;=====
    ;DATA
    ;=====
    SUB_STACK_PUSH_3200		.FILL		x3200
    ARRAY_STACK_4000		.FILL		x4000
    TOP_POINTER_4000		.FILL		x4000
    PROMPT_MESSAGE			.STRINGZ	"Please input a number (single digits only). Press ENTER when finished:\n"
    CAPACITY_MESSAGE		.STRINGZ	"Please enter a capacity for the stack (single digit only):\n"
    NEWLINE					.STRINGZ	"\n"
    ASCII_CONVERSION		.FILL		#-48
    ENTER_VALUE				.FILL		#-10
    ASCII_CONVERSION_2		.FILL		#48
    SECOND_MENU_6000		.FILL		x6000
    NEWLINE___				.STRINGZ	"\n"
;======================================
;SUBROUTINE NAME: SUB_STACK_PUSH_3200
;PARAMETER:
;POSTCONDITION:
;RETURN VALUE:
;======================================
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
ARRAY_STACK		.BLKW #



;===================================
;SUBROUTINE NAME: SECOND_MENU_6000
;PARAMETER:
;POSTCONDITION:
;RETURN VALUE:
;===================================
.ORIG x6000
	;========================
	;SUBROUTINE INSTRUCTIONS
	;========================
	ST R7, BACKUP_R7_6000
    ST R6, BACKUP_R6_6000
    ST R5, BACKUP_R5_6000
    ST R4, BACKUP_R4_6000
    ST R3, BACKUP_R3_6000
    ST R2, BACKUP_R2_6000
    ST R1, BACKUP_R1_6000
    ST R0, BACKUP_R0_6000
    ;==========
    ;ALGORITHM
    ;==========
    LD R4, ASCII_CONVERSION__
	LDR R1, R2, #-1
	ADD R1, R4, R1
	LDR R3, R2, #-2
	ADD R2, R3, #0
	ADD R2, R4, R2
	LD R6, MULTIPLY_NUMBER_3400
	JSRR R6
	
	ADD R1, R4, #0
	LD R6, PRINTING_OUT_3800
	JSRR R6
	
	LEA R0, ___NEWLINE
	TRAP x22
	;========
	;RESTORE
	;========
	LD R7, BACKUP_R7_6000
    LD R6, BACKUP_R6_6000
    LD R5, BACKUP_R5_6000
    LD R4, BACKUP_R4_6000
    LD R3, BACKUP_R3_6000
    LD R2, BACKUP_R2_6000
    LD R0, BACKUP_R0_6000
	;=======
	;RETURN
	;=======
	RET
	;================
	;SUBROUTINE DATA
	;================
	BACKUP_R7_6000      .BLKW       #1
    BACKUP_R6_6000      .BLKW       #1
    BACKUP_R5_6000      .BLKW       #1
    BACKUP_R4_6000      .BLKW       #1
    BACKUP_R3_6000      .BLKW       #1
    BACKUP_R2_6000      .BLKW       #1
    BACKUP_R1_6000      .BLKW       #1
    BACKUP_R0_6000      .BLKW       #1
	MULTIPLY_NUMBER_3400.FILL		x3400
	PRINTING_OUT_3800	.FILL		x3800
	ASCII_CONVERSION__	.FILL		#-48
	___NEWLINE			.STRINGZ	"\n"


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
	ADD R4, R2, #0
	BRz	ZERO_3400
	ADD R3, R1, #0                  ;moves what is in register 1 into register 3
	LD R1, DEC_0_3400
	ADD R3, R3, #0
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







.END
