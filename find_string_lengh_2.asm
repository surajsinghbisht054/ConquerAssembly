; Find String Length Method 2
;	author : surajsinghbisht054@gmail.com
;


; BSS Section
SECTION .bss



; Data Section
SECTION .data
	string	 db	"0123456789", 0AH 	; Decleare String + 0AH is a New line ASCII HEXA code

; Text Section
SECTION .text
	global _start
;
; Plan
;	Iterate String From Starting to End, Until 0 bit found (End).
;	Also Keep Record, The Number of times of iteration Routine.
;	This Iteration Register will denote the length of string
;

; Routine Start
_start:
	mov eax, string		; mov string starting point memory address to EAX 
	mov ebx, 0		; SET EBX = 0

; Routine iterate
_iterate:
	sub byte[eax], 0	; Compare EAX first byte with 0, if equal set zero flag to 1 else set zero flag to 0
	jz _gotit		; if Zerof flag is 1, Follow _gotit Routine, Else pass
	inc eax			; Increase EAX
	inc ebx			; keep record, Number of String Characters Checked
	jmp _iterate		; Repeat

; Routine When, String End Found
_gotit:
	mov edx, ebx		; set EDX = EBX [Length of String]
	mov eax, 4		; invoke SYS_Write
	mov ebx, 1		; STDOUT
	mov ecx, string		; Move String Memory Address To ECX
	int 80h			; kernel interpt
	call _exit		; Follow Exit Routine

; Exit Routine
_exit:
	mov eax, 1	; Invoke SYS_EXIT
	mov ebx, 0	; Return Value
	int 80h		; Kernel interpt
