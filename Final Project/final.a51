		ORG 0000H
		LJMP MAIN

DATAB:	
		DB 17H,37H,9H,18H,11H,26H,23H,43H
MAIN:	
		MOV DPTR,#DATAB
		MOV R0,#40H
		MOV R7,#08H
			
			
LOOP:		
		CLR A
		MOVC A,@A+DPTR
		MOV @R0,A
		INC R0
		INC DPTR
		DJNZ R7,LOOP
		;ACALL PACK
		ACALL AVERAGE
		SJMP MAIN
		
PACK:		
		MOV R0,#40H
		MOV R7,#08H
AGAIN:		
		MOV A,@R0
		MOV B,#10H
		DIV AB
		MOV R3,A
		MOV R4,B
		SWAP A
		ORL A,B
		MOV @R0,A
		
		INC A
		INC R0
			
		DJNZ R7,AGAIN
		RET
AVERAGE:
		MOV R0,#40H
		MOV R3,#07H
		CLR A
		
REP:	
		MOV B,@R0

		ADD A,B

		
		

		INC R0
		DJNZ R3,REP
		
		MOV B,#07H
		DIV AB
		
		
		MOV A,48H


		RET
		END