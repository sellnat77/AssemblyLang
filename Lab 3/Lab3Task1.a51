		ORG 0000h
		
		MOV A, #0H
		MOV R0,#0H
		MOV R1,#0H
		MOV R2,#0H
		MOV R3,#0FFH ;Start R3 as 255
		
LOOP:	INC R2
		ADD A,R2 
		MOV R0,A       ;Increment low byte
		JNC NOCAR    ;If no carry add next value to A
		INC R1       ;Increment high byte if cy = 1
		
NOCAR:	DJNZ R3,LOOP ;Repeat 255 times
		
		END