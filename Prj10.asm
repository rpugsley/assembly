	include <p16f876a.inc>
	
	cblock 0x20			;declaracao de variaveis
	unidade
	dezena
	endc

	org 0
	goto inicio
	org 4
	goto unitario

inicio:
	call reset
	BANKSEL TRISC		; PORTC = saida
	clrf	TRISC

	BANKSEL PORTC		; saida da ativ8
	clrf 	PORTC

	BANKSEL TRISB 		; saida e entrada da ativ 6
	movlw 	b'00000010'	; seta portb[1] para entrada
	movwf 	TRISB

	BANKSEL PORTB
	clrf 	PORTB

	movlw	b'11000000'	; habilita as interrupcoes gerais e as internas. 
	movwf	INTCON

	movlw	b'00000110'	; liga Timer 2 com Prescaler = 1:16[0..1] e Postscaler = 1:1[3..6] e habilita o timer2
	movwf	T2CON

	BANKSEL	PIE1	
	movlw	b'00000010'	; habilita a interrupcao qnd igualar o valor com PR2 
	movwf	PIE1
	
	movlw	.15
	movwf	PR2			; 250 * 4 * 16 = 16000 Hz pra dar um segundo
	
ativ6:	
	
	BANKSEL PORTB	
	btfss PORTB,1 		; testa bit 1 do portb, se estiver em 1 pula a proxima instrucao
	goto inverte_bit
	bsf PORTB,2			; liga o bit 2
	bcf PORTB,3			; desliga bit 3	
	goto ativ6

inverte_bit:

	bcf PORTB,2			; desliga o bit 2
	bsf PORTB,3 		; liga o bit 3
	goto ativ6



unitario:				; ativ 8
	BANKSEL PIR1
	bcf PIR1,1			;abaixa a flag
	movlw .9
	subwf unidade,W		;checa a condicao de mudanca de decimal
	btfsc STATUS,Z		;bit 2 do reg status
	goto decimal		;se zerou, precisa incrementar a dezena
	incf unidade,1		;incrementa unidade
	call imprime	
	retfie
	

decimal:
	incf dezena,1		
	movlw .10
	subwf dezena,W
	btfsc STATUS,Z		;checa se zerou, entao a dezena bateu 10
	call reset			;se bateu 10 reseta
	clrf unidade		;se nao apaga a unidade e volta a imprimir
	call imprime
	retfie
imprime:
	BANKSEL PORTC
	swapf dezena,1		;joga dezena para os bits mais significativos
 	movf  dezena,W		;joga em w
	addwf unidade,0		;soma com a dezena que ja estava em w
	movwf PORTC			;joga na saida
	swapf dezena,1		;volta a dezena para o estado original
	return


			
reset:						

	BANKSEL PORTC	
	clrf PORTC
	clrf unidade	
	clrf dezena
	return
	end




