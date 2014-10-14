		ORG 0000H
MAIN:
		ACALL MODE1

		SJMP MAIN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MODE1:	;Bouncing
		MOV A, #01H	;Reset A
		MOV R0,#07H ;2 Registers used to bounce left 
		MOV R1,#07H	;Then right
MLEFT:	ACALL MODECH
		MOV P1, A ;Rotate left 7 times
		RL A
		ACALL PFIVE
		DJNZ R0,MLEFT

RIGHT:	ACALL MODECH
		MOV P1, A ;Rotate right 7 times
		RR A
		ACALL PFIVE
		DJNZ R1,RIGHT
		RET
		RET
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
MODE2:	;Counting
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
MODE3:	;Double bouncing
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
MODE4:	;Cyclic
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
OFF:	;Flashing
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
PFIVE: 	;.5 sec delay
		MOV R7, #00FH ;Delay function
DLY00:	MOV R6, #0FFH
DLY01: 	MOV R5, #0FFH
DLY02: 	DJNZ R5, DLY02
		DJNZ R6, DLY01
		DJNZ R7, DLY00
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
ONE:	;1 dec delay
		MOV R7, #00FH ;Delay function
DLY10:	MOV R6, #0FFH
DLY11: 	MOV R5, #0FFH
DLY12: 	DJNZ R5, DLY12
		DJNZ R6, DLY11
		DJNZ R7, DLY10
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
ONEFI:	;1.5 sec delay
		MOV R7, #00FH ;Delay function
DLY20:	MOV R6, #0FFH
DLY21: 	MOV R5, #0FFH
DLY22: 	DJNZ R5, DLY22
		DJNZ R6, DLY21
		DJNZ R7, DLY20
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
TWO:	;2 sec delay
		MOV R7, #00FH ;Delay function
DLY30:	MOV R6, #0FFH
DLY31: 	MOV R5, #0FFH
DLY32: 	DJNZ R5, DLY32
		DJNZ R6, DLY31
		DJNZ R7, DLY30
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
MODECH:	;Select mode based on pin
		JB P0.0,MODE1
		JB P0.1,MODE2
		JB P0.2,MODE3
		JB P0.3,MODE4
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
DELAYCH:	;Select delay based on pin
		JB P0.4,PFIVE
		JB P0.5,ONE
		JB P0.6,ONEFI
		JB P0.7,TWO
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
END
