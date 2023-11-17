;***************************************************************
;* programa: FIOASM.ASM onde esta sendo feito o ECO
;* le A/D e envia para o D/A , escrito em assembler
;***************************************************************
	.mmregs
	.file	"fioasm.asm"
; FUNCOES EXTERNAS para inicializar o KIT
	.global	_brd_init
; FUNCOES EXTERNAS DE ACESSO AO CONVERSOR A/D E D/A
	.global	_codec_open
	.global	_codec_dac_mode
	.global	_codec_adc_mode
	.global	_codec_ain_gain
	.global	_codec_aout_gain
	.global	_codec_sample_rate
; VARIAVEL HANDLER PARA FUNCOES DO A/D E D/A
	.global	_hHandset
	.bss	_hHandset,1
; VARIAVEL PARA LER E ESCREVER NO A/D E D/A
	.global	_data
	.bss	_data,1
	
; Buffer de dados para amostras	
_tambuf .set 07000h   ; define o tamanho da RAM para amostras 
	.bss	_buf,_tambuf ; reserva words para amostras
	.global _buf
	                                                   
; IDENTIFICA O INICIO DO CODIGO
    .global _main
;***************************************************************
;* inicio do programa                                          *
;***************************************************************
    .text
_main:
       ; INICIALIZA O HARDWARE DO KIT
    CALLD #_brd_init            ; 
    NOP
    LD #100,A                ; 

iniad:   
    ; inicializa A/D E D/A
    ; VAI ABRIR UM HANDLER PARA O CONVERSOR A/D E D/A  
    CALLD     #_codec_open          ; 
    NOP
    LD        #1,A                  ; 
    STL       A,*(_hHandset)        ; 
; VARIAVEL _hHANDSET RECEBE O NUMERO DO HANDLER

    ST        #1,*SP(0)             ; 
    CALL      #_codec_dac_mode      ; 1+15 bits 

    ST        #1,*SP(0)             ; 
    LD        *(_hHandset),A        ; 
    CALL      #_codec_adc_mode      ; 1+15 bits

    LD        *(_hHandset),A        ; 
    ST        #4,*SP(0)             ; 6 dB
    CALL      #_codec_ain_gain      ; 

    ST        #1,*SP(0)             ; -6 dB
    LD        *(_hHandset),A        ;
    CALL      #_codec_aout_gain     ; 

    ST        #0A0h,*SP(0)          ;  90h=16 KHz 
    LD        *(_hHandset),A        ;   0a0h = 8 KHz
    CALL      #_codec_sample_rate   ; 
; ************* termino das inicializacoes ******************
      
; define ponteiro para insercao memoria
    STM  #_buf, AR2    ; AR2 aponta para inicio do buffer   
    ;inicializacao dos ponteiros
	;AR2 = inicio do buffer=_buf
	STM  #0e000h,AR3;amostra antiga
	STM  #0d000h,AR4;amostra mais antiga
    ; buffer circular
    STM  #_tambuf, BK   ; BK = tamanho do buffer 
    STM  #1,AR0        ; INCREMENTO =AR0=1 NO BUFFER CIRCULAR 
     
     ; loop principal de espera de dado vindo do conversor A/D
WAIT:    
    STM  #48h,AR1      ; 48H SPSA1 SUB BANCO DO MCBSP1
    ST   #0,*AR1       ; ENDERECO 
    LD   #2,A          ;  
    STM  #49h,AR1      ; 49H SPSD1 SUB BANCO DO MCBSP1  
    LDU  *AR1,B        ; DADOS
    AND  B,A           ; 
    SFTL A,#0          ;  
    SFTL A,#-1,A       ; 
    NOP  
    LDM  AL,A          ; 
    BC   WAIT,AEQ      ; ENQUANTO NAO HOUVER CARRY 
                          ; FICA ESPERANDO, QUANDO SAIR DO LOOP
                          ; EH PORQUE CHEGOU DADO PELO A/D
; fim da espera de dado do A/D  *********************************

;  aqui inicia o codigo do programa principal 
; Le o dado do A/D
    STM  #41h,AR1       ; LE DRR11=41H REGISTRO DE DADOS
                                ; DA INTERFACE SERIAL 1 MCBSP1 
    LD *AR1,B                ; le dado no acumulador B
    STL B,*AR2+0%; ARMAZENA DADO NA MEMORIA USANDO BUFFER CIRCULAR
    ;LD B,A              
	;ECO
	;B=DADO ATUAL AR2=PONTEIRO DE INSERCAO
	;AR3=PONTEIRO ANTIGO
	;AR4=PONTEIRO MAIS ANTIGO
	
_eco:
    LD  *AR4+0%,A ; +0% LE AMOSTRA MAIS ANTIGA
	
	SFTA A,-1,A;-1 AMOSTRA + ANTIGA /4
	nop
	nop
	ADD *AR3+0%,A ; +0% AMOSTRA ANTIGA/2
	nop
	nop
	SFTA A,-1,A ;-1
	nop
	nop  
	         
	ADD  A,B,B ; B=AMOSTRA + NOVA SEM DIVIDIR
	
	;ECO =B ECO FIM
	;ENVIA O DADO DO ACUMULADOR B PARA O D/A

; Envia o dado do acumulador B para o D/A 
    STM  #43h,AR1  ; ESCREVE NO DXR11=43H REGISTRO 
                  ;  DE SAIDA DE DADOS DA SERIAL 1
    STL  B,*AR1
                  ;  MCBSP1
    B WAIT        ; VAI ESPERAR MAIS UM DADO 

; ********* fim do loop , volta para esperar outro dado do A/D

.end
