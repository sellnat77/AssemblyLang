		ORG 0000H
MAIN:
		SETB P0.0
		SETB P0.1
		SETB P0.2
		SETB P0.3
		SETB P0.4
		SETB P0.5
		SETB P0.6
		SETB P0.7
		
LOOP:		
		LCALL MODECH

		SJMP LOOP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MODE1:	;Bouncing
		MOV A, #01H	;Reset A
		MOV R0,#07H ;2 Registers used to bounce left 
		MOV R1,#07H	;Then right
MLEFT:	;LCALL MODECH
		MOV P1, A ;Rotate left 7 times
		RL A
		LCALL DELAYCH
		DJNZ R0,MLEFT
RIGHT:	;LCALL MODECH
		MOV P1, A ;Rotate right 7 times
		RR A
		LCALL DELAYCH
		DJNZ R1,RIGHT
		RET		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
MODE2:	;Counting
		CLR A
		MOV R2,#0FFH
AGAIN:	;LCALL MODECH
		INC A
		MOV P1,A
		LCALL DELAYCH
		DJNZ R0,AGAIN
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
MODE3:	;Double bouncing
		LCALL MODECH
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
MODE4:	;Cyclic
		LCALL MODECH
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
OFF:	;Flashing
		LCALL MODECH
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
PFIVE: 	;.5 sec delay
		MOV R7, #001H ;Delay function
DLY50:	MOV R6, #00FH
DLY51:  MOV R5, #0FFH
DLY52:  DJNZ R5, DLY52
		DJNZ R6, DLY51
		DJNZ R7, DLY50
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
ONE:	;1 dec delay
		MOV R7, #001H ;Delay function
DLY10:	MOV R6, #0AFH
DLY11: 	MOV R5, #0FFH
DLY12: 	DJNZ R5, DLY12
		DJNZ R6, DLY11
		DJNZ R7, DLY10
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
ONEFI:	;1.5 sec delay
		MOV R7, #001H ;Delay function
DLY150: MOV R6, #0FFH
DLY151: MOV R5, #0FFH
DLY152: DJNZ R5, DLY152
		DJNZ R6, DLY151
		DJNZ R7, DLY150
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
TWO:	;2 sec delay
		MOV R7, #00FH ;Delay function
DLY20:	MOV R6, #0FFH
DLY21: 	MOV R5, #0FFH
DLY22: 	DJNZ R5, DLY22
		DJNZ R6, DLY21
		DJNZ R7, DLY20
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
MODECH:	;Select mode based on pin
		
RESET:	JB P0.0,BOUN		
		JB P0.1,COUN
		JB P0.2,CYC
		JB P0.3,DBLBOUN
		
BOUN:	LCALL MODE1	
		SJMP RESET
COUN:	LCALL MODE2		
		SJMP RESET
CYC:	LCALL MODE3	
		SJMP RESET
DBLBOUN:LCALL MODE4	
		SJMP RESET
		LCALL OFF
		SJMP RESET
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
DELAYCH:	;Select delay based on pin
TIME:	JB P0.4,POINT
		JB P0.5,FULL
		JB P0.6,FULLHAF
		JB P0.7,TWOFULL
		
POINT:	LCALL PFIVE
		SJMP TIME
FULL:	LCALL ONE
		SJMP TIME
FULLHAF:LCALL ONEFI
		SJMP TIME
TWOFULL:LCALL TWO
		SJMP TIME
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
END
