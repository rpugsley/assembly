; ARQUIVO: EXERC7.ASM ARQUIVO .COM
;Robson Pugsley e Franz Gustav Niederheitmann

COD	SEGMENT 
ASSUME	CS:COD,DS:COD,ES:COD,SS:COD
    
	ORG 0100H

EXERC7	PROC	NEAR
	
MAIN:    
	CLI                             ;DESABILITA INTERRUPCOES

        MOV AH,35H                      ;PEGA O ENDERECO DO VETOR DE INTERRUPCAO
        MOV AL,15H                      ;NUMERO DA INTERRUPCAO
        INT 21H                         ;RETORNA O HANDLER EM ES:BX
        MOV WORD PTR OldInt,BX          ;SALVA OS PRIMEIROS 16 BITS NA OldInt
        MOV WORD PTR OldInt+2,ES        ;SALVA OS ULTIMOS   16 BITS NA OldInt

        MOV AH,25H                      ;SETA NOVO ENDERECO DA INTERRUPCAO
        MOV AL,15H                      
        MOV DX,OFFSET CS:Novaint        ;NOVO HANDLER
        INT 21H                     

        MOV AH,31H
        MOV AL,00H
        MOV DX,OFFSET CS:MAIN           ;TERMINA E DEIXA RESIDENTE TSR

        STI                             ;HABILITA INTERRUPCOES
        INT	21H    

                  

Novaint:						
		PUSHF                      ;EMPILHA AS FLAGS

                
VIM:      
                CMP     AL,17H             ;VERIFICA SE E 'I'
                JNE     VI                 ;PULA PARA SE NAO FOR I
                MOV     AL,18H             ; MUDA PARA 'O'
                JMP     FIM
		
VI:             CMP     AL,18H             ;VERIFICA SE E 'O'
                JNE     FIM
                MOV     AL,17H             ; MUDA PARA 'I'
		JMP     FIM    


FIM:            POPF                            ;DESEMPILHA AS FLAGS
                JMP     CS:DWORD PTR OldInt     ;CALL ORIGINAL HANDLER


;************************* DADOS ********************************
OldInt		dd	?

EXERC7	ENDP 
COD	ENDS
END	EXERC7

