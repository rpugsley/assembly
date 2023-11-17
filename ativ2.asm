org 0
jmp inicio

org 3
jmp intinc

org 11
jmp timerdisplay

inicio:
mov tcon,#00000001b		; habilita IT0
mov	TMOD,#00000010b		; define o MODO2 para TIMER 0	 ( 8bits auto reload)
mov	TH0,#156d			;	72 Khz / 12  = 6 KHz	6 KHz / 100 = 60 Hz => 256-100=156
mov	TL0,#156d			
setb tr0		   		; liga timer 0
mov ie,#10000011b		; habilita todas as interrupcoes, interrupcoes externas no TR0 

mov r5,#0				; segundos
mov r0,#0	 			; unidade
mov r1,#0				; dezena
setb P1.7


ping_pong:
mov p2,#00000001b
call espera
mov p2,#00000010b
call espera
mov p2,#00000100b
call espera
mov p2,#00001000b
call espera
mov p2,#00010000b
call espera
mov p2,#00100000b
call espera
mov p2,#01000000b
call espera
mov p2,#10000000b
call espera
mov p2,#01000000b
call espera
mov p2,#00100000b
call espera
mov p2,#00010000b
call espera
mov p2,#00001000b
call espera
mov p2,#00000100b
call espera
mov p2,#00000010b
call espera
jmp ping_pong

espera:
	cjne r5,#59, espera	   ; espera 1Hz
	ret	 
show:
	reti
intinc:
	inc R0
	cjne R0,#10,show		; incrementa unidade e verifica se foi ate 10
	inc R1				  	; incrementa dezena 
	mov R0,#0				; zera unidade
	cjne R1,#10,show		; incrementa dezena e verifica se foi ate 10
	mov R1,#0				; zera dezena
	jmp show	
timerdisplay:

	inc r5			   		; incrementa segundos
	mov DPTR,#tabela		; ???
	jb p1.7,mostra_dezena	;
	mov	A,R0
	movc A,@A+DPTR
	mov P1,A
	setb P1.7
	reti
mostra_dezena:
	mov		A,R1
	movc A,@A+DPTR
	mov		P1,A
	clr		P1.7
	reti

tabela:		  
	db 1000000b	;;	0
	db 1111001b	;;	1
	db 0100100b	;;	2
	db 0110000b	;;	3
	db 0011001b	;;	4
	db 0010010b	;;	5
	db 0000010b	;;	6
	db 1111000b	;;	7																
	db 0000000b	;;	8
	db 0010000b	;;	9
end