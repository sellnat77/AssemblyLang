		ORG 0000H
	
MAIN:	
		MOV R0,#40H
		MOV R7,#07H
		
LOOP:		
		MOV @R0,
		INC R0
		DJNZ R7,LOOP
		SJMP MAIN
		END