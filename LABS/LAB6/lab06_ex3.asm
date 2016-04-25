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
	LD R6, BIT_MANIPULATION_3200
	JSRR R6
	
	
	
	
	;=====
	;DATA
	;=====
	BIT_MANIPULATION_3200		.FILL	x3200
;=======================================
;SUBROUTINE NAME: BIT_MANIPULATION_3200
;PARAMETER:
;POSTCONDITION:
;RETURN VALUE:
;=======================================
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
    LD R3, DEC_14_3200
    LD R2, DEC_0_3200
    
RIGHT_SHIFTING_3200
	ADD R2, R2, #0
	ADD R1, R1,	#0
	BRn	ADD_1_3200	
	BR LEFT_SHIFTING_3200
	
ADD_1_3200
	ADD R2, R2, #1
	
LEFT_SHIFTING_3200
	ADD R1, R1, R1
	ADD R3, R3, #-1
	BRzp RIGHT_SHIFTING_3200
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
    LD R0, BACKUP_R0_3200
    ;=======
    ;RETURN
    ;=======
    JMP R7
    ;================
    ;SUBROUTINE DATA
    ;================
    BACKUP_R7_3200		.BLKW		#1
    BACKUP_R6_3200		.BLKW		#1
    BACKUP_R5_3200		.BLKW		#1
    BACKUP_R4_3200		.BLKW		#1
    BACKUP_R3_3200		.BLKW		#1
    BACKUP_R2_3200		.BLKW		#1
    BACKUP_R1_3200		.BLKW		#1
    BACKUP_R0_3200		.BLKW		#1
.END
