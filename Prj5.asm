include <p16f876a.inc>

inicio:
	org 0
	BANKSEL TRISB ; bank 1 
	CLRF TRISB ; seta RB0 = saida
	BANKSEL PORTB ; bank 0
	MOVLW 0 	
	MOVWF PORTB	 ; zera o Portb

contador:
	INCF PORTB,1  ; incrementa portb
	goto contador  ;loop do contador
	end
