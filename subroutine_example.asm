;
; Subroutine Example
;	author : suraj singh bisht
;	Email  : surajsinghbisht054@gmail.com
;
;

; Declearing Routines
; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;           String Length Finding Subroutine
; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
_findlength:
	; Input :
	;	EAX = Memory Address of String
	; Return :
	;	EAX = length of String

; Routine To Save Register Into Stack
_saveresiters:	; Routine To Save Registers Into The Stack [Because ]
		; it's necessary in Return Subroutine to process further routine without error
	push ecx	; push ecx value into stack Why? [Just To Demonstrate Stack PUSH/POP]
	push edx	; push edx value tnto stack
	mov edx, 0	; Set EDX = 0

; Iterate Routine
_iterate:
	sub byte [eax], 0	; If EAX==0 Then Set Zero Flag To 1 Else Zero flag To 0
	jz _return		; Follow Return, if Zero flag is 1 Else pass
	inc eax			; Increase EAX = EAX+1 Memory Address
	inc edx			; Increase Routine Iteration Num
	jmp _iterate		; Repeat

; Return Routine
_return:
	mov eax, edx		; Set Return Value EAX= EDX
	pop edx			; POP EDX value
	pop ecx			; POP ECX
	ret			; ret

; Exit Routine
_exit:
	mov eax, 1	; invoke SYS_EXIT
	mov ebx, 0	; set Return Value 0
	int 80h		; kernel interpt


; section bss
SECTION .bss

; section data
SECTION .data
	string 		db	"Hello! I'm Suraj Singh", 0AH 	; Decleare String

; section text
SECTION .text
	global _start	; Routine Trigger


; Start Routine
_start:
	; First, Find The Length of String
	mov eax, string		; EAX= String
	mov ebx, 0		; EBX = 0

	call _findlength	; follow subroutine

	mov edx, eax		; Save Return Value To EDX
	mov eax, 4		; invoke SYS_WRITE
	mov ebx, 1		; STDOUT
	mov ecx, string		; ECX= String memory Address

	int 80h			; kernel Interpt

	jmp _exit		; Exit Routine
