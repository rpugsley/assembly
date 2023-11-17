; ARQUIVO: EXERC5.ASM ARQUIVO .COM
;Robson Pugsley e Franz Gustav Niederheitmann
; TODOS OS SEGMENTOS SAO SUPERPOSTOS

COD SEGMENT
        ASSUME CS:COD, DS:COD, ES:COD, SS:COD
        ORG 0100H


EXERC5  PROC    NEAR            	    ; programa principal

    mov     dx,OFFSET FileName      	; coloca o endereco do aqruivo em dx
    mov     al,0 		                ; mode de acesso somente leitura
    mov     ah,3Dh 		                ; funcao para abrir arquivo
    int     21h 		                

    mov     Handle,ax 		            ; save o handle em uma variavel
    jc      ErrorOpening 	            ; pula se o carry estiver setado, caso de erro ao abrir o arquivo
NextChar:
    mov     dx,offset Buffer 	        ; endereco do buffer em dx
    mov     bx,Handle 	            	; handle em bx
    mov     cx,1                        ; quantidade de bytes a ler
    mov     ah,3Fh 		                ; funcao de ler arquivo
    int     21h 		                
    jc      ErrorReading 	            ; pula se o carry estiver setado, caso de erro ao ler o arquivo
                    
    cmp     ax,cx                       ; caso o texto chegue ao fim (aqui ele nao le nenhum caracter)
    jne      fim
    mov     cx,1                        ; tamanho da string em bytes
    mov     si,OFFSET Buffer 	        ; endereco da string vai para si

    lodsb 			                    ; carrega o proximo byte em AL

    call    compara                     ; funcao que compara que tipo de caracter eh
    inc     total                       ; incrementa o total de caracteres
com_cr:
    jmp     NextChar                    ; loop
    
fim:
    mov     bx,Handle 		            ; coloca o handle em bx 
    mov     ah,3Eh 		                ; funcao para fechar o arquivo
    int     21h 		                
    call    porcentagem                 
    call    imprime
    mov     ax,4C00h 		            ; volta para o dos
    int     21h    

imprime:                                ; imprime os valores encontrados
    mov     dx,offset Num_as            ; mostra mensagem 
    mov     ah,09h 		                
    int     21h
    and     ax,0                        ; para garantir que nao haja lixo               		                
    mov     al,pa
    call    DecPrint                    ; chama funcao q mostra a porcentagem em int
    mov     dx,25h                      ; mostra %
    mov     ah,06h 		                
    int     21h  
	lea     dx,espaco                   ; espaco
    mov     ah,09h 		                
    int     21h   
    mov     ax,a
    call    DecPrint                    ; chama funcao q mostra int
    mov     dx,2Fh                      ; '/'
    mov     ah,06h 		                
    int     21h 
    mov     ax,total
    call    DecPrint                    ; chama funcao q mostra int
    
    mov     dx,offset Num_es            ; mostra mensagem 
    mov     ah,09h 		                
    int     21h               		                
    and     ax,0                        ; para garantir que nao haja lixo               		                
    mov     al,pe
    call    DecPrint                    ; chama funcao q mostra a porcentagem em int
    mov     dx,25h                      ; mostra %
    mov     ah,06h 		                
    int     21h  
	lea     dx,espaco                   ; espaco
    mov     ah,09h 		                
    int     21h   
    and     ax,0h                       ; para nao ir lixo para a funcao
    mov     ax,e
    call    DecPrint                    ; chama funcao q mostra int
    mov     dx,2Fh                      ; '/'
    mov     ah,06h 		                
    int     21h 
    mov     ax,total
    call    DecPrint                    ; chama funcao q mostra int
        
    mov     dx,offset Num_is            ; mostra mensagem 
    mov     ah,09h 		                
    int     21h               		                
    and     ax,0                        ; para garantir que nao haja lixo               		                
    mov     al,pi
    call    DecPrint                    ; chama funcao q mostra a porcentagem em int
    mov     dx,25h                      ; mostra %
    mov     ah,06h 		                
    int     21h  
	lea     dx,espaco                   ; espaco
    mov     ah,09h 		                
    int     21h   
    mov     ax,i
    call    DecPrint                    ; chama funcao q mostra int
    mov     dx,2Fh                      ; '/'
    mov     ah,06h 		                
    int     21h 
    mov     ax,total
    call    DecPrint                    ; chama funcao q mostra int
        
    mov     dx,offset Num_os            ; mostra mensagem 
    mov     ah,09h 		                
    int     21h               		                
    and     ax,0                        ; para garantir que nao haja lixo               		                    
    mov     al,po
    call    DecPrint                    ; chama funcao q mostra a porcentagem em int
    mov     dx,25h                      ; mostra %
    mov     ah,06h 		                
    int     21h  
	lea     dx,espaco                   ; espaco
    mov     ah,09h 		                
    int     21h   
    mov     ax,o
    call    DecPrint                    ; chama funcao q mostra int
    mov     dx,2Fh                      ; '/'
    mov     ah,06h 		                
    int     21h 
    mov     ax,total
    call    DecPrint                    ; chama funcao q mostra int
        
    mov     dx,offset Num_us            ; mostra mensagem 
    mov     ah,09h 		                
    int     21h               		                
    and     ax,0                        ; para garantir que nao haja lixo               		                    
    mov     al,pu
    call    DecPrint                    ; chama funcao q mostra a porcentagem em int
    mov     dx,25h                      ; mostra %
    mov     ah,06h 		                
    int     21h  
	lea     dx,espaco                   ; espaco
    mov     ah,09h 		                
    int     21h   
    mov     ax,u
    call    DecPrint                    ; chama funcao q mostra int
    mov     dx,2Fh                      ; '/'
    mov     ah,06h 		                
    int     21h 
    mov     ax,total
    call    DecPrint                    ; chama funcao q mostra int
        
    mov     dx,offset Num_spaces        ; mostra mensagem 
    mov     ah,09h 		                
    int     21h               		                
    and     ax,0                        ; para garantir que nao haja lixo               		                
    mov     al,pspace
    call    DecPrint                    ; chama funcao q mostra a porcentagem em int
    mov     dx,25h                      ; mostra %
    mov     ah,06h 		                
    int     21h  
	lea     dx,espaco                   ; espaco
    mov     ah,09h 		                
    int     21h   
    mov     ax,space
    call    DecPrint                    ; chama funcao q mostra int
    mov     dx,2Fh                      ; '/'
    mov     ah,06h 		                
    int     21h 
    mov     ax,total
    call    DecPrint                    ; chama funcao q mostra int    
    
    ret  
    
DecPrint:
    mov     dx,0                        ; must do 32-bit divide, or could overflow
    mov     bx,10
    div     bx                          ; ax = quotient, dx = remainder
    and     ax,ax                       ; if quotient is 0, don't need to print another level
    je      finish
    push    dx                          ; recursive call to self
    call    DecPrint
    pop     dx
finish:
    add     dl,'0'                      ; convert to ASCII
    mov     ah,06                       ; DOS char print
    int     21h
    
    ret

porcentagem:                            ; funcao que calcula as porcentagens    
    mov     cx,0000h
    sub	    cx,total
    jz      zero 

    mov     ax,100
    mul     a
    div     total     
    and     ax,00FFh                    ; para garantir que nao haja lixo               		                
    mov     pa,al

    mov     ax,100
    mul     e
    div     total     
    and     ax,00FFh                    ; para garantir que nao haja lixo   
    mov     pe,al

    mov     ax,100
    mul     i
    div     total     
    and     ax,00FFh                    ; para garantir que nao haja lixo       
    mov     pi,al

    mov     ax,100
    mul     o
    div     total     
    and     ax,00FFh                    ; para garantir que nao haja lixo
    mov     po,al

    mov     ax,100
    mul     u
    div     total     
    and     ax,00FFh                    ; para garantir que nao haja lixo
    mov     pu,al

    mov     ax,100
    mul     space
    div     total     
    and     ax,00FFh                    ; para garantir que nao haja lixo
    mov     pspace,al
zero:
    ret

compara:  
    mov     cl,41h
    sub	    cl,al
    jz      encontrou_a 
    
    mov     cl,45h
    sub	    cl,al
    jz      encontrou_e
    
    mov     cl,49h
    sub	    cl,al
    jz      encontrou_i 
    
    mov     cl,4Fh
    sub	    cl,al
    jz      encontrou_o
    
    mov     cl,55h
    sub	    cl,al
    jz      encontrou_u
    
    mov     cl,61h
    sub	    cl,al
    jz      encontrou_a 
    
    mov     cl,65h
    sub	    cl,al
    jz      encontrou_e
            
    mov     cl,69h
    sub	    cl,al
    jz      encontrou_i 
    
    mov     cl,6Fh
    sub	    cl,al
    jz      encontrou_o
    
    mov     cl,75h
    sub	    cl,al
    jz      encontrou_u  
    
    mov     cl,20h
    sub	    cl,al
    jz      encontrou_space  
    
    mov     cl,0Dh
    sub	    cl,al
    jz      com_cr
       
    mov     cl,0Ah
    sub	    cl,al
    jz      com_cr    
    
    ret

  
encontrou_a:
    inc     a     
    ret     
encontrou_e:
    inc     e     
    ret 
encontrou_i:
    inc     i     
    ret     
encontrou_o:
    inc     o    
    ret 
encontrou_u:
    inc     u     
    ret     
encontrou_space:
    inc     space     
    ret 


ErrorOpening:
    mov     dx,offset OpenError             ; mostra mensagem de erro 
    mov     ah,09h 		                    
    int     21h 		                    
    mov     ax,4C00h 		                ; volta para o dos
    int     21h 

ErrorReading:
    mov     dx,offset ReadError             ; mostra mensagem de erro 
    mov     ah,09h 		                    
    int     21h 		                    
    mov     ax,4C00h 		                ; volta para o dos
    int     21h




;***************************************************************************;

cr	    equ	0dh                             ;carriage return
lf	    equ	0ah                             ;line feed



Handle DW ? 			                    ; file handle
FileName DB         "teste.txt",0 	        ; arquivo a ser aberto
OpenError DB        "An error has occured(opening)!$"
ReadError DB        "An error has occured(reading)!$" 
Num_as DB           "Numero de A encontrado no texto: $"
espaco DB           "       $"
Num_es DB           cr,lf,"Numero de E encontrado no texto: $"
Num_is DB           cr,lf,"Numero de I encontrado no texto: $"
Num_os DB           cr,lf,"Numero de O encontrado no texto: $"
Num_us DB           cr,lf,"Numero de U encontrado no texto: $"
Num_spaces DB       cr,lf,"Numero de Espacos encontrado no texto: $"

a		    DW 	00h
e		    DW	00h
i		    DW	00h
o		    DW	00h
u		    DW	00h
space		DW	00h

total       DW  00h
pa		    DB 	00h
pe		    DB	00h
pi		    DB	00h
po		    DB	00h
pu		    DB	00h
pspace      DB	00h

Buffer      DW 0h dup (?) 	                ; buffer


EXERC5  ENDP 
COD	    ENDS
END	    EXERC5

END
