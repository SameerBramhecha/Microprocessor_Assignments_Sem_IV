;Assignment Number 4 MPL:
;Declare an array and assign values to it and print the largest number in it


section .data
	array db 45h,80h,31h,25h,01h
	nl db ' ',10	
	len equ $-nl 
	msg1 db 'Largest Number is: ',10
	len1 equ $-msg1
section .bss
	count resb 02
	result resb 10
	output resb 10
	
section .text
	global _start
	_start:


%macro print 04
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro


mov byte[count],05
mov rsi,array
mov bl,00
up:
	cmp bl,[rsi]
	ja skip
	mov bl,[rsi]
	skip: inc rsi
	dec byte[count]
	jnz up


mov [result],bl
call disp
print 01,01,msg1,len1
print 01,01,output,02
print 01,01,nl,len
;exit syscall
mov rax,60
mov rdi,00
syscall 
;Always write procedure after exit syscall otherwise we get segmentation fault
disp:
	
	 mov rsi,output
	 mov byte[count],02 ;no of digits
	 up1:
		rol bl, 04
		mov dl, bl
		and dl, 0Fh
		cmp dl, 09
		jbe skip1
		add dl, 07h
		skip1:  add dl, 30h
			mov [rsi],dl
			inc rsi
			dec byte[count]
			jnz up1
		mov bl,[result]
	ret	

