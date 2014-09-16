		ORG 0000H
HERE:	MOV R1,#0BH	  ;Set R1 to 10
	
		CJNE R4,#00H,EIGHT	  
		MOV A, #66H
		JNZ OUTSI
EIGHT:	MOV A, #88H 	
  

OUTSI:	MOV R2,#64H	  ;Set R2 to 100
					  ;10*100 = 1000
					  ;Outer loop, runs 10 times
INSID:	CPL A		  ;Inner loop, runs 100 times and compliments A 
					  ;Each iteration		
		DJNZ R2,INSID ;Perform inner loop 100 times, dec R2 each time
		DJNZ R1,OUTSI ;Perform outer loop 10 times, dec R1 each time
		SJMP HERE
		END