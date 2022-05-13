section .data
	msg db 'Enter a string',10
	len equ $-msg
	msg2 db 'Length of entered string is',10
	len2 equ $-msg2
section .bss
	strn resb 100   ;reserve memory for accepted string
	strleng resb 2  ;reserve memory for lenght of accepted string

section .text
	global _start
	_start:

;macro for printing
%macro print 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro


;display msg
print 01,01,msg,len

;read string
print 00,00,strn,20

;string will return in rax register
;hex to ascci for  printing
	cmp rax,09     ;compares rax and 09
	jbe l1	       ;jumps to label l1	
	add al,07h	;add no 07h to al
	l1:add al,30h  ; label l1 adds 30h(i.e ascii code for digit 0 )
	mov [strleng] , al ;mov leng to str_len varaible for printing

;display msg
print 01,01,msg2,len2

;print length
print 01,01,strleng,2

;exit syscall

mov rax,60
mov rdi,00
syscall

