		m_flag BIT 0
		
		ORG 0000H
		LJMP SETUP
		
		ORG 0003H
		SETB m_flag
		RETI			
		
SETUP:
		MOV IE, #85H
		
		SETB EA
		SETB EX0
		MOV TMOD, #01H
		
		
		SETB P0.0
		SETB P0.1
		SETB P0.2
		SETB P0.3
		SETB P0.4
		SETB P0.5
		SETB P0.6
		SETB P0.7
		SETB P3.7
		
LOOP:
		CLR m_flag
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
RIGHT:	JB m_flag,HOME1
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
		MOV R4,P2
SKIPU:		
		JNB P3.7,SKIPD
		;UP
		MOV A,R4
AGAIN:	JB m_flag,HOME2
		
		
		MOV P1,A
		
		ACALL CHDELAY
		ACALL DELAY
		INC A

		DJNZ R4,AGAIN
		MOV R4,#0H
		SJMP SKIPU
		;DOWN	
SKIPD:		
		
		MOV A,R4
OTRA:	JB m_flag,HOME2
		
		
		MOV P1,A
		ACALL CHDELAY
		ACALL DELAY
		DEC A		
		DJNZ R4,OTRA
		MOV R4,#0FFH
		SJMP SKIPD
		
HOME2:		
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
MODE3:	;Double bouncing
		MOV R0,#128
		MOV R1,#001
		MOV R2,#004
DBLIN:	
		JB m_flag,HOME

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
		
		JB m_flag,HOME

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
		JB m_flag,HOME4

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
		JB m_flag, ON

		
		MOV A,#0FFH
		MOV P1,A
		ACALL CHDELAY
		ACALL DELAY
		;CLR A
		MOV P1,#0H
		ACALL CHDELAY
		ACALL DELAY
		SJMP OFF
ON:		
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
PFIVE: 	;.5 sec delay
		MOV R7, #7H ;Delay function
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
ONE:	;1 dec delay
		MOV R7, #2H ;Delay function
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
ONEFI:	;1.5 sec delay
		MOV R7, #3H ;Delay function
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
TWO:	;2 sec delay
		MOV R7, #4H ;Delay function
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DELAY:
		
	  
; Calculate the initial counting value x:
; In At89C51RD2 1 machine cycle equals 12 crystal cycles:
; (12/11.0592MHz)(2^16-x)=50ms
; solve the equation for x, we obtain:
; x=2^16-50ms*11.0592MHz/12=19456=4C00H

WAIT: MOV TL0, #0;load initial counting value
      MOV TH0, #4CH;
      SETB TR0;turn on T0
HERE: JNB TF0, HERE;wait for timer 0 to overflow
      CLR TR0 ;turn off timer 0
      CLR TF0 ;clear TF0 as interrupt is not used, 
        ;it will not be cleared by hardware.
      DJNZ R7, WAIT
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
		SJMP ENDTIME
CONE:	ACALL ONE
		SJMP ENDTIME
CONEFI: ACALL ONEFI
		SJMP ENDTIME
CTWO:	ACALL TWO
ENDTIME: RET
END
