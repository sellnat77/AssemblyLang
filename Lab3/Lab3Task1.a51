	ORG 00h
		MOV A,#0H
		MOV R0,#0H
		MOV R1,#0H
		MOV R2,#0H
		MOV R3,#0FFH
		
LOOP:	ADD A,R2 
		INC R2
		INC R0 ;Increment low byte
		JNC LOOP ;If no carry add next value to A
		INC R1 ;Increment high byte if cy = 1
		DJNZ R3,LOOP ;Repeat 255 times
	END