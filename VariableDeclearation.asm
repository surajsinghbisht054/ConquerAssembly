;   Variable Decleration Example
;
;	author : suraj singh bisht
;	Email  : surajsinghbisht054@gmail.com
;

; includable functions
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
;

; bss section
SECTION .bss


; data section
SECTION .data
	VName	DB	'Hey! Suraj!', 0h	; Decleare String 
	VSingle	DB	's'		; Allocate 1 Byte  [Single]
	VWord0	DW	1234		; Allocate 2 Bytes [Word]
	VWord1	DW	-1234		; Allocate 2 Bytes [Word]
	VReal0	DD	1.1234		; Allocate 4 Bytes [Double]
	VReal1	DQ	1234.4567	; Allocate 8 Bytes [Quadword]
	VBignm	DQ	123465789	; Allocate 8 Bytes [Quadword]


; text section
SECTION .text
	global _start	; linker trigger

; trigger function
_start:
	; =================================================
	;                  Note
	; =================================================
	; We can't directly print number on terminal in assembly.
	; To print any digit, first we have to convert it into ASCII code.
	; actually, assembly prints all character/Digit/Number/Word According
	; To ASCII code Table. 

	; Let's print 
	mov eax, VName		; Load Memory address
	call _printline		; call _printline Routine

	; let's print anoter character
	mov eax, VSingle	; Load Memory Address
	call _printline		; Call _printline Routine

	; Exit
	jmp _exit	; Exit routine



;
; Output:
; Hey! Suraj!
; s�.��ˏ?U0*��I�@=�[
;
;

