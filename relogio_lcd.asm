org 0

seta_timer:
mov tmod,#2		;seta timer modo 2 (16bits auto reload)
mov tcon,#10h   ;habilita timer0
mov th0,#6      ;3khz/12=250 pulsos para dar um segundo

liga_lcd:
mov p2,#0		;deixa desabilitado e pronto para mandar instrucoes
mov p1,#12      ;liga lcd e deixa cursor apagado
mov p2,#2		;pulso para mandar instrucoes
mov p2,#0		;deixa desabilitado e pronto para mandar instrucoes
mov p1,#38h     ;modo com 2 linhas e interface 8bits
mov p2,#2		;pulso para mandar instrucoes
mov p2,#0		;deixa desabilitado e pronto para mandar instrucoes
mov p1,#1       ;clear display
mov p2,#2		;pulso para mandar instrucoes
mov p2,#0		;deixa desabilitado e pronto para mandar instrucoes

reset_hora:
mov r2,#0

reset_minuto:
mov r1,#0

reset_segundo:
mov r0,#0

manda_horas:
mov a,r2		;manda as horas pro acumulador
mov b,#10		;usar o registrador b para fazer divisao
div ab          ;divide hora por 10, para ter os dois algarismos, onde a vai ser o quociente(dezena) e o b vai ser a resto(unidade)
add a,#48		;soma mais 48 para deixar nos algarismos numericos da table ascii 
mov p1,a		;manda dezena para o display
mov p2,#3       ;pulso para mandar dados para a tela
mov p2,#1       ;modo para mandar dados para a tela, porem esta desabilitado
mov a,b			;manda o resto para o acumulador
add a,#48		;soma mais 48 para deixar nos algarismos numericos da table ascii
mov p1,a		;manda unidade para o display
mov p2,#3       ;pulso para mandar dados para a tela
mov p2,#1       ;modo para mandar dados para a tela, porem esta desabilitado
call manda_pontos
jmp manda_minutos

manda_pontos:
mov a,#58		;manda ":"
mov p1,a
mov p2,#3       ;pulso para mandar dados para a tela
mov p2,#1       ;modo para mandar dados para a tela, porem esta desabilitado
ret

manda_minutos:
mov a,r1		;manda os minutos pro acumulador
mov b,#10		;usar o registrador b para fazer divisao
div ab          ;divide minutos por 10, para ter os dois algarismos, onde a vai ser o quociente(dezena) e o b vai ser a resto(unidade)
add a,#48		;soma mais 48 para deixar nos algarismos numericos da table ascii 
mov p1,a		;manda dezena para o display
mov p2,#3       ;pulso para mandar dados para a tela
mov p2,#1       ;modo para mandar dados para a tela, porem esta desabilitado
mov a,b			;manda o resto para o acumulador
add a,#48		;soma mais 48 para deixar nos algarismos numericos da table ascii
mov p1,a		;manda unidade para o display
mov p2,#3       ;pulso para mandar dados para a tela
mov p2,#1       ;modo para mandar dados para a tela, porem esta desabilitado
call manda_pontos

manda_segundos:
mov a,r0		;manda os segundos pro acumulador
mov b,#10		;usar o registrador b para fazer divisao
div ab          ;divide segundos por 10, para ter os dois algarismos, onde a vai ser o quociente(dezena) e o b vai ser a resto(unidade)
add a,#48		;soma mais 48 para deixar nos algarismos numericos da table ascii 
mov p1,a		;manda dezena para o display
mov p2,#3       ;pulso para mandar dados para a tela
mov p2,#1       ;modo para mandar dados para a tela, porem esta desabilitado
mov a,b			;manda o resto para o acumulador
add a,#48		;soma mais 48 para deixar nos algarismos numericos da table ascii
mov p1,a		;manda unidade para o display
mov p2,#3       ;pulso para mandar dados para a tela
mov p2,#1       ;modo para mandar dados para a tela, porem esta desabilitado

cursor_home:
mov p2,#0		;habilita para mandar instrucao
mov p1,#2		;manda cursor voltar para primeira posicao
mov p2,#2		;pulso para mandar instrucoes
mov p2,#0		;deixa desabilitado e pronto para mandar instrucoes

espera_segundo:
mov a,tcon
anl a,#30h		;faz and com tcon para ver se deu overflow no timer0

cjne a,#30h,espera_segundo	;se nao passou segundo fica retestando
mov tcon,#10h   ;habilita timer0

incrementa_segundos:
inc r0			;incrementa segundo
mov a,r0
subb a,#60		;subtrai de 60 para ver se estourou os segundos
jz incrementa_minutos	;se chegou a 60 incrementa minutos
jmp manda_horas	;se nao, exibe relogio

incrementa_minutos:
inc r1			;incrementa minutos
mov a,r1
subb a,#60		;subtrai de 60 para ver se estourou os minutos
jz incrementa_horas	;se chegou a 60 incrementa horas
jmp reset_segundo	;se nao, apaga os segundos e exibe o relogio

incrementa_horas:	 
inc r2			;incrementa horas
mov a,r2	
subb a,#24		;subtrai de 24 para ver se estourou as horas
jz reset		;se estourou, reinicia o relogio com 0 horas
jmp reset_minuto;se nao, incrementa hora e reseta minutos

reset:
jmp reset_hora

end











