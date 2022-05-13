;Assignment Number 5 MPL:
;Write an X86 ALP to perform non-overlapped block transfer of data using string instructions

section .data

	count db 05
	count1 db 05
	arr1 db 31h,32h,33h,34h,35h
	msg1 db "Array 1: ",10
	len1 equ  $-msg1
	msg2 db "Array 2: ",10
	len2 equ $-msg2
	nl db '' ,10
	ln equ $-nl

section .bss
	arr2 resb 20
	disparr resb 20

section .text
	global _start:
	_start:

%macro print 02
mov rax,01
mov rdi,01
mov rsi,%1
mov rdx,%2
syscall
%endmacro

mov rsi,arr1
mov rdi,arr2
cld
mov cx,05
rep movsb 

print msg2,len2
mov rsi,arr2
b:
mov rax,[rsi]
push rsi
call hta
print nl,ln
pop rsi
inc rsi
dec byte[count1]
jnz b

;exit syscall
mov rax,60
mov rdi,00
syscall

hta:
	mov rsi,disparr+1
	mov rcx,2
	l1: 
		mov rdx,0
		mov rbx,10h
		div rbx
		cmp dl,09h
		jbe l
		add dl,07h
		l: add dl,30h
		mov [rsi],dl
		dec rsi
		dec rcx
		jnz l1
	print disparr,2
ret

