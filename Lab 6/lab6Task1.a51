		ORG 0000H
		LJMP MAIN
MAIN:	
		MOV R0,#40H
		MOV R1,#4AH
		MOV R2,#0AH
		MOV R3,#00H
		MOV R4,#00H
		MOV R5,#00H
		
LOOP:
		MOV @R0,P0	
		MOV A,@R0
		ACALL PLUS	
		INC R0		
		DJNZ R2,LOOP
		MOV 4AH,R5
		MOV 4BH,R4
		SJMP MAIN
		
		
PLUS:	
		
		MOV R6,A
ALOOP:	INC R3
		ADD A, R3
		MOV R4,A     ;Assign low byte to current value of A
		JNC NOCAR    ;If no carry add next value to A
		INC R5       ;Increment high byte if cy = 1
		
NOCAR:	DJNZ R6,ALOOP ;Repeat 255 times
		RET
		
		
		

		END