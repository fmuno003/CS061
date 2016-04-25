;=================================================
; Name: Munoz, Francisco
; Username: fmuno003    (fmuno003@ucr.edu)
; 
; Lab: LAB 05
; Lab section: 021
; TA: Bryan Marsh
; 
;=================================================
.ORIG x3000
    ;=============
    ;Instructions
    ;=============
    LD R1, DEC_9
    LD R2, MEMORY_ARRAY
    LD R3, DEC_1
    STR R3, R2, #0
    LD R5, SUB_PRINT_BINARY_3400
    
    FOR_LOOP
        ADD R3, R3, R3
        JSRR R5
        ADD R2, R2, #1
        STR R3, R2, #0
        ADD R1, R1, #-1
        BRzp FOR_LOOP
        END_FOR_LOOP
    
    
    
    
    HALT
    
    ;======
    ;Data
    ;======
    SUB_PRINT_BINARY_3400       .FILL       x3400
    DEC_9                       .FILL       #9
    NEW_LINE                    .STRINGZ    "\n"
    BIT_ONE                     .STRINGZ    "1"
    BIT_ZERO                    .STRINGZ    "0"
    MEMORY_ARRAY                .FILL       x4000
    DEC_1                       .FILL       #1
    
.ORIG x4000
    .BLKW   #10
    

;========================
;SUBROUTINE: PRINT_BINARY_3400
;PARAMETER:
;POSTCONDITION:
;RETURN VALUE: NONE
;========================
.ORIG x3200
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
    LD R6, DEC_1_3400
	LD R5, DEC_1_3400
	LD R2, DEC_15_3400
	LD R3, DEC_9_3400
	LD R4, COUNTER_3_3400
	LD R1, DEC_1_3400
FOR_LOOP_3400
    IF_STATEMENT5
	ADD R5, R5, #0
	BRnzp FOR_LOOP_3401
	FOR_LOOP_3401
		IF_STATEMENT
			ADD R6, R6, #0
			BRn PRINT_ONE_3400
			BRzp PRINT_ZERO_3400
		PRINT_ONE_3400
		LEA R0, BIT_ONE_3400
		TRAP x22
		ADD R6, R6, #0
		BRn CONTINUE_CODE

		PRINT_ZERO_3400
		LEA R0, BIT_ZERO_3400
		TRAP x22
	
		CONTINUE_CODE
			ADD R2, R2, #-1
			ADD R4, R4, #-1
		IF_STATEMENT2
			ADD R4, R4, #0
			BRn APPLY_SPACE
			BRzp DO_NOT_APPLY_SPACE
			
		APPLY_SPACE
			ADD R2, R2, #0
			BRn DO_NOT_APPLY_SPACE
						
			LEA R0, NEW_SPACE_3400
			TRAP x22
			LD R4, COUNTER_3_3400
			END_IF_STATEMENT1
			
		DO_NOT_APPLY_SPACE
			END_IF_STATEMENT2
			
		ADD R6, R6, R6
		ADD R2, R2, #0
		BRzp FOR_LOOP_3401
		END_FOR_LOOP_3401
		
		LEA R0, NEW_LINE_3400
		TRAP x22
	LD R2, DEC_15_3400
	ADD R1, R1, R1
	ADD R6, R1, R6
	LD R4, COUNTER_3_3400
	ADD R5, R5, R5
	ADD R3, R3, #-1
	BRzp FOR_LOOP_3400
	END_FOR_LOOP_3400
    HALT
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
    BACKUP_R7_3400      .BLKW   #1
    BACKUP_R6_3400      .BLKW   #1
    BACKUP_R5_3400      .BLKW   #1
    BACKUP_R4_3400      .BLKW   #1
    BACKUP_R3_3400      .BLKW   #1
    BACKUP_R2_3400      .BLKW   #1
    BACKUP_R1_3400      .BLKW   #1
    BACKUP_R0_3400      .BLKW   #1
    DEC_1_3400          .FILL   #1
    DEC_15_3400         .FILL   #15
    DEC_9_3400          .FILL   #9
    COUNTER_3_3400      .FILL   #3
    NEW_LINE_3400        .STRINGZ    "\n"
    NEW_SPACE_3400       .STRINGZ    " "
    BIT_ONE_3400        .STRINGZ    "1"
    BIT_ZERO_3400       .STRINGZ    "0"
    
.end
