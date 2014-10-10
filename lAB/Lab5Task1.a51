; This program is called "My Little Chasing Cat".

; 1. Type in the program, compile and simulate it.

; 2. Observe what happens on port P1

; "My Little Chasing Cat".

ORG	0000H
LJMP MAIN
ORG 0030H

MAIN:	
		SETB P0.7
LOOP: 	
		JNB P0.7,PINON
		ACALL BOUNC		
PINON:	ACALL CHASE
		SJMP	LOOP
		
DELY:	MOV R3, #01FH
DLY0:	MOV R1, #0FFH
DLY1: 	MOV R2, #0FFH
DLY2: 	DJNZ R2, DLY2
		DJNZ R1, DLY1
		DJNZ R3, DLY0
		RET
BOUNC:	MOV A,#01H	
		MOV R0,#07H
		MOV R4,#07H	
MLEFT:	MOV P1, A
		RL A
		ACALL DELY
		DJNZ R0,MLEFT
RIGHT:	MOV P1, A
		RR A
		ACALL DELY
		DJNZ R4,RIGHT
		RET
CHASE:	MOV A,#01H
		MOV R0,#08H
CLEFT:	MOV P1, A
		RL A
		ACALL DELY
		DJNZ R0,CLEFT
		RET
		
END