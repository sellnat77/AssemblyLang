		ORG 0000H
MAIN:
		SETB P0.0
		SETB P0.1
		SETB P0.2
		SETB P0.3
		SETB P0.4
		SETB P0.5
		SETB P0.6
		SETB P0.7
LOOP:
		ACALL CHOOSE		
		SJMP LOOP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MODE1:	;Bouncing
		MOV A, #01H	;Reset A
		MOV R0,#07H ;2 Registers used to bounce left 
		MOV R1,#07H	;Then right
MLEFT:	JB P0.0,SKIP	
		ACALL CHOOSE
SKIP:		
		MOV P1, A ;Rotate left 7 times
		RL A
		;LCALL DELAYCH
		ACALL CHDELAY
		LCALL DELAY
		
		DJNZ R0,MLEFT
RIGHT:	JB P0.0,BSKIP
		ACALL CHOOSE
BSKIP:
		MOV P1, A ;Rotate right 7 times
		RR A
		ACALL CHDELAY
		LCALL DELAY
		DJNZ R1,RIGHT
		RET		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
MODE2:	;Counting
		CLR A
		MOV R4,#0FFH
AGAIN:	JB P0.0,CFORCE
		JB P0.1,CSKIP
CFORCE: ACALL CHOOSE
CSKIP:
		INC A
		MOV P1,A
		
		ACALL CHDELAY
		LCALL DELAY

		DJNZ R4,AGAIN
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
MODE3:	;Double bouncing
		MOV R0,#128
		MOV R1,#001
		MOV R2,#004
DBLIN:	
		JB P0.1,DDFORCE
		JB P0.0,DDFORCE
		JB P0.2,DSKIP
DDFORCE: ACALL CHOOSE
DSKIP:
		MOV A,R0
		ORL A,R1
		ACALL CHDELAY		
		ACALL DELAY
		MOV P1,A
		MOV A,R0
		RR A
		MOV R0,A
		MOV A,R1
		RL A
		MOV R1,A
		DJNZ R2,DBLIN
		MOV R2,#004
DBLOUT: 
		JB P0.1,DFORCE
		JB P0.0,DFORCE
		JB P0.2,DDSKIP
DFORCE: ACALL CHOOSE
DDSKIP:	
		
		MOV A,R0
		ORL A,R1
		ACALL CHDELAY		
		ACALL DELAY
		MOV P1,A
		MOV A,R0
		RL A
		MOV R0,A
		MOV A,R1
		RR A
		MOV R1,A
		DJNZ R2,DBLOUT
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
MODE4:	;Cyclic
	
		CLR A
		MOV P1,A
		ACALL CHDELAY
		LCALL DELAY	
		MOV A,#128
		MOV R4,#08H
		
NEXT:	
		JB P0.2,FORCE
		JB P0.1,FORCE
		JB P0.0,FORCE
		JB P0.3,CYSKIP
FORCE:	ACALL CHOOSE
CYSKIP:
		MOV P1,A
		RR A
		ORL A,P1
		ACALL CHDELAY
		LCALL DELAY
		DJNZ R4,NEXT
		CLR A
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
OFF:	;Flashing lights
		JB P0.0, ON
		JB P0.1, ON
		JB P0.2, ON
		JB P0.3, ON

		ACALL CHDELAY
		MOV A,#0FFH
		MOV P1,A
		LCALL DELAY
		CLR A
		MOV P1,A
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
CHOOSE:
		JB P0.0, BOUN
		JB P0.1, COUN
		JB P0.2, DBL
		JB P0.3, CYC
		
		ACALL OFF
		SJMP BOT
BOUN:	ACALL MODE1
		SJMP BOT
COUN:	ACALL MODE2
		SJMP BOT
DBL:	ACALL MODE3
		SJMP BOT
CYC:	ACALL MODE4
		SJMP BOT
BOT:	RET		
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
