; ARQUIVO: EXERC2.ASM ARQUIVO .COM
;Robson Pugsley e Franz Gustav Niederheitmann
; TODOS OS SEGMENTOS SAO SUPERPOSTOS

COD SEGMENT
        ASSUME CS:COD, DS:COD, ES:COD, SS:COD
        ORG 0100H

EXERC2    	PROC    NEAR            			;PROGRAMA PRINCIPAL 
INICIO:
          	MOV   	AH,09H            			;CONVITE PARA USUARIO
          	LEA   	DX,MENSAGEM
          	INT   	21H

		  	MOV   	CX,00H						; Zerando contador da pilha
EMPILHA:  	
			MOV   	AH,01H         				; Mostra caracter digitado
          	INT   	21H
			PUSH  	AX							; empilha o dado que esta no registrador AX
        	INC   	CX							; incrementa CX, contador da pilha.Indicando quantos caracteres tem a frase
			MOV   	BL,0DH						; move para BL o valor do enter
			SUB   	BL,AL						; Subtrai AL de BL, armazenando o valor em BL  
			JZ 	  	FIM_PILHA 					; Se caso for enter o ultimo caracter digitado, comeca e 
			JMP   	EMPILHA						; caso nao seja o fim da frase, continua empilhando

FIM_PILHA:
			MOV 	AH,06H						; funcao DOS para leitura de caracter no console	
			MOV		DL,0AH  					; codigo ascii do line feed(pula uma linha)
			INT		21H							 
			MOV		AH,06H						; funcao DOS para leitura de caracter no console
			MOV 	DL,0DH  					; codigo ascii do carriage return(volta para o comeco)
			INT		21H							; exibir
DESEMPILHA:
			POP 	DX							; Tira da pilha o ultimo caracter inserido
			MOV 	AH,02H 						; funcao DOS para exibir caracter
			INT 	21H 						; exibir	
			LOOP 	DESEMPILHA					; desempilha ate a pilha ficar vazia

			MOV 	AX,4C00H					; RETORNA AO DOS
			INT 	21H							; exibir


;********************* DADOS *********************************
MENSAGEM 	DB     'DIGITE UMA FRASE: $'
DELTA    	DB      0       					; VALOR DIGITADO PELO USUARIO
EXERC2   	ENDP
COD      	ENDS
END EXERC2