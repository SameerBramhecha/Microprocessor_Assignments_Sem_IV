;Assignment No 3 MPL 
;Count number of positive and negative numbers from a given array
section .data
	array db 10h,-20h,-03h,05h,30h
	nl db '',10
	len equ $-nl
	msg1 db "Positive nos are: ",10
	len1 equ $-msg1
	msg2 db "Negative nos are: ",10
	len2 equ $-msg2
	
section .bss 
	count resb 02
	poscount resb 10
	negcount resb 10
	
section .text
	global _start
	_start:
	
%macro print1 02
mov rax,01
mov rdi,01
mov rsi,%1
mov rdx,%2
syscall
%endmacro

mov byte[count],05
mov byte[poscount],00
mov byte[negcount],00
mov rsi,array

up:
	mov bl,[rsi]
	add bl,00h
	js l1
	inc byte[poscount]
	jmp l2
	l1: inc byte[negcount]
	l2: inc rsi
	dec byte[count]
	jnz up
	
add byte[poscount],30h
add byte[negcount],30h

print1 msg1,len1
print1 poscount,10
print1 nl,len
print1 msg2,len2
print1 negcount,10
print1 nl,len

;exit syscall
mov rax,60
mov rdi,00
syscall



