; ARQUIVO: EXERC1.ASM ARQUIVO .COM
;Robson Pugsley e Franz Gustav Niederheitmann
; TODOS OS SEGMENTOS SAO SUPERPOSTOS
;
;
;
COD SEGMENT
        ASSUME CS:COD, DS:COD, ES:COD, SS:COD
        ORG 0100H

EXERC1    PROC    NEAR            ;PROGRAMA PRINCIPAL ******
INICIO:
          MOV   AH,9            ;CONVITE PARA USUARIO
          LEA   DX,MENSAGEM
          INT   21H
          MOV   AH,08H          ; 0 . . . 9
          INT   21H             ;LE CARACTER DO USUARIO
          MOV   [DELTA],AL      ;SALVA EM DELTA
          MOV   AH,2FH		; jogando zero-1 para comparar
	  MOV     BH,39H          
	  CALL  COMPARA		; comparando
	
         
;
;----------------------------------------------------------

; ***************** SUBROTINA ******************************
COMPARA:
	
	CMP	AH,BH		;compara com o valor max de ah		
	JE	FIM		;entao nao era numero
	INC	AH		; incrementa ah para o proximo numero
	CMP     AL,AH		;compara o numero digitado (al) com proximo numero (ah)        	
	JE      MOSTRA		; se for igual a numero mostra
        JMP	COMPARA		;compara com o proximo numero
   
MOSTRA:

        LEA     BX,DELTA
        MOV     DL,0AH          
        MOV     AH,2            
        INT     21H             ;ENVIA NOVA-LINHA P/TELA
        MOV     DL,0DH          ; 0DH INICIO DA LINHA
        MOV     AH,2
	INT     21H

	MOV     DL,[BX]
        MOV     AH,02H
        INT     21H             ;MOSTRA CARACTER NA TELA
        

FIM:    MOV     AX,4C00H            ;RETORNA AO DOS
        INT     21H

;********************* DADOS *********************************
MENSAGEM DB     'DIGITE UM NUMERO:$'
DELTA    DB      0       ;       VALOR DIGITADO PELO USUARIO
EXERC1   ENDP
COD      ENDS
         END EXERC1


