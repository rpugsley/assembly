	include <p16f876a.inc>



	org 0
	BANKSEL TRISC ; bank 1
	clrf TRISC; portc = saida
	BANKSEL PORTC ; bank 0

inicio:	
	movf PORTB,w ; joga valor de portb no w
	andlw 0F  ; desabilita os 4 ultimos bits para na pegar lixo 
	call tabela 
	movwf PORTC ; joga o valor de w na saida
	goto inicio
tabela:
	addwf PCL,1 ; soma o w no pcl fazendo pular w linhas de instrucao
	retlw B'00111111' ; 0 
	retlw B'00000110' ; 1 
	retlw B'01011011' ; 2 
	retlw B'01001111' ; 3
	retlw B'01100110' ; 4
	retlw B'01101101' ; 5
	retlw B'01111101' ;	6
	retlw B'00000111' ; 7
	retlw B'01111111' ; 8
	retlw B'01101111' ; 9
	retlw B'01110111' ; a 
	retlw B'01111100' ; b 
	retlw B'00111001' ; c 
	retlw B'01011110' ; d 
	retlw B'01111001' ; e 
	retlw B'01110001' ; f
end

	
	



	


