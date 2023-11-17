include <p16f876a.inc>



	org 0
	BANKSEL TRISC ; bank 1
	clrf TRISC; seta portc para saida
	BANKSEL PORTB ; bank 0 ; portb = entrada
	
inicio:
	btfss PORTB,0 ; testa bit 0 do portb, se estiver em 1 pula a proxima instrucao
	goto inverte_bit
	bsf PORTC,0	; liga o bit 0
	bcf PORTC,1	; desliga bit 1	
	goto inicio

inverte_bit:

	bcf PORTC,0	; desliga o bit 0
	bsf PORTC,1 ; liga o bit 1
	goto inicio
	




end

	
	


