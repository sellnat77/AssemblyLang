		ORG 0000H
		LJMP MAIN
MAIN:	
		MOV R0,#0AH
		MOV R1,#40H
		MOV R2,#0H
		MOV R3,P0
GRAB:	
		MOV 40H,#10H
		
		DJNZ R0,GRAB
		
LOOP:	INC R2
		ADD A, R2 
		MOV 4AH,A     ;Assign low byte to current value of A
		JNC NOCAR    ;If no carry add next value to A
		INC 4BH     ;Increment high byte if cy = 1
		
NOCAR:	DJNZ R3,LOOP ;Repeat 255 times	

		END