	include <p16f877a.inc>
	org 0

	cblock 0x20		;declaracao de variaveis
	unidade
	dezena
	endc



	BANKSEL TRISC		; PORTC = saida
	CLRF TRISC
	BANKSEL PORTC

reset:			
			
	clrf unidade	
	clrf dezena
	clrf PORTC

inicio:

	call aguarda_rampa

unitario:
	movlw .9
	subwf unidade,W		;checa a condicao de mudanca de decimal
	btfsc STATUS,Z		;bit 2 do reg status
	goto decimal		;se zerou, precisa incrementar a dezena
	
	incf unidade,1		;incrementa unidade
	call imprime	
	goto inicio

decimal:
	incf dezena,1		
	movlw .10
	subwf dezena,W
	btfsc STATUS,Z		;checa se zerou, entao a dezena bateu 10
	goto reset			;se bateu 10 reseta
	clrf unidade		;se nao apaga a unidade e volta a imrpimir
	call imprime
	goto inicio

imprime:
	swapf dezena,1		;joga dezena para os bits mais significativos
	movf dezena,W		;joga em w
	addwf unidade,0		;soma com a dezena que ja estava em w
	movwf PORTC			;joga na saida
	swapf dezena,1		;volta a dezena para o estado original

	return
			
aguarda_rampa:
	
	btfsc PORTB,0		;garante que esta em 0 para poder subir			
	goto aguarda_rampa

subiu_rampa:	
	btfss PORTB,0		;depois do 0, checa se subiu
	goto subiu_rampa
	
	return

	end
