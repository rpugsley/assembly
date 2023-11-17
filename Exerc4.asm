; ARQUIVO: EXERC4.ASM ARQUIVO .COM
;Robson Pugsley e Franz Gustav Niederheitmann
; TODOS OS SEGMENTOS SAO SUPERPOSTOS

COD SEGMENT
        ASSUME CS:COD, DS:COD, ES:COD, SS:COD
        ORG 0100H

EXERC4  PROC    NEAR            			;PROGRAMA PRINCIPAL 

        test_caps:                          ;TESTA CAPS LOCK
        MOV     AH,02h	                    ;INTERRUPCAO DO TECLADO
        INT     16h
        MOV     BL, AL		                ;PEGA AS FLAGS DO TECLADO E JOGA PRA BL
        AND     BL, 64d	                    ;FAZ AND COM UMA MACASCARA PARA PODER MEXER COM OS BITS DO CAPS LOCK
        CMP     BL, 64d	                    ;CASO O BIT 6 ESTEJA HABILITADO, O CAPS LOCK ESTA LIGADO
        JNZ     caps_off                	;SE ELE NAO ESTIVER HABILITADO, PULA PRA CAPS OFF
        
        caps_on:		                    ;MOSTRA CAPS LIGADO
        MOV     AH,09h
        MOV     DX,offset caps              ;MOSTRA A MENSAGEM DE CAPS LIGADO
        INT     21h		                   
        JMP     test_num	                ;PULA PARA O PROXIMO TESTE
        caps_off:		                    ;MOSTRA CAPS DESLIGADO
        MOV     AH,09h
        MOV     DX,offset capsoff           ;MOSTRA A MENSAGEM DE CAPS DESLIGADO
        INT     21h		                    
        
        
        test_num:		                    ;TESTA NUM LOCK
        MOV     AH, 02h	                    ;INTERRUPCAO DO TECLADO
        INT     16h
        MOV     BL,AL		                ;PEGA AS FLAGS DO TECLADO E JOGA PRA BL
        AND     BL, 32d	                    ;FAZ AND COM UMA MACASCARA PARA PODER MEXER COM OS BITS DO NUM LOCK
        CMP     BL, 32d	                    ;CASO O BIT 5 ESTEJA HABILITADO, O NUM LOCK ESTA LIGADO
        JNZ     num_off	                    ;SE ELE NAO ESTIVER HABILITADO, PULA PRA NUM OFF
        
        num_on:		                        ;MOSTRA NUMLOCK LIGADO
        MOV     AH,09h
        MOV     DX,offset num
        INT     21h		                    ;MOSTRA A MENSAGEM DE NUM LIGADO
        JMP     test_scro	                ;PULA PARA O PROXIMO TESTE
        
        num_off:		                    ;MOSTRA NUMLOCK DESLIGADO
        MOV     AH,09h
        MOV     DX,offset numoff            ;MOSTRA A MENSAGEM DE NUM DESLIGADO
        INT     21h		                    
        
        
        test_scro:		                    ;TESTA SCROLL LOCK
        MOV     AH, 02h                 	;INTERRUPCAO DO TECLADO
        INT     16h
        MOV     BL,AL		                ;PEGA AS FLAGS DO TECLADO E JOGA PRA BL
        AND     BL, 16d	                    ;FAZ AND COM UMA MACASCARA PARA PODER MEXER COM OS BITS DO SCROLL LOCK
        CMP     BL, 16d	                    ;CASO O BIT 4 ESTEJA HABILITADO, O SCROLL LOCK ESTA LIGADO
        JNZ     scro_off	                ;SE ELE NAO ESTIVER HABILITADO, PULA PRA SCROLL OFF
        
        scro_on:		                    ;MOSTRA SCROLL LOCK LIGADO
        MOV     AH,09h
        MOV     DX,offset scro              ;MOSTRA A MENSAGEM DE SCROLL LIGADO
        INT     21H		                    
        JMP     fim		                    ;COM O FIM DOS TESTES, PULA PARA O FIM
        
        scro_off:		                    ;MOSTRA SCROLL LOCK DESLIGADO					
        MOV     AH,09h
        MOV     DX,offset scrooff           ;MOSTRA A MENSAGEM DE SCROLL DESLIGADO
        INT     21h						    
        
        
        fim:
        MOV     AX,4C00h                    ;SAI DO PROGRAMA E RETORNA AO DOS
        INT     21h       					


cr	    equ	0dh                             ;PARA FAZER UM CARRIAGE RETURN
lf	    equ	0ah                             ;PARA FAZER UM LINE FEED


caps    db 'CAPS LOCK---LIGADO',cr,lf,'$'	;MENSAGEM DO CAPS LOCK ON
num     db 'NUM LOCK----LIGADO',cr,lf,'$'	;MENSAGEM DO NUM LOCK ON
scro    db 'SCROLL LOCK-LIGADO',cr,lf,'$'	;MENSAGEM DO SCROLL LOCK ON
capsoff db 'CAPS LOCK---DESLIGADO',cr,lf,'$';MENSAGEM DO CAPS LOCK OFF
numoff  db 'NUM LOCK----DESLIGADO',cr,lf,'$';MENSAGEM DO NUM LOCK OFF
scrooff db 'SCROLL LOCK-DESLIGADO',cr,lf,'$';MENSAGEM DO SCROLL LOCK OFF


EXERC4  ENDP 
COD	    ENDS
END	    EXERC4


