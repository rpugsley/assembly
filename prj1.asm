org 0
	jmp inicio
org 3
contador:
	add a,#1
	da a
	mov p1,a
	reti

inicio:
	mov a,#0
	mov p1,a
	mov ie,#10000001b

pingpong:
	mov p2, #128d
	mov p2, #64d
	mov p2, #32d
	mov p2, #16d
	mov p2, #8d
	mov p2, #4d
	mov p2, #2d
	mov p2, #1d
	mov p2, #2d
	mov p2, #4d
	mov p2, #8d
	mov p2, #16d
	mov p2, #32d
	mov p2, #64d
	jmp pingpong
	
	end 