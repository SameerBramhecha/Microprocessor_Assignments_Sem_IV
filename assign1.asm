section .data
	msg1 db "Enter 5 64-bit numbers", 10
	len1 equ $-msg1
	newline db 10
	msg2 db "Entered 5 64-bit numbers are: ", 10
	len2 equ $-msg2
	count db 05

%macro print 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro

section .bss
	array resb 100

section .text
	global _start
	_start:

print 01,01,msg1,len1

;logic to read 5 64-bit numbers

mov rbx,array ;array base address is in rbx

up:;print 01,01,newline,01

print 00,00,rbx,17
add rbx,17
dec byte[count];dec count 
jnz up    ; 

mov byte[count],05       ; count is in bh

mov rbx,00                     ;array index

print 01,01,msg2,len2

up1:
 mov rax,01
 mov rdi,01
 mov rsi,array
 add rsi,rbx
 mov rdx,17
 syscall

 add rbx,17
 dec byte[count]      ; dec count
 jnz up1                    ; check count is 0 or not using zero flag i;





;exit syscall

mov rax, 60

mov rdi,00

syscall





	

