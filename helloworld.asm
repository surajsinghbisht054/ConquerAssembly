; Hello World Program
; authur : surajsinghbisht054@gmail.com
; Link With (64 bit systems require elf_i386 option): ld -m elf_i386 helloworld.o -o helloworld
; Run with: ./helloworld

; BSS Section
SECTION .bss

; Data Section
SECTION .data
	message		db	"Hello, World!", 0AH ; decleare string + Use HEXVALUE 0AH for Next Line End Character

; text section
SECTION .text
	global _start

_start:
	mov eax, 4  	; Invoke sys_write (stdout, string, string_length)
	mov ebx, 1  	; stdout
	mov ecx, message; move memory address into register
	mov edx, 14 	; Length of String 
	int 80h;	; kernel interup

	; Return Routine
	mov eax, 1	; invoke SYS_EXIT
	mov ebx, 0 	;
	int 80h	;

