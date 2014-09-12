		ORG 0000H
			
		MOV R4,#00H
		;MOV R4,#0AH  ;A != 0
		MOV A,R4
		MOV R1,#0BH	  ;Set R1 to 10
		
		JNZ NOZER	  ;If A != 0 skip the #66H assignment
		
		MOV A, #66H   ;If A == 0 assign #66H to A
		JNZ OUTSI	  ;Skip the #88H assignment
		
NOZER:	MOV A, #88H   ;If A != 0 assign #88H

OUTSI:	MOV R2,#64H	  ;Set R2 to 100
					  ;10*100 = 1000
					  ;Outer loop, runs 10 times
INSID:	CPL A		  ;Inner loop, runs 100 times and compliments A 
					  ;Each iteration		
		DJNZ R2,INSID ;Perform inner loop 100 times, dec R2 each time
		DJNZ R1,OUTSI ;Perform outer loop 10 times, dec R1 each time
		
		END