                                
	include <p16f876a.inc>

	CBLOCK	0x20
	dezena
	unidade

	ENDC

	org 	0
	goto 	inicio

	org 	4
	goto 	incrementa

inicio:

	BANKSEL OPTION_REG
	bsf		OPTION_REG,6	;seta INT0 para rampa ascendente

	BANKSEL INTCON  		;habilitando as interrupçoes
	bsf 	INTCON,7		;habilita todas as interrupcoes
	bsf 	INTCON,4		;habilita INT0
	

	BANKSEL TRISB
	clrf 	TRISB				
	bsf		TRISB,0			;PORTB[1..2] = E , RS(Saidas)  PORTB[0]= INT

	BANKSEL TRISC
	clrf 	TRISC			;PORTC = dados/instrucoes
	BANKSEL PORTC
	clrf 	PORTC			;Zera a porta
	
	clrf 	dezena
	clrf 	unidade

configura_lcd:
	bcf		PORTB,2			;enviar instrucao
	movlw	0x0C			;liga o display sem cursor
	movwf	PORTC
	call 	pulso_enable
	movlw	0x38			;configura como entrada 8 bits, 2 linhas
	movwf	PORTC
	call 	pulso_enable
	call	limpa_lcd
	call 	imprime
	call	espera_interrupcao

espera_interrupcao:
	call 	espera_interrupcao

limpa_lcd:
	movlw	0x03			;apaga e volta cursor
	movwf	PORTC
	bcf		PORTB,2			;enviar instrucao
	call 	pulso_enable

pulso_enable:				;manda um pulso no enable
	bsf		PORTB,1		
	bcf		PORTB,1
	return

incrementa:
	bcf 	INTCON,1		;apaga a flag gerado pela interrupcao

unitario:
	movlw 	.9
	subwf 	unidade,W		;checa a condicao de mudanca de decimal
	btfsc 	STATUS,Z		;bit 2 do reg status
	goto 	decimal			;se zerou, precisa incrementar a dezena	
	incf 	unidade,1		;incrementa unidade
	call 	imprime
	retfie	


decimal:
	incf 	dezena,1		
	movlw 	.10
	subwf 	dezena,W
	btfsc 	STATUS,Z		;checa se zerou, entao a dezena bateu 10
	goto 	reset			;se bateu 10 reseta
	clrf 	unidade			;se nao apaga a unidade e volta a imrpimir
	call 	imprime
	retfie

reset:
	clrf	unidade
	clrf	dezena
	call    imprime
	retfie

imprime:
	call 	limpa_lcd
	bsf		PORTB,2			;seta pra mandar caracter
	movf 	unidade,W		;joga em w
	addlw	.48				;soma 48 para ajeitar na tabela ASCII
	movwf 	PORTC			;joga na saida
	call	pulso_enable
	movf 	dezena,W		;joga em w
	addlw	.48				;soma 48 para ajeitar na tabela ASCII
	movwf 	PORTC			;joga na saida
	call	pulso_enable
	return


	END

