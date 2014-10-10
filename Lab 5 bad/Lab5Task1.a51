; This program is called "My Little Chasing Cat".

; 1. Type in the program, compile and simulate it.

; 2. Observe what happens on port P1

; "My Little Chasing Cat".

ORG	0000H

LJMP MAIN

ORG 0030H

MAIN:

		MOV A, #01H
		MOV R0,#08H
		MOV R4,#08H

LOOP: 	MOV P1, A
		
		ACALL DELAY
		SJMP	LOOP
		
DELAY:
		MOV R3, #0FFH

DLY0: 	MOV R1, #0FFH
	
DLY1: 	MOV R2, #0FFH

DLY2: 	DJNZ R2, DLY2

		DJNZ R1, DLY1

		DJNZ R3, DLY0
		RET

END