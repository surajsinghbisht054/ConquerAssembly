;     UserInput
;	author : Suraj SIngh Bisht
;	Email  : surajsinghbisht054@gmail.com
;

; Include Other Script
%include 'includable_functions_without_start.asm'
; ====================================================
;              [ Includable File]
; Functions:
;       _strlen
;       _exit
;       _print
;       _printline
;
; ====================================================




; bss section
SECTION .bss
	space_user	resb	255 ; Reserve 255 Bytes in memory for Userinput


; data section
SECTION .data
	string0		db	"[+] Please enter your name : ", 0h	; message
	string1		db	"[+] hello, ", 0h	; another string

; text section
SECTION .text
	global _start	; trigger routine

; start
_start:
	; print string
	mov eax, string0	; Load String Address
	call _print		; call print routine

	; Take user input
	mov eax, 3		; invoke SYS_READ 
	mov ebx, 0		; STDIN
	mov ecx, space_user	; Address To Store
	mov edx, 255		; Address Space Available To Store
	int 80h			; kernel interpt

	; print another string
	mov eax, string1	; Load String address
	call _print		; call print routine

	; print user input
	mov eax, space_user	; Load string address
	call _print		; call print routine

	jmp _exit		; exit routine

