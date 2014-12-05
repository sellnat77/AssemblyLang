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
		ACALL PACK
		ACALL AVERAGE
		ACALL LARGE
		ACALL SMALL
		ACALL HTOAS
		SJMP MAIN
;=============================================
		
PACK:		
		MOV R0,#40H
		MOV R1,#50H
		MOV R7,#20H
AGAIN:		
		MOV A,@R0
		MOV B,#10H
		DIV AB
		MOV @R1,A
		INC R1
		MOV @R1,B
		;MOV R3,A
		;MOV R4,B
		;SWAP A
		;ORL A,B
		;MOV @R1,A
		
		INC A
		INC R0
		INC R1
			
		DJNZ R7,AGAIN
		RET
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
		MOV R2,#08H
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
		MOV R0,#50H
		MOV R1,#70H
		MOV R3,#20H
		MOV R4,#00H
		
		
HLOOP:	
		MOV A,@R0
		ORL A,#30H
		MOV @R1,A
		;MOV B,#10H
		;MUL AB
		;MOV R4,A
		;MOV A,@R0
		;ANL A,#0FH
		;ADD R4,A
		
		;MOV @R0,A
		
		
		
		INC R0
		INC R1
		
		
		DJNZ R3,HLOOP
		
		
		RET
DATAB:	
		DB 17,37,9,18,11,26,23,43		
		END