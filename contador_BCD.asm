	org 0

zeraDezena:
	mov R1,#0

zeraUnidade: 
	mov R0,#0

exibir:
	mov A,r1
	swap A
	orl A,R0
	mov P1,A

rampa0:
	jnb P0.0, rampa1			   ;pula se o valor for 0	 (~JB)
	jmp rampa0

rampa1:
	jb P0.0, incrementa			  ;pula se o valor for 1
	jmp rampa1

incrementa:
	inc R0
	cjne R0, #10, exibir		      ;compara os dois primeiros parametros, caso for diferentes pula para o endereço
	inc R1 
	cjne R1, #10, zeraUnidade
	jmp zeraDezena

end
