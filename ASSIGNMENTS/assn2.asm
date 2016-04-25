;=================================================
; Name: Munoz, Francisco
; Username: fmuno003 (fmuno003@ucr.edu)
; 
; Assignment name: ASSN 02
; Lab section: 021
; TA: Bryan Marsh
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================
.orig x3000
    ;================
    ;Instructions
    ;================
    LEA R0, INSTRUCTIONS_1                  ;Puts the string of INSTRUCTIONS_1 into R0
    TRAP x22                                ;Prints out string at INSTRUCTIONS_1
    
    LEA R0, INSTRUCTIONS_2                  ;Puts the string of INSTRUCTIONS_2 into R0
    TRAP x22                                ;Prints out string at INSTRUCTIONS_2
    
    TRAP x20                                ;Character is inputted
    TRAP x21                                ;Echoes the character on the screen
    ADD R1, R0, #0                          ;The value in R0 is moved to R1
    LEA R0, INSTRUCTIONS_2                  ;Puts the string of INSTRUCTIONS_2 into R0
    TRAP x22                                ;Prints out string at R0
    
    TRAP x20                                ;Character is inputted
    TRAP x21                                ;Echoes the character on the screen
    ADD R2, R0, #0                          ;The value in R0 is moved to R1
    LEA R0, INSTRUCTIONS_2                  ;Puts thr string of INSTRUCTIONS_2 into R0
    TRAP x22                                ;Prints out string at R0
    
    LD R6, HEX_30                           ;Loads HEX_30 = 48 into R6
    NOT R6, R6                              ;Negates R6
    ADD R6, R6, #1                          ;Adds #1 to R6, forming the Two's complement
    
    ADD R3, R2, R6                          ;R3 <-- Value in R2 + -48 = second number inputted
    ADD R4, R1, R6                          ;R4 <-- Value in R1 + -48 = first number inputted
    
    NOT R3, R3                              ;negates second number inputted
    ADD R3, R3, #1                          ;add one to negated number to complete Two's complement
    
    ADD R5, R4, R3                          ;R5 <-- first number + negative second number
    
    NOT R6, R6                              ;Negates R6
    ADD R6, R6, #1                          ;Add 1 to R6 to complete Two's complement
    ADD R0, R1, #0                          ;R0 <-- first number + 48 
    TRAP x21                                ;Print out the ascii character for R0
    
    LEA R0, INSTRUCTIONS_3                  ;Puts the string of INSTRUCTIONS_3 into R0
    TRAP x22                                ;Prints out string at R0
    
    ADD R0, R2, #0                          ;R0 <-- second number + 48
    TRAP x21                                ;Prints out ASCII character for R0
    
    LEA R0, INSTRUCTIONS_4                  ;Puts the string of INSTRUCTIONS_4 into R0
    TRAP x22                                ;Prints out string at R0
 	
 	ADD R5, R5, #0							;R5 <-- R5 + #0
    BRzp SKIP								;If positive or zero
    NOT R5, R5								;Continue into this code is positive or zero
    ADD R5, R5, #1
    ADD R5, R5, R6
    
    LEA R0, INSTRUCTIONS_5					;Puts the string of INSTRUCTIONS_5 into R0
    TRAP x22								;Prints out string at R0
    
    ADD R0, R5, #0							;R0 <-- R5 + #0
    TRAP x21								;Print out the ASCII character in R0
    
    LEA R0, INSTRUCTIONS_2					;Puts the string of INSTRUCTIONS_2 into R0
    TRAP x22								;Prints out string at R0
    
    TRAP x25								;HALT

SKIP    									;Skip to here if BRzp was false
    ADD R0, R5, R6							;Proceed here if positive
    TRAP x21                                ;Prints out the ASCII character in R0
    
    LEA R0, INSTRUCTIONS_2                  ;Puts the string of INSTRUCTIONS_2 into R0
    TRAP x22                                ;Prints out string at R0
    
    TRAP x25								;HALT
    ;=======
    ;Data
    ;=======
    INSTRUCTIONS_1 .STRINGZ     "ENTER two numbers (i.e '0'....'9')"
    INSTRUCTIONS_2 .STRINGZ     "\n"
    INSTRUCTIONS_3 .STRINGZ     " - "
    INSTRUCTIONS_4 .STRINGZ     " = "
    INSTRUCTIONS_5 .STRINGZ		"-"
    HEX_30         .FILL        x30
    
.end
