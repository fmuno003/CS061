;=================================================
; 
; Name: Munoz, Francisco
; Username: fmuno003	(fmuno003@ucr.edu)
;
; SID: 861174271 
; Assignment name: assn06
; Lab section: 021
; TA: Bryan Marsh
;
; I hereby certify that I have not receieved 
; assistance on this assignment, or used code,
; from ANY outside source other than the
; instruction team. 
;
;=================================================
.ORIG x3000			; Program begins here
	;=============
	;Instructions
	;=============
DO_WHILE_LOOP_3000
	LD R0, VALUE_RESET_3000
	LD R1, VALUE_RESET_3000
	LD R2, VALUE_RESET_3000
	LD R3, VALUE_RESET_3000
	LD R4, VALUE_RESET_3000
	LD R5, VALUE_RESET_3000
	LD R6, VALUE_RESET_3000
	LD R7, VALUE_RESET_3000

	LD R6, MENU_3200
	JSRR R6
	ADD R3, R3, #-1
	ADD R4, R3, R1
	BRz IF_STATEMENT_3000
	ADD R3, R3, #-1
	ADD R4, R3, R1
	BRz ELSE_IF_STATEMENT_3000
	ADD R3, R3, #-1
	ADD R4, R3, R1
	BRz ELSE_IF_STATEMENT_3001	
	ADD R3, R3, #-1
	ADD R4, R3, R1
	BRz ELSE_IF_STATEMENT_3002	
	ADD R3, R3, #-1
	ADD R4, R3, R1
	BRz ELSE_IF_STATEMENT_3003	
	ADD R3, R3, #-1
	ADD R4, R3, R1
	BRz ELSE_IF_STATEMENT_3004	
	ADD R3, R3, #-1
	ADD R4, R3, R1
	BRz ELSE_IF_STATEMENT_3005
	
IF_STATEMENT_3000
		LD R6, ALL_MACHINES_BUSY_3400
		JSRR R6
		IF_STATEMENT_3001
			ADD R2, R2, #-1
			BRz BUSY_3000
			BRn	FREE_3000
		BUSY_3000
			LEA R0, BUSY_MESSAGE_3000
			TRAP x22
			BRnzp GO_BACK_3000
		FREE_3000
			LEA R0, FREE_MESSAGE_3000
			TRAP x22
		GO_BACK_3000
		BRnzp DO_WHILE_LOOP_3000

ELSE_IF_STATEMENT_3000	
		LD R6, ALL_MACHINES_FREE_3600
		JSRR R6
		IF_STATEMENT_3002
			ADD R2, R2, #-1
			BRn	NOT_ALL_FREE_3000
			BRz	ALL_FREE_3000
		NOT_ALL_FREE_3000
			LEA R0, NOT_ALL_3000
			TRAP x22
			BRnzp GO_BACK_3001
		ALL_FREE_3000
			LEA R0, ALL_3000
			TRAP x22
		GO_BACK_3001
		BRnzp DO_WHILE_LOOP_3000

ELSE_IF_STATEMENT_3001
		LD R6, NUM_BUSY_MACHINES_3800
		JSRR R6
        
		LEA R0, BUSY_MACHINES_1
        TRAP x22
        LD R6, PRINT_NUMBER_4800
        JSRR R6
        LEA R0, BUSY_MACHINES_2
        TRAP x22
        
		BRnzp DO_WHILE_LOOP_3000
		
ELSE_IF_STATEMENT_3002
		LD R6, NUM_FREE_MACHINES_4000
		JSRR R6
        
        LEA R0, FREE_MACHINES_1
        TRAP x22
        LD R6, PRINT_NUMBER_4800
        JSRR R6
        LEA R0, FREE_MACHINES_2
        TRAP x22
        
		BRnzp DO_WHILE_LOOP_3000

ELSE_IF_STATEMENT_3003
        LD R6, GET_INPUT_4600
        JSRR R6
        ADD R3, R1, #0
        LD R6, MACHINE_STATUS_4200
		JSRR R6
        ADD R2, R2, #0
        BRz BUSY__MACHINE
        BRp FREE__MACHINE

BUSY__MACHINE
        LEA R0, MACHINE_3000
        TRAP x22
        ADD R2, R1, #0
        LD R6, PRINT_NUMBER_4800
        JSRR R6
        
        LEA R0, MACHINE_2_3000
        TRAP x22
        BRnzp GO_BACK_3003
        
FREE__MACHINE
        LEA R0, MACHINE_3001
        TRAP x22
        ADD R2, R1, #0
        LD R6, PRINT_NUMBER_4800
        JSRR R6
        LEA R0, MACHINE_2_3001
        TRAP x22
        
GO_BACK_3003
		BRnzp DO_WHILE_LOOP_3000
		
ELSE_IF_STATEMENT_3004
		LD R6, FIRST_FREE_4400
		JSRR R6
		
        ADD R2, R2, #0
        BRn NO_FREE_MACHINE
        BRzp FREE_MACHINE_AVAILABLE
        
    NO_FREE_MACHINE
        LEA R0, NO_MACHINE_AVAILABLE_
        TRAP x22
        BRnzp GO_BACK_3002
        
    FREE_MACHINE_AVAILABLE
        LEA R0, FREE_MACHINE
        TRAP x22
        
        LD R6, PRINT_NUMBER_4800
        JSRR R6
        
        LEA R0, NEWLINE
        TRAP x22
    GO_BACK_3002
		BRnzp DO_WHILE_LOOP_3000
		
	ELSE_IF_STATEMENT_3005
		LEA R0, GOODBYE_MESSAGE_3000
		TRAP x22
	HALT
	;=====	
	;Data
	;=====
	MENU_3200				.FILL		x3200
	ALL_MACHINES_BUSY_3400	.FILL		x3400
	ALL_MACHINES_FREE_3600	.FILL		x3600
	NUM_BUSY_MACHINES_3800	.FILL		x3800
	NUM_FREE_MACHINES_4000	.FILL		x4000
	MACHINE_STATUS_4200		.FILL		x4200
	FIRST_FREE_4400			.FILL		x4400
	GET_INPUT_4600			.FILL		x4600
	PRINT_NUMBER_4800		.FILL		x4800
	VALUE_RESET_3000		.FILL		#0
	BUSY_MESSAGE_3000		.STRINGZ	"All machines are busy\n"
	FREE_MESSAGE_3000		.STRINGZ	"Not all machines are busy\n"
	ALL_3000				.STRINGZ	"All machines are free\n"
	NOT_ALL_3000			.STRINGZ	"Not all machines are free\n"
    BUSY_MACHINES_1         .STRINGZ    "There are "
    BUSY_MACHINES_2         .STRINGZ    " busy machines\n"
    FREE_MACHINES_1         .STRINGZ    "There are "
    FREE_MACHINES_2         .STRINGZ    " free machines\n"
    NO_MACHINE_AVAILABLE_   .STRINGZ    "No machines are free\n"
    NEWLINE                 .STRINGZ    "\n"
    MACHINE_3000            .STRINGZ    "Machine "
    MACHINE_3001            .STRINGZ    "Machine "
    MACHINE_2_3000          .STRINGZ    " is busy\n"
    MACHINE_2_3001          .STRINGZ    " is free\n"
    GOODBYE_MESSAGE_3000	.STRINGZ	"Goodbye!\n"
    FREE_MACHINE            .STRINGZ    "The first free machine is number "
;=======================================================================================
; Subroutine: MENU_3200
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, allowed 
;					the user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7
; no other return value is possible
;=======================================================================================
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
DO_WHILE_LOOP_3200  
	  
    LD R6, MENU_STRING_ADDR
    JSRR R6
    LD R5, ASCII_CONVERSION_3200
    TRAP x20
    TRAP x21
    ADD R3, R0, #0
    ADD R4, R3, R5
    
    LEA R0, NEW_LINE_3200
    TRAP x22
    
    ADD R4, R4, #0
    BRz ERROR_MESSAGE_3200
    
    LD R6, NEGATIVE_SIGN_3200
    ADD R2, R6, R3
    BRz ERROR_MESSAGE_3200
    
    LD R6, NUMBER_CHECK_3200
    ADD R2, R6, R4
    BRzp ERROR_MESSAGE_3200
	BRn CONTINUE_3200
	
ERROR_MESSAGE_3200
	LEA R0, ERROR_MESSAGE_1
	TRAP x22
	BRnzp DO_WHILE_LOOP_3200
	
CONTINUE_3200
	ADD R1, R4, #0
    ;========
    ;RESTORE
    ;========
    LD R7, BACKUP_R7_3200
    LD R6, BACKUP_R6_3200
    LD R5, BACKUP_R5_3200
    LD R4, BACKUP_R4_3200
    LD R3, BACKUP_R3_3200
    LD R2, BACKUP_R2_3200
    LD R0, BACKUP_R0_3200
    ;========
    ;RETURN
    ;========
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
    NEGATIVE_SIGN_3200		.FILL		#-45
    NUMBER_CHECK_3200		.FILL		#-8
    NEW_LINE_3200			.STRINGZ	"\n"
	ERROR_MESSAGE_1			.STRINGZ 	"INVALID INPUT\n"
	MENU_STRING_ADDR 		.FILL 		x6000
	ASCII_CONVERSION_3200	.FILL		#-48

;==============================================================================================
; Subroutine: ALL_MACHINES_BUSY_3400
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy,    0 otherwise
;==============================================================================================
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
    ;===========
    ;ALGORITHM
    ;===========
    ADD R1, R1, #-1
    LD R3, ADDRESS_5000
    LDR R1, R3, #0
    LD R3, FOR_LOOP_COUNTER_3400            ;loads register with value 15 for 16 bits
    
    FOR_LOOP_3400           
		IF_STATEMENT_3400                   ;first if statement. checks for a 1 or 0
			ADD R1, R1, #0                  ;establishes register 1
			BRz MACHINES_IS_BUSY_3400      ;if register one is a zero, then not all machines are busy
			BRnp CONTINUE_CODE_3400         ;if register one is negative or positive, machines are busy
            
MACHINES_IS_BUSY_3400
	ADD R2, R2, #1                          ;loads register 2 with 0 to signify not all machines are busy
    BRnzp CONTINUE_CODE_3400            ;branch to end for loop
    
CONTINUE_CODE_3400
	ADD R1, R1, R1                          ;multiply register 1 by 2
	ADD R3, R3, #-1                         ;decrement the for loop counter by one
	
	BRzp FOR_LOOP_3400
	END_FOR_LOOP_3400
    
    LD R5, VALUE_15
    ADD R2, R5, R2
    BRn NOT_ALL_MACHINES_BUSY
    BRz ALL_MACHINES_BUSY

NOT_ALL_MACHINES_BUSY
    LD R2, VALUE_0
    BRz END_ROUTINE
    
ALL_MACHINES_BUSY
    LD R2, VALUE_1

END_ROUTINE
    ;========
    ;RESTORE
    ;========
    LD R7, BACKUP_R7_3400
    LD R6, BACKUP_R6_3400
    LD R5, BACKUP_R5_3400
    LD R4, BACKUP_R4_3400
    LD R3, BACKUP_R3_3400
    LD R1, BACKUP_R1_3400
    LD R0, BACKUP_R0_3400
    ;=======
    ;RETURN
    ;=======
    RET
    
    ;=================
    ;SUBROUTINE DATA
    ;=================
    BACKUP_R7_3400      	.BLKW       #1
    BACKUP_R6_3400      	.BLKW       #1
    BACKUP_R5_3400      	.BLKW       #1
    BACKUP_R4_3400      	.BLKW       #1
    BACKUP_R3_3400      	.BLKW       #1
    BACKUP_R2_3400      	.BLKW       #1
    BACKUP_R1_3400      	.BLKW       #1
    BACKUP_R0_3400	        .BLKW       #1
    FOR_LOOP_COUNTER_3400   .FILL       #15
    ADDRESS_5000            .FILL       x5000
    VALUE_15                .FILL       #-16
    VALUE_0                 .FILL       #0
    VALUE_1                 .FILL       #1
;==============================================================================================
; Subroutine: ALL_MACHINES_FREE_3600
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free,    0 otherwise
;==============================================================================================
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
    ;===========
    ;ALGORITHM
    ;===========
    LD R1, ZERO_VALUE_3600
    LD R3, MEMORY_ADDRESS_5000
    LDR R1, R3, #0
    LD R3, FOR_LOOP_COUNTER_3600            ;loads register with value 15 for 16 bits
    
    FOR_LOOP_3600           
		IF_STATEMENT_3600                   ;first if statement. checks for a 1 or 0
			ADD R1, R1, #0                  ;establishes register 1
			BRn MACHINES_ARE_FREE_3600      ;if register one is a zero, then not all machines are busy
			BRzp CONTINUE_CODE_3600         ;if register one is negative or positive, machines are busy
            
MACHINES_ARE_FREE_3600
	ADD R2, R2, #1                          ;loads register 2 with 0 to signify not all machines are free
    BRnzp CONTINUE_CODE_3600              ;branch to end for loop
    
CONTINUE_CODE_3600
	ADD R1, R1, R1                          ;multiply register 1 by 2
	ADD R3, R3, #-1                         ;decrement the for loop counter by one
	
	BRzp FOR_LOOP_3600
	END_FOR_LOOP_3600
    ADD R2, R2, #0                          ;if this instruction is reached, all machines are busy.

    LD R5, VALUE_15_3600
    ADD R2, R5, R2
    BRn NOT_ALL_MACHINES_FREE
    BRz ALL_MACHINES_FREE

NOT_ALL_MACHINES_FREE
    LD R2, VALUE_0_3600
    BRz DONE

ALL_MACHINES_FREE
    LD R2, VALUE_1_3600

DONE
    ;========
    ;RESTORE
    ;========
    LD R7, BACKUP_R7_3600
    LD R6, BACKUP_R6_3600
    LD R5, BACKUP_R5_3600
    LD R4, BACKUP_R4_3600
    LD R3, BACKUP_R3_3600
    LD R1, BACKUP_R1_3600
    LD R0, BACKUP_R0_3600
    ;=======
    ;RETURN
    ;=======
    RET
    
    ;=================
    ;SUBROUTINE DATA
    ;=================
    BACKUP_R7_3600      	.BLKW       #1
    BACKUP_R6_3600      	.BLKW       #1
    BACKUP_R5_3600      	.BLKW       #1
    BACKUP_R4_3600      	.BLKW       #1
    BACKUP_R3_3600      	.BLKW       #1
    BACKUP_R2_3600      	.BLKW       #1
    BACKUP_R1_3600      	.BLKW       #1
    BACKUP_R0_3600  	    .BLKW       #1
    FOR_LOOP_COUNTER_3600   .FILL       #15
    ZERO_VALUE_3600         .FILL       #0
    MEMORY_ADDRESS_5000     .FILL       x5000
    VALUE_15_3600           .FILL       #-16
    VALUE_0_3600            .FILL       #0
    VALUE_1_3600            .FILL       #1
;==========================================================================
; SUBROUTINE NAME: NUM_BUSY_MACHINES_3800
; PARAMETERS: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy
;==========================================================================
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
    LD R6, BUSYNESS_VECTOR
    LDR R1, R6, #0
    LD R5, COUNTER_VALUE_3800
    LD R2, FOR_LOOP_COUNTER_3800 
    
    FOR_LOOP_3800
		IF_STATEMENT_3800
			ADD R1, R1, #0
			BRn ADD_ONE_3800
			BRzp CONTINUE_CODE_3800
ADD_ONE_3800
	ADD R5, R5, #1

CONTINUE_CODE_3800	
	ADD R1, R1, R1	
	ADD R2, R2, #-1
	
	BRzp FOR_LOOP_3800
	END_FOR_LOOP_3800
    
	ADD R2, R5, #0
    NOT R5, R5
    ADD R5, R5, #1
    LD R4, BITS_OF_16
    ADD R2, R5, R4
    ;========
    ;RESTORE
    ;========
    LD R7, BACKUP_R7_3800
    LD R6, BACKUP_R6_3800
    LD R5, BACKUP_R5_3800
    LD R4, BACKUP_R4_3800
    LD R3, BACKUP_R3_3800
    LD R1, BACKUP_R1_3800
    LD R0, BACKUP_R0_3800
    ;=======
    ;RETURN
    ;=======
    RET
    
    ;================
    ;SUBROUTINE DATA
    ;================
    BACKUP_R7_3800      	.BLKW       #1
    BACKUP_R6_3800      	.BLKW       #1
    BACKUP_R5_3800      	.BLKW       #1
    BACKUP_R4_3800      	.BLKW       #1
    BACKUP_R3_3800      	.BLKW       #1
    BACKUP_R2_3800      	.BLKW       #1
    BACKUP_R1_3800      	.BLKW       #1
    BACKUP_R0_3800  	    .BLKW       #1
    COUNTER_VALUE_3800		.FILL		#0
    FOR_LOOP_COUNTER_3800	.FILL		#15
    BUSYNESS_VECTOR         .FILL       x5000
    BITS_OF_16              .FILL       #16
;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
;=========================================================================
;SUBROUTINE NAME: NUM_FREE_MACHINES_4000
;PARAMETERS: None
;Postcondition: The subroutine has returned the number of free machines
;Return Value (R2): The number of machines that are free 
;=========================================================================
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
    LD R6, BUSYNESS_5000
    LDR R1, R6, #0
    LD R5, COUNTER_VALUE_4000
    LD R2, FOR_LOOP_COUNTER_4000 
    
    FOR_LOOP_4000
		IF_STATEMENT_4000
			ADD R1, R1, #0
			BRn ADD_ONE_4000
			BRzp CONTINUE_CODE_4000
ADD_ONE_4000
	ADD R5, R5, #1

CONTINUE_CODE_4000	
	ADD R1, R1, R1	
	ADD R2, R2, #-1
	
	BRzp FOR_LOOP_4000
	END_FOR_LOOP_4000
    
    ADD R2, R5, #0
    ;========
    ;RESTORE
    ;========
    LD R7, BACKUP_R7_4000
    LD R6, BACKUP_R6_4000
    LD R5, BACKUP_R5_4000
    LD R4, BACKUP_R4_4000
    LD R3, BACKUP_R3_4000
    LD R1, BACKUP_R1_4000
    LD R0, BACKUP_R0_4000
    ;=======
    ;RETURN
    ;=======
    RET
    
    ;================
    ;SUBROUTINE DATA
    ;================
    BACKUP_R7_4000      	.BLKW       #1
    BACKUP_R6_4000      	.BLKW       #1
    BACKUP_R5_4000      	.BLKW       #1
    BACKUP_R4_4000      	.BLKW       #1
    BACKUP_R3_4000      	.BLKW       #1
    BACKUP_R2_4000      	.BLKW       #1
    BACKUP_R1_4000      	.BLKW       #1
    BACKUP_R0_4000  	    .BLKW       #1
    COUNTER_VALUE_4000		.FILL		#0
    FOR_LOOP_COUNTER_4000	.FILL		#15
	BITS_16_4000			.FILL		#16
    BUSYNESS_5000           .FILL       x5000
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------
;========================================================================
; SUBROUTINE NAME: MACHINE_STATUS_4200
; PAREMETERS: (R1) Which machine to check
; Postcondition: The subroutine has returned a value indicating whether 
;					the machine indicated by (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;========================================================================
.ORIG x4200
    ;=========================
    ;SUBROUTINE INSTRUCTIONS
    ;=========================
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
    ADD R3, R1, #0
    LD R6, BUSYNESS__5000
    LDR R1, R6, #0
    ADD R6, R1, #0
    FOR_LOOP_4200
		IF_STATEMENT_4200

            ADD R6, R6, R1	
            ADD R3, R3, #-1
	BRzp FOR_LOOP_4200
	END_FOR_LOOP_4200
    
    ADD R6, R6, #0
    BRnp ITS_FREE_4200
    BRz  ITS_BUSY_4200

ITS_FREE_4200
    LD R2, FREE_VALUE_4200
    BRnzp OVER_4200

ITS_BUSY_4200
    LD R2, BUSY_VALUE_4200

OVER_4200
	;========
	;RESTORE
	;========
    LD R7, BACKUP_R7_4200
    LD R6, BACKUP_R6_4200
    LD R5, BACKUP_R5_4200
    LD R4, BACKUP_R4_4200
    LD R3, BACKUP_R3_4200
    LD R1, BACKUP_R1_4200
    LD R0, BACKUP_R0_4200
    ;=======
    ;RETURN
    ;=======
    RET
    
    ;================
    ;SUBROUTINE DATA
    ;================
    BACKUP_R7_4200      .BLKW       #1
    BACKUP_R6_4200      .BLKW       #1
    BACKUP_R5_4200      .BLKW       #1
    BACKUP_R4_4200      .BLKW       #1
    BACKUP_R3_4200      .BLKW       #1
    BACKUP_R2_4200      .BLKW       #1
    BACKUP_R1_4200      .BLKW       #1
    BACKUP_R0_4200      .BLKW       #1
    BUSYNESS__5000      .FILL       x5000
    FREE_VALUE_4200     .FILL       #1
    BUSY_VALUE_4200     .FILL       #0
    BITS_OF_15          .FILL       #15
;================================================================================================
; SUBROUTINE NAME: FIRST_FREE_4400
; PARAMETERS: None
; Postcondition: The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R2): the number of the free machine
;================================================================================================
.ORIG x4400
	;=========================
    ;SUBROUTINE INSTRUCTIONS
    ;=========================
    ST R7, BACKUP_R7_4400
    ST R6, BACKUP_R6_4400
    ST R5, BACKUP_R5_4400
    ST R4, BACKUP_R4_4400
    ST R3, BACKUP_R3_4400
    ST R2, BACKUP_R2_4400
    ST R1, BACKUP_R1_4400
    ST R0, BACKUP_R0_4400
    ;==========
    ;ALGORITHM
    ;==========
    LD R6, BUSYNESS_MEMORY_5000
    LDR R1, R6, #0
    LD R2, FOR_LOOP_COUNTER_4400 
    
    FOR_LOOP_4400
		IF_STATEMENT_4400
			ADD R1, R1, #0
			BRn ADD_ONE_4400
			BRzp CONTINUE_CODE_4400
ADD_ONE_4400
    ADD R2, R2, #0
    BRnzp END_FOR_LOOP_4400

CONTINUE_CODE_4400	
	ADD R1, R1, R1	
	ADD R2, R2, #-1
	
	BRzp FOR_LOOP_4400
    ADD R2, R2, #-10
	END_FOR_LOOP_4400
    NOT R2, R2
    ADD R2, R2, #1
    LD R6, BITS_OF_15_
    ADD R2, R6, R2
	;========
	;RESTORE
	;========
    LD R7, BACKUP_R7_4400
    LD R6, BACKUP_R6_4400
    LD R5, BACKUP_R5_4400
    LD R4, BACKUP_R4_4400
    LD R3, BACKUP_R3_4400
    LD R1, BACKUP_R1_4400
    LD R0, BACKUP_R0_4400
    ;=======
    ;RETURN
    ;=======
    RET
    
    ;================
    ;SUBROUTINE DATA
    ;================
    BACKUP_R7_4400          .BLKW       #1
    BACKUP_R6_4400          .BLKW       #1
    BACKUP_R5_4400          .BLKW       #1
    BACKUP_R4_4400          .BLKW       #1
    BACKUP_R3_4400          .BLKW       #1
    BACKUP_R2_4400          .BLKW       #1
    BACKUP_R1_4400          .BLKW       #1
    BACKUP_R0_4400          .BLKW       #1
	FOR_LOOP_COUNTER_4400   .FILL       #15
    BITS_OF_15_             .FILL       #15
    BUSYNESS_MEMORY_5000    .FILL       x5000
;====================================================================================
; SUBROUTINE NAME: PRINT_NUMBER_4800
; PARAMETERS: REGISTER 2
; Postcondition: The subroutine prints the number that is in 
; RETURN VALUE: NONE
; NOTE: This subroutine should be the same as the one that you did in assignment 5
;	to print the number to the user WITHOUT leading 0's and DOES NOT output the '+' 
;	for positive numbers.
;====================================================================================
.ORIG x4800
	;=========================
    ;SUBROUTINE INSTRUCTIONS
    ;=========================
    ST R7, BACKUP_R7_4800
    ST R6, BACKUP_R6_4800
    ST R5, BACKUP_R5_4800
    ST R4, BACKUP_R4_4800
    ST R3, BACKUP_R3_4800
    ST R2, BACKUP_R2_4800
    ST R1, BACKUP_R1_4800
    ST R0, BACKUP_R0_4800
    ;==========
    ;ALGORITHM
    ;==========
    ADD R4, R2, #0
    LD R6, ZERO_4800				;load register 6 with the value #0
    LD R2, COUNTER_VALUE_4800		;load register 2 with the counter value #0
    LD R3, ASCII_CONVERSION_4800
    
	LD R5, TENS_4800
	NOT R5, R5
	ADD R5, R5, #1
	
    DO_WHILE_LOOP_4800
    	ADD R4, R5, R4
		BRp INCREMENT_COUNTER_4800
    	BRn	CONTINUE_LOOP_4800
    	
INCREMENT_COUNTER_4800
		ADD R2, R2, #1
			
CONTINUE_LOOP_4800
		ADD R4, R4, #0
    	BRp DO_WHILE_LOOP_4800

CONTINUE_CODING_4800
	ADD R4, R4, #0
	BRz OUTPUT_VALUE_4800
	LD R5, TENS_4800
	ADD R4, R5, R4

OUTPUT_VALUE_4800
	ADD R6, R6, #0
	BRp PRINT_OUT_COUNTER_4800
	ADD R2, R2, #0
	BRz CONTINUE_THE_CODE_4800

PRINT_OUT_COUNTER_4800
	ADD R0, R3, R2
	TRAP x21
	LD R2, COUNTER_VALUE_4800

CONTINUE_THE_CODE_4800					
	ADD R0, R3, R4
	TRAP x21
	;========
	;RESTORE
	;========
    LD R7, BACKUP_R7_4800
    LD R6, BACKUP_R6_4800
    LD R5, BACKUP_R5_4800
    LD R4, BACKUP_R4_4800
    LD R3, BACKUP_R3_4800
    LD R2, BACKUP_R2_4800
    LD R1, BACKUP_R1_4800
    LD R0, BACKUP_R0_4800
    ;=======
    ;RETURN
    ;=======
    RET
    
    ;================
    ;SUBROUTINE DATA
    ;================
    BACKUP_R7_4800  	    .BLKW       #1
    BACKUP_R6_4800  	    .BLKW       #1
    BACKUP_R5_4800  	    .BLKW       #1
    BACKUP_R4_4800  	    .BLKW       #1
    BACKUP_R3_4800  	    .BLKW       #1
    BACKUP_R2_4800  	    .BLKW       #1
    BACKUP_R1_4800  	    .BLKW       #1
    BACKUP_R0_4800  	    .BLKW       #1
    ZERO_4800				.FILL		#0
    TENS_4800				.FILL		#10
    COUNTER_VALUE_4800		.FILL		#0
    ASCII_CONVERSION_4800	.FILL		#48
    
;------------------------------------------------------------------------------------------------------------------------------------------------
;==========================================
;SUBROUTINE NAME: GET_INPUT_4600
;PARAMETER: NONE
;POSTCONDITON: The subroutine get up to a 5 digit input from the user within the range [-32768,32767]
;RETURN VALUE: The value of the constructed input (R1)
;==========================================
.ORIG x4600
	;========================
	;SUBROUTINE INSTRUCTIONS
	;========================
	ST R7, BACKUP_R7_4600
    ST R6, BACKUP_R6_4600
    ST R5, BACKUP_R5_4600
    ST R4, BACKUP_R4_4600
    ST R3, BACKUP_R3_4600
    ST R2, BACKUP_R2_4600
    ST R1, BACKUP_R1_4600
    ST R0, BACKUP_R0_4600
    ;==========
    ;ALGORITHM
    ;==========
    LD R6, VALUE_0_4600
DO_WHILE_LOOP_4600
	LEA R0, PROMPT_MESSAGE_4600
	TRAP x22
    
BACK_TO_HERE_4600	
	TRAP x20						;Asks the user for input
	LD R5, ASCII_VALUE_9_4600		;this the ascii value for 9.
	ADD R4, R5, R0					;if register 5 is subtracted from register 0, it is stored in register 4
	BRp ERROR_4600					;if the result is positive, proceed to error message
	
	LD R5, ASCII_VALUE_0_4600       ; ascii value of 0
	ADD R4, R5, R0                  ; register 4 is location of R5 - R0
    BRz ZERO_4600
    
    LD R5, ENTER_ASCII_4600
    ADD R4, R0, R5
    LD R5, NEGATIVE_SIGN
    ADD R4, R0, R5
    BRz NEGATIVE
    
    ADD R0, R0, #0
    BRp CONTINUE_4600
    
NEGATIVE
    LD R6, VALUE_1_4600
    TRAP x21
    BRnzp BACK_TO_HERE_4600
    
ZERO_4600
    ADD R6, R6, #1
    ADD R4, R6, #-2
    BRz DISPLAY_CHARACTER
    BRnp BACK_TO_HERE_4600
DISPLAY_CHARACTER
    TRAP x21
    LD R5, ASCII_CONVERSION
    ADD R1, R0, R5
    BRnzp CONTINUE_4601

ERROR_4600
    ADD R6, R6, #-1
    TRAP x21
	LEA R0, NEW_LINE_4600
	TRAP x22
	LEA R0, ERROR_MESSAGE_2
	TRAP x22
	BRnzp DO_WHILE_LOOP_4600
	
CONTINUE_4600
	TRAP x21						;echo the user's input
    LD R5, ASCII_CONVERSION
	ADD R1, R0, R5
    TRAP x20
    TRAP x21
    LD R5, ENTER_ASCII_4600
    ADD R4, R0, R5
    BRz STOP_TAKING_INPUTS_4600
    
    LD R5, ENTER_ASCII_4600
    LD R2, VALUE_1_4600
    ADD R2, R2, #-1
    FOR_LOOP_4600
        ADD R2, R2, R1
        ADD R5, R5, #1
        BRn FOR_LOOP_4600
        END_FOR_LOOP_4600
    LD R5, ASCII_CONVERSION
    ADD R0, R0, R5
    ADD R1, R0, R2
    LD R5, MAXIMUM_NUMBER_4600
    ADD R2, R1, R5
    BRnz CONTINUE_4601
    BRp ERROR_4600
    
CONTINUE_4601

    
STOP_TAKING_INPUTS_4600
    ADD R6, R6, #0
    BRp ERROR_4600
    LEA R0, NEW_LINE_4600
    TRAP x22
	;========
	;RESTORE
	;========
    LD R7, BACKUP_R7_4600
    LD R6, BACKUP_R6_4600
    LD R5, BACKUP_R5_4600
    LD R4, BACKUP_R4_4600
    LD R3, BACKUP_R3_4600
    LD R2, BACKUP_R2_4600
    LD R0, BACKUP_R0_4600
    ;=======
    ;RETURN
    ;=======
    RET
    
    ;================
    ;SUBROUTINE DATA
    ;================
    BACKUP_R7_4600      .BLKW       #1
    BACKUP_R6_4600      .BLKW       #1
    BACKUP_R5_4600      .BLKW       #1
    BACKUP_R4_4600      .BLKW       #1
    BACKUP_R3_4600      .BLKW       #1
    BACKUP_R2_4600      .BLKW       #1
    BACKUP_R1_4600      .BLKW       #1
    BACKUP_R0_4600      .BLKW       #1
    PROMPT_MESSAGE_4600	.STRINGZ	"Enter which machine you want the status of (0 - 15), followed by ENTER: "
    ASCII_VALUE_9_4600	.FILL		#-57
    ERROR_MESSAGE_2 	.STRINGZ 	"ERROR INVALID INPUT\n"
    NEW_LINE_4600		.STRINGZ	"\n"
    ASCII_VALUE_0_4600	.FILL		#-48
    ENTER_ASCII_4600    .FILL       #-10
    ASCII_CONVERSION    .FILL       #-48
    MAXIMUM_NUMBER_4600 .FILL       #-15
    NEGATIVE_SIGN       .FILL       #-45
    VALUE_1_4600        .FILL       #1
    VALUE_0_4600        .FILL       #0
;-----------------------------------------------------------------------------------------------------------------------------------------------    
.ORIG x5000						; Remote data
	BUSYNESS .FILL xABCD	; <----!!!VALUE FOR BUSYNESS VECTOR!!!
;-----------------------------------------------------------------------------------------------------------------------------------------------
;===============================================
;SUBROUTINE NAME: MENU_STRING_ADDR_6000
;PARAMETER: NONE
;POSTCONDITION: WILL PRINT OUT MENU AT STARTUP
;RETURN VALUE: NONE
;===============================================
.ORIG x6000
	;=========================
	;SUBROUTINE INSTRUCTIONS
	;=========================
	ST R7, BACKUP_R7_6000
	ST R0, BACKUP_R0_6000
	;==========
	;ALGORITHM
	;==========
	LEA R0, MENUSTRING
	TRAP x22
	;========
	;RESTORE
	;========
	LD R7, BACKUP_R7_6000
	LD R0, BACKUP_R0_6000
	;========
	;RETURN
	;========
	RET
	;=================
	;SUUBROUTINE DATA
	;=================
	BACKUP_R7_6000	.BLKW		#1
	BACKUP_R0_6000	.BLKW		#1
	MENUSTRING 		.STRINGZ 	"**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"
	
	
	;===============		
	;END of PROGRAM
	;===============
.END
