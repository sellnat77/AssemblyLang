ORG	0000H
LJMP MAIN
ORG 0030H

MAIN:	
		SETB P0.7 ;Set p0.7 as input
LOOP: 	
		JNB P0.7,PINON ;Jump if p0.7 is on
PINOF:	ACALL BOUNC	   ;Otherwise, bounce	
PINON:	ACALL CHASE    ;Chase is p0.7 is on
		SJMP	LOOP   ;Repeat forever
		
DELY:	MOV R3, #00FH ;Delay function
DLY0:	MOV R1, #0FFH
DLY1: 	MOV R2, #0FFH
DLY2: 	DJNZ R2, DLY2
		DJNZ R1, DLY1
		DJNZ R3, DLY0
		RET

BOUNC:	MOV A,#01H	;Reset A
		MOV R0,#07H ;2 Registers used to bounce left 
		MOV R4,#07H	;Then right

MLEFT:	JNB P0.7,PINON
		MOV P1, A ;Rotate left 7 times
		RL A
		ACALL DELY
		DJNZ R0,MLEFT

RIGHT:	JNB P0.7,PINON
		MOV P1, A ;Rotate right 7 times
		RR A
		ACALL DELY
		DJNZ R4,RIGHT
		RET

CHASE:	MOV A,#01H ;Reset A
		MOV R0,#08H ;Rotate left 8 times to show the chase

CLEFT:	JB P0.7,PINOF
		MOV P1, A
		RL A
		ACALL DELY
		DJNZ R0,CLEFT
		RET
END