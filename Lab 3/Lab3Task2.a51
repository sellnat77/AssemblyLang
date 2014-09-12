		ORG 0000H
			
		MOV R4,#00H
		;MOV R4,#0AH  ;A != 0
		MOV A,R4
		
		MOV R2,#0BH	  ;Set R2 to 10
		MOV R1,#64H	  ;Set R1 to 100
					  ;10*100 = 1000
		JNZ NOZER	  ;If A != 0 skip #66H assignment
		
		MOV A, #66H   ;If A == 0 assign #66H to A
		JNZ COMPL	  ;Skip the #88H assignment
		
NOZER:	MOV A, #88H   ;If A != 0 assign #88H

COMPL:				  ;Outer loop, runs 100 times
INSID:	CPL A		  ;Inner loop, runs 10 times and compliments A 
					  ;Each iteration		
		DJNZ R1,COMPL ;Perform outer loop 100 times, dec R1 each time
		DJNZ R2,INSID ;Perform inner loop 10 times, dec R2 each time
		
		END