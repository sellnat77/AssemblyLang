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
;		JB P0.1,BCOUN		
;		JB P0.2,BCYC
;		JB P0.3,BDBLBOUN
;		SJMP LEND
;		
;BCOUN:	LCALL MODE2	
;		SJMP LEND
;BCYC:	LCALL MODE3	
;		SJMP LEND
;BDBLBOUN:LCALL MODE4	
;		SJMP LEND
;		LCALL OFF
;LEND:
		MOV P1, A ;Rotate left 7 times
		RL A
		;LCALL DELAYCH
		ACALL CHDELAY
		LCALL DELAY
		
		DJNZ R0,MLEFT
RIGHT:	JB P0.0,BSKIP
		ACALL CHOOSE
BSKIP:
;		JB P0.1,BBCOUN		
;		JB P0.2,BBCYC
;		JB P0.3,BBDBLBOUN
;		SJMP BLEND
;		
;BBCOUN:	LCALL MODE2	
;		SJMP BLEND
;BBCYC:	LCALL MODE3	
;		SJMP BLEND
;BBDBLBOUN:LCALL MODE4	
;		SJMP BLEND
;		LCALL OFF
;BLEND:
		MOV P1, A ;Rotate right 7 times
		RR A
		;LCALL DELAYCH
		ACALL CHDELAY
		LCALL DELAY
		DJNZ R1,RIGHT
		RET		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
MODE2:	;Counting
		CLR A
		MOV R2,#0FFH
AGAIN:	JB P0.1,CSKIP
		ACALL CHOOSE
CSKIP:
;		JB P0.0,CBOUN		
;		JB P0.2,CCYC
;		JB P0.3,CDBLBOUN
;		SJMP CLEND
;		
;CBOUN:	LCALL MODE1	
;		SJMP CLEND
;CCYC:	LCALL MODE3	
;		SJMP CLEND
;CDBLBOUN:LCALL MODE4	
;		SJMP CLEND
;		LCALL OFF
;CLEND:
		INC A
		MOV P1,A
		
		ACALL CHDELAY
		LCALL DELAY

		DJNZ R0,AGAIN
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
MODE3:	;Double bouncing
		;LCALL MODECH
		ACALL CHOOSE
		ACALL CHDELAY
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
MODE4:	;Cyclic
		;LCALL MODECH
		MOV A,#01H
		MOV R0,#08H
		
NEXT:	JB P0.3,CYSKIP
		ACALL CHOOSE
CYSKIP:
		MOV P1,A
		MOV R1,P1
		RL A
		ORL A,P1
		ACALL CHDELAY
		LCALL DELAY
		DJNZ R0,NEXT
		
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
OFF:	;Flashing
		;LCALL MODECH
		CLR A
		MOV R0,#01H
TOP:	ACALL CHOOSE
		ACALL CHDELAY
		MOV A,#0FFH
		MOV P1,A
		LCALL DELAY
		CLR A
		MOV P1,A
		DJNZ R0,TOP
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
PFIVE: 	;.5 sec delay
		MOV R7, #010H ;Delay function
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
ONE:	;1 dec delay
		MOV R7, #020H ;Delay function
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
ONEFI:	;1.5 sec delay
		MOV R7, #04H ;Delay function
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
TWO:	;2 sec delay
		MOV R7, #080H ;Delay function
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
		JB P0.5, CONE
		JB P0.6, CONEFI
		JB P0.7, CTWO
		
		ACALL PFIVE
		SJMP ENDTIME
CONE:	ACALL ONE
		SJMP ENDTIME
CONEFI: ACALL ONEFI
		SJMP ENDTIME
CTWO:	ACALL TWO
ENDTIME: RET
		
END
	
;JB 2
;LCALL 1
;SJMP TOP
;LABEL 2 CALL 2
;SJMP TOP
