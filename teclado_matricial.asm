org 0; P2 = pino 4 e 6 do lcd         P3 = Dados[7..0] lcd   P1= Teclado matricial

liga_lcd:
mov p2,#0		;deixa desabilitado e pronto para mandar instrucoes
mov p3,#12      ;liga lcd e deixa cursor apagado
mov p2,#2		;pulso para mandar instrucoes
mov p2,#0		;deixa desabilitado e pronto para mandar instrucoes
mov p3,#38h     ;modo com 2 linhas e interface 8bits
mov p2,#2		;pulso para mandar instrucoes
mov p2,#0		;deixa desabilitado e pronto para mandar instrucoes
mov p3,#1       ;clear display
mov p2,#2		;pulso para mandar instrucoes
mov p2,#0		;deixa desabilitado e pronto para mandar instrucoes

pressionado:
mov p1,#0Fh		
mov a,p1
subb a,#0Fh
jz get
jmp pressionado

get:
mov p1,#3Fh		;testa primeira coluna
mov a,p1
subb a,#3Eh
jz um
mov a,p1
subb a,#3Dh
jz quatro
mov a,p1
subb a,#3Ch
jz sete
mov a,p1
subb a,#3Bh
jz estrela
mov p1,#5Fh		;testa segunda coluna		
mov a,p1
subb a,#5Eh
jz dois
mov a,p1
subb a,#5Dh
jz cinco
mov a,p1
subb a,#5Ch
jz oito
mov a,p1
subb a,#5Bh
jz zero
mov p1,#6Fh		;testa terceira coluna		
mov a,p1
subb a,#6Eh
jz tres
mov a,p1
subb a,#6Dh
jz seis
mov a,p1
subb a,#6Ch
jz nove
mov a,p1
subb a,#6Bh
jz apaga_tela
jmp get

escreve:
add a,#40		;soma mais 40 para deixar nos algarismos numericos da table ascii 
mov p3,a		;manda dezena para o display
mov p2,#3       ;pulso para mandar dados para a tela
mov p2,#1       ;modo para mandar dados para a tela, porem esta desabilitado

um:
mov a,#9
dois:
mov a,#10
tres:
mov a,#11
quatro:
mov a,#12
cinco:
mov a,#13
seis:
mov a,#14
sete:
mov a,#15
oito:
mov a,#16
nove:
mov a,#17
zero:
mov a,#8
estrela:
mov a,#2

apaga_tela:
mov p2,#0	;habilita para mandar instrucao
mov p3,#2	;manda cursor voltar para primeira posicao
mov p2,#2	;pulso para mandar instrucoes
mov p2,#0	;deixa desabilitado e pronto para mandar instrucoes
mov p3,#1   ;clear display
mov p2,#2	;pulso para mandar instrucoes
mov p2,#0	;deixa desabilitado e pronto para mandar instrucoes


end



