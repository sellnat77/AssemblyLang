		ORG 0000H
		LJMP MAIN
;============================================
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
		
		ACALL AVERAGE
		ACALL LARGE
		ACALL SMALL
		ACALL PACK
		ACALL HTOAS
STOP:
		SJMP STOP
;=============================================
PACK:		
		MOV R0,#40H
		MOV R1,#50H
		MOV R7,#11H
AGAIN:		
		MOV A,@R0
		MOV B,#10
		DIV AB
		SWAP A	
		ORL A,B
		MOV @R1,A
		
		INC R1		
		INC R0
			
		DJNZ R7,AGAIN
		RET
;===========================================
AVERAGE:
		MOV R0,#40H
		MOV R3,#08H
		CLR A
		
REP:	
		MOV B,@R0
		ADD A,B		
		INC R0
		DJNZ R3,REP
		MOV B,#08H
		DIV AB
		MOV 48H,A
		RET
;===========================================
LARGE:		
		MOV R0,#40H
		MOV R2,#008H
		MOV B,#00H
		CLR A
LOO:		
		MOV A,@R0
		CJNE A,B,NEXT
NEXT:
		JNC SKI
		SJMP LAST
SKI:	
		MOV B,A
LAST:
		INC R0	
		DJNZ R2,LOO
		MOV A,B
		MOV 49H,A
		RET
;===========================================		
SMALL:
		MOV R0,#40H
		MOV R2,#08H
		MOV B,@R0
		CLR A
SLOO:		
		MOV A,@R0
		CJNE A,B,SNEXT
SNEXT:
		JC SSKI
		SJMP SLAST
SSKI:	
		MOV B,A
SLAST:
		INC R0	
		DJNZ R2,SLOO
		MOV A,B
		MOV 4AH,A
		RET		
;============================================		
HTOAS:
		MOV R0,#40H
		MOV R1,#60H
		MOV R3,#11H
HLOOP:	
		MOV A,@R0
		MOV B,#10
		DIV AB
		ORL A,#30H		
		MOV @R1,A
		INC R1
		MOV A,B
		ORL A,#30H
		MOV @R1,A
		INC R0
		INC R1
		DJNZ R3,HLOOP
		RET
DATAB:	
		DB 17,37,9,18,11,26,23,43		
		END