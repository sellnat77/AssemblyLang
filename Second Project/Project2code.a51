		ORG 0000H
		ORG 0003H
		SETB m_flag
		RETI			
		
MAIN:
		m_flag BIT 0
		SETB EA
		SETB EX0
		
		SETB P0.0
		SETB P0.1
		SETB P0.2
		SETB P0.3
		SETB P0.4
		SETB P0.5
		SETB P0.6
		SETB P0.7
		
LOOP:

		JB P0.0, BOUN
		JB P0.1, COUN
		JB P0.2, DBL
		JB P0.3, CYC
		
		ACALL OFF
		SJMP LOOP
BOUN:	ACALL MODE1
		SJMP LOOP
COUN:	ACALL MODE2
		SJMP LOOP
DBL:	ACALL MODE3
		SJMP LOOP
CYC:	ACALL MODE4		
		SJMP LOOP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MODE1:	;Bouncing
		MOV A, #01H	;Reset A
		MOV R0,#07H ;2 Registers used to bounce left 
		MOV R1,#07H	;Then right
MLEFT:	JB m_flag,HOME1	
		

		MOV P1, A ;Rotate left 7 times
		RL A
		ACALL CHDELAY
		ACALL DELAY
		
		DJNZ R0,MLEFT
RIGHT:	
		MOV P1, A ;Rotate right 7 times
		RR A
		ACALL CHDELAY
		ACALL DELAY
		DJNZ R1,RIGHT
		SJMP MODE1
HOME1:		
		RET		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
MODE2:	;Counting
		CLR A
		MOV R4,#0FFH
AGAIN:	
		JB P0.0,HOME2
		JNB P0.1,HOME2


		INC A
		MOV P1,A
		
		ACALL CHDELAY
		ACALL DELAY

		DJNZ R4,AGAIN
		SJMP MODE2
HOME2:		
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
MODE3:	;Double bouncing
		MOV R0,#128
		MOV R1,#001
		MOV R2,#004
DBLIN:	
		JB P0.1,HOME
		JB P0.0,HOME
		JNB P0.2,HOME

		MOV A,R0
		ORL A,R1
		
		MOV P1,A
		ACALL CHDELAY		
		ACALL DELAY
		MOV A,R0
		RR A
		MOV R0,A
		MOV A,R1
		RL A
		MOV R1,A
		DJNZ R2,DBLIN
		MOV R2,#002
DBLOUT: 
		
		JB P0.1,HOME
		JB P0.0,HOME
		JNB P0.2,HOME

		MOV A,R0
		RR A
		MOV R0,A
		MOV A,R1
		RL A
		MOV R1,A
		MOV A,R0
		ORL A,R1
		MOV P1,A
		ACALL CHDELAY		
		ACALL DELAY
		DJNZ R2,DBLOUT
		SJMP MODE3
HOME:	RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
MODE4:	;Cyclic

		CLR A
		MOV P1,A
		ACALL CHDELAY
		ACALL DELAY	
		MOV R0,#80H
		MOV A,R0
		MOV R4,#08H
		
NEXT:	
		JB P0.2,HOME4
		JB P0.1,HOME4
		JB P0.0,HOME4
		JNB P0.3,HOME4

		MOV P1,A
		RR A
		ORL A,R0
		ACALL CHDELAY
		ACALL DELAY
		DJNZ R4,NEXT
		SJMP MODE4
HOME4:		
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
OFF:	;Flashing lights
		JB P0.0, ON
		JB P0.1, ON
		JB P0.2, ON
		JB P0.3, ON

		
		MOV A,#0FFH
		MOV P1,A
		ACALL CHDELAY
		ACALL DELAY
		CLR A
		MOV P1,A
		ACALL CHDELAY
		ACALL DELAY
ON:		
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
PFIVE: 	;.5 sec delay
		MOV R7, #07H ;Delay function
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
ONE:	;1 dec delay
		MOV R7, #0EH ;Delay function
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
ONEFI:	;1.5 sec delay
		MOV R7, #015H ;Delay function
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
TWO:	;2 sec delay
		MOV R7, #01CH ;Delay function
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DELAY:
DLY20:	MOV R6, #0FFH
DLY21: 	MOV R5, #0FFH
DLY22: 	DJNZ R5, DLY22
		DJNZ R6, DLY21
		DJNZ R7, DLY20
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHDELAY:
		JB P0.4,CPFI
		JB P0.5, CONE
		JB P0.6, CONEFI
			
		ACALL TWO
		SJMP ENDTIME
CPFI:	ACALL PFIVE
CONE:	ACALL ONE
		SJMP ENDTIME
CONEFI: ACALL ONEFI
		SJMP ENDTIME
CTWO:	ACALL TWO
ENDTIME: RET
END
