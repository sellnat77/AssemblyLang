; This program is called "My Little Chasing Cat".

; 1. Type in the program, compile and simulate it.

; 2. Observe what happens on port P1

; "My Little Chasing Cat".

ORG	0000H
LJMP MAIN
ORG 0030H

MAIN:	MOV A, #01H


LOOP: 	
		ACALL BOUNCE

		SJMP	LOOP
		
DELAY:	MOV R3, #01FH
DLY0:	MOV R1, #0FFH
DLY1: 	MOV R2, #0FFH
DLY2: 	DJNZ R2, DLY2
		DJNZ R1, DLY1
		DJNZ R3, DLY0
		RET
BOUNCE:		
		MOV R0,#07H
		MOV R4,#07H
	
AGAIN:	MOV P1, A
		RL A
		ACALL DELAY
		DJNZ R0,AGAIN
NEXT:	MOV P1, A
		RR A
		ACALL DELAY
		DJNZ R4,NEXT
		RET
		
END