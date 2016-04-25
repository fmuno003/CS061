;=================================================
; 
; Name: Munoz, Francisco
; Username: fmuno003	(fmuno003@ucr.edu)
;
; SID: 861174271
; Assignment name: assn 03
; Lab section: 021
; TA: Bryan Marsh
;
; I hereby certify that I have not received 
; assistance on this assignment, or used code,
; from ANY outside source other than the
; instruction team. 
;
;=================================================
.ORIG x3000			    				; Program begins here
	;-------------
    ;Instructions
    ;-------------
    LD R6, Convert_addr						; R6 <-- Address pointer for Convert
    LDR R1, R6, #0						; R1 <-- VARIABLE Convert 
   	;-------------------------------
   	;INSERT CODE STARTING FROM HERE
    ;-------------------------------
	LD R2, DEC_15
	LD R3, COUNTER_3
	
	FOR_LOOP
		IF_STATEMENT
			ADD R1, R1, #0
			BRn PRINT_ONE
			BRzp PRINT_ZERO

PRINT_ONE
	LEA R0, BIT_ONE
	TRAP x22
	ADD R1,R1, #0
	BRn CONTINUE_CODE


PRINT_ZERO
	LEA R0, BIT_ZERO
	TRAP x22

CONTINUE_CODE		
	ADD R1, R1, R1	
	ADD R2, R2, #-1
	ADD R3, R3, #-1
		IF_STATEMENT2
			ADD R3, R3, #0
			BRn APPLY_SPACE
			BRzp DO_NOT_APPLY_SPACE
			
		APPLY_SPACE
			ADD R2, R2, #0
			BRn DO_NOT_APPLY_SPACE
						
			LEA R0, NEW_SPACE
			TRAP x22
			LD R3, COUNTER_3
			END_IF_STATEMENT1
			
		DO_NOT_APPLY_SPACE
			END_IF_STATEMENT2
	
	ADD R2, R2, #0
	
	BRzp FOR_LOOP
	END_FOR_LOOP

	LEA R0, NEW_LETTER
	TRAP x22
	
	LEA R0, NEW_LINE
	TRAP x22
	
    HALT
    ;---------------	
    ;Data
    ;---------------
	Convert_addr    .FILL		x5000	    	; The address of where to find the data
	DEC_15			.FILL		#15
	COUNTER_3		.FILL		#3
	NEW_LINE		.STRINGZ	"\n"
	NEW_SPACE		.STRINGZ	" "
	BIT_ZERO		.STRINGZ	"0"
	BIT_ONE			.STRINGZ	"1"
	NEW_LETTER		.STRINGZ	"a"
	
    .ORIG x5000			    			; Remote data
	Convert         .FILL xABCD			; <----!!!NUMBER TO BE CONVERTED TO BINARY!!!
    ;---------------	
    ;END of PROGRAM
    ;---------------	
.END
