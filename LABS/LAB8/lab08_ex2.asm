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
    LD R6, SUB_PRINT_OPCODES_3200
    JSRR R6
    
    HALT
    ;=====
    ;DATA
    ;=====
    SUB_PRINT_OPCODES_3200      .FILL       x3200
;=================================================================================
; SUBROUTINE NAME: SUB_PRINT_OPCODES_3200
; PARAMETERS: None
; POSTCONDITION: The subroutine has printed out a list of every LC3 instruction
; and corresponding opcode in the following format:
; ADD = 0001
; AND = 0101
; BR = 0000
; ...
; RETURN VALUE: None
;==================================================================================
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
    LD R1, ARRAY_ADDRESS
    LD R2, OPCODE_ADDRESS
    
    ADD R0, R2, #0
    TRAP x22
    LEA R0, EQUALS_SIGN
    TRAP x22
    LDR R3, R1, #0
    LD R6, MEMORY_ADDRESS
    JSRR R6
    ADD R1, R1, #1
    
    ADD R2, R2, #4
    ADD R0, R2, #0
    TRAP x22
    LEA R0, EQUALS_SIGN
    TRAP x22
    LDR R3, R1, #0
    LD R6, MEMORY_ADDRESS
    JSRR R6
    ADD R1, R1, #1
    
    ADD R2, R2, #4
    ADD R0, R2, #0
    TRAP x22
    LEA R0, EQUALS_SIGN
    TRAP x22
    LDR R3, R1, #0
    LD R6, MEMORY_ADDRESS
    JSRR R6
    ADD R1, R1, #1
    
    ADD R2, R2, #3
    ADD R0, R2, #0
    TRAP x22
    LEA R0, EQUALS_SIGN
    TRAP x22
    LDR R3, R1, #0
    LD R6, MEMORY_ADDRESS
    JSRR R6
    ADD R1, R1, #1
    
    ADD R2, R2, #4
    ADD R0, R2, #0
    TRAP x22
    LEA R0, EQUALS_SIGN
    TRAP x22
    LDR R3, R1, #0
    LD R6, MEMORY_ADDRESS
    JSRR R6
    ADD R1, R1, #1
    
    ADD R2, R2, #4
    ADD R0, R2, #0
    TRAP x22
    LEA R0, EQUALS_SIGN
    TRAP x22
    LDR R3, R1, #0
    LD R6, MEMORY_ADDRESS
    JSRR R6
    ADD R1, R1, #1
    
    ADD R2, R2, #3
    ADD R0, R2, #0
    TRAP x22
    LEA R0, EQUALS_SIGN
    TRAP x22
    LDR R3, R1, #0
    LD R6, MEMORY_ADDRESS
    JSRR R6
    ADD R1, R1, #1
    
    ADD R2, R2, #4
    ADD R0, R2, #0
    TRAP x22
    LEA R0, EQUALS_SIGN
    TRAP x22
    LDR R3, R1, #0
    LD R6, MEMORY_ADDRESS
    JSRR R6
    ADD R1, R1, #1
    
    ADD R2, R2, #4
    ADD R0, R2, #0
    TRAP x22
    LEA R0, EQUALS_SIGN
    TRAP x22
    LDR R3, R1, #0
    LD R6, MEMORY_ADDRESS
    JSRR R6
    ADD R1, R1, #1
    
    ADD R2, R2, #4
    ADD R0, R2, #0
    TRAP x22
    LEA R0, EQUALS_SIGN
    TRAP x22
    LDR R3, R1, #0
    LD R6, MEMORY_ADDRESS
    JSRR R6
    ADD R1, R1, #1
    
    ADD R2, R2, #4
    ADD R0, R2, #0
    TRAP x22
    LEA R0, EQUALS_SIGN
    TRAP x22
    LDR R3, R1, #0
    LD R6, MEMORY_ADDRESS
    JSRR R6
    ADD R1, R1, #1
    
    ADD R2, R2, #4
    ADD R0, R2, #0
    TRAP x22
    LEA R0, EQUALS_SIGN
    TRAP x22
    LDR R3, R1, #0
    LD R6, MEMORY_ADDRESS
    JSRR R6
    ADD R1, R1, #1
    
    ADD R2, R2, #3
    ADD R0, R2, #0
    TRAP x22
    LEA R0, EQUALS_SIGN
    TRAP x22
    LDR R3, R1, #0
    LD R6, MEMORY_ADDRESS
    JSRR R6
    ADD R1, R1, #1
    
    ADD R2, R2, #4
    ADD R0, R2, #0
    TRAP x22
    LEA R0, EQUALS_SIGN
    TRAP x22
    LDR R3, R1, #0
    LD R6, MEMORY_ADDRESS
    JSRR R6
    ADD R1, R1, #1
    
    ADD R2, R2, #4
    ADD R0, R2, #0
    TRAP x22
    LEA R0, EQUALS_SIGN
    TRAP x22
    LDR R3, R1, #0
    LD R6, MEMORY_ADDRESS
    JSRR R6
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
    ARRAY_ADDRESS       .FILL       x4000
    OPCODE_ADDRESS      .FILL       x4200
    EQUALS_SIGN         .STRINGZ    " = "
    MEMORY_ADDRESS      .FILL       x3400
    ARRAY_COUNTER_15    .FILL       #15
    MEMORY_ADDRESS_3600 .FILL       x3600
;=================================================================================
; Test Harness for SUB_PRINT_OPCODES subroutine:
; (1) Call SUB_PRINT_OPCODES subroutine
;==================================================================================
.ORIG x3400
	;=========================
    ;SUBROUTINE INSTRUCTIONS
    ;=========================
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
    ADD R1, R3, #0
    LD R2, DEC_15
	LD R6, DEC_3
	FOR_LOOP
		IF_STATEMENT
            FOR_LOOP_3000
            
                ADD R1, R1, R1
                
                ADD R2, R2, #-1
                BRp FOR_LOOP_3000
CONTINUE
            ADD R1, R1, #0
            BRn PRINT_ONE
			BRzp PRINT_ZERO

PRINT_ONE
	LEA R0, BIT_ONE
	TRAP x22
	ADD R1, R1, #0
	BRn CONTINUE_CODE


PRINT_ZERO
	LEA R0, BIT_ZERO
	TRAP x22

CONTINUE_CODE		
	ADD R1, R1, R1	
	ADD R6, R6, #-1
    
	BRzp CONTINUE
	END_FOR_LOOP

	
	LEA R0, NEW_LINE
	TRAP x22
    ;========
    ;RESTORE
    ;========
    LD R7, BACKUP_R7_3400
    LD R6, BACKUP_R6_3400
    LD R5, BACKUP_R5_3400
    LD R4, BACKUP_R4_3400
    LD R3, BACKUP_R3_3400
    LD R2, BACKUP_R2_3400
    LD R1, BACKUP_R1_3400
    
    ;=======
    ;RETURN
    ;=======
    RET
    
    ;================
    ;SUBROTUINE DATA
    ;================
    BACKUP_R7_3400      .BLKW       #1
    BACKUP_R6_3400      .BLKW       #1
    BACKUP_R5_3400      .BLKW       #1
    BACKUP_R4_3400      .BLKW       #1
    BACKUP_R3_3400      .BLKW       #1
    BACKUP_R2_3400      .BLKW       #1
    BACKUP_R1_3400      .BLKW       #1
    BACKUP_R0_3400      .BLKW       #1
    DEC_15              .FILL       #12
    DEC_3               .FILL       #3
    BIT_ZERO            .STRINGZ    "0"
    BIT_ONE             .STRINGZ    "1"
    NEW_LINE            .STRINGZ    "\n"

.ORIG x4000
    .FILL       #1
    .FILL       #5
    .FILL       #0
    .FILL       #12
    .FILL       #4
    .FILL       #2
    .FILL       #10
    .FILL       #6
    .FILL       #14
    .FILL       #9
    .FILL       #8
    .FILL       #3
    .FILL       #11
    .FILL       #7
    .FILL       #15
    

.ORIG x4200
    .STRINGZ    "ADD"
    .STRINGZ    "AND"
    .STRINGZ    "BR"
    .STRINGZ    "JMP"
    .STRINGZ    "JSR"
    .STRINGZ    "LD"
    .STRINGZ    "LDI"
    .STRINGZ    "LDR"
    .STRINGZ    "LEA"
    .STRINGZ    "NOT"
    .STRINGZ    "RTI"
    .STRINGZ    "ST"
    .STRINGZ    "STI"
    .STRINGZ    "STR"
    .STRINGZ    "TRAP"
.END
