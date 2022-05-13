section .data
	op dq 0000000000000005h,0000000000000003h
	msg1 db "Addition is: ",10
	len1 equ $-msg1
	msg2 db "Subtraction is: ",10
	len2 equ $-msg2
	nl db " ",10
	ln equ $-nl	
	msg3 db "Multiplication is: ",10
	len3 equ $-msg3
	msg4 db "Division Quotient is: ",10
	len4 equ $-msg4
section .bss
	var resb 16

section .text
	global _start
	_start:

%macro print 02
mov rax,01
mov rdi,01
mov rsi,%1
mov rdx,%2
syscall
%endmacro


print msg1,len1
call addition
print nl,ln

print msg2,len2
call subtraction
print nl,ln

print msg3,len3
call multiplication
print nl,ln

print msg4,len4
call division
print nl,ln


;exit syscall
mov rax,60
mov rdi,00
syscall

addition:
	mov rsi,op
	mov rax,[rsi]
	add rsi,8
	mov rbx,[rsi]
	add rax,rbx;addition stored in rax
	call hta
ret

subtraction:
	mov rsi,op
	mov rax,[rsi]
	add rsi,8
	mov rbx,[rsi]
	sub rax,rbx;subtraction stored in rax
	call hta
ret

multiplication:
	mov rsi,op
	mov rax,[rsi]
	add rsi,8
	mov rbx,[rsi]
	mul rbx;in multiplication operand is multiplied with the content of rax
	call hta
ret

division:
	mov rsi,op
	mov rax,[rsi]
	add rsi,8
	mov rbx,[rsi]
	xor rdx,rdx
	div rbx;division is stored in rbx
	mov rbx,rdx;division remainder
	call hta
	print nl,ln
	mov rax,rdx
	;call hta
ret

hta:
	mov rsi,var
	mov cl,16
	l1: 
		rol rax,04h
		mov bl,al
		and bl,0Fh
		cmp bl,09h
		jbe l
		add bl,07h
		l: add bl,30h
		mov [rsi],bl
		inc rsi
		dec cl
		jnz l1
	print var,16
ret

