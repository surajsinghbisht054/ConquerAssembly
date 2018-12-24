;
;       Number Calculating Example
;
;	author : suraj singh bisht
;	Email  : surajsinghbisht054@gmail.com
; 
; Program Will Take Numbers To Calculate From Command Line argument
;
%include 'DigitPrinter_without_start.asm'
; ====================================================
;              [ Includable File]
; Functions:
;       _strlen
;       _exit
;       _print
;       _printline
;
;
;              [ Includable File]
; Functions:
;       _printsingle
;       _printdigit
;
;
; Function:
;	_asciitointeger
;
; ====================================================
; Don't forget to add this into .bss section
; 	digitprintersave	resb	255;


; ASCII to Integer Converting Subroutine
_asciitointeger:
	; Input
	; EAX = Address of ASCII number
	; Output
	; EAX = Number

	push ebx	; Save Registers
	push ecx
	push edx

	; make sure all registers are empty
	xor ecx, ecx	; SET ecx = 0 [Take keep numbers ]
	xor ebx, ebx	; Set EBX = 0 [To Take Small Bytes From ASCII Array]
	xor edx, edx	; Set EDX = 0 [Keep Record of Iteration]
	mov esi, eax	; ESI = EAX
	xor eax, eax	; EAX = 0; From now EAX will store digit
	mov ecx, 10	; Multiplication Digit

; iterate Subroutine
_iterateasciitointeger:
	xor ebx, ebx 			; EBX = 0
	mov bl, [esi]                   ; Load Byte

	;cmp bl, 0;			; Compare Byte of EBX and Zero
	;je _returnasciitointeger	; Return Routine

	cmp bl, 48	          	; compare ebx register's lower half value against ascii value 48 (char value 0)
    	jl _returnasciitointeger	; Return Routine

	cmp bl, 57			; compare if ebx is greater than
	jg _returnasciitointeger	; Return Routine



	mul ecx				; Multiply EAX*ECX
        sub bl, 48                      ; Subtract ASCII Code Increased
        add eax, ebx                    ; EAX = EAX + EBX
        inc esi                         ; Increase Routine
        jmp _iterateasciitointeger      ; Repeat

_returnasciitointeger:
	;mov eax, 20	; Just Checking
	pop edx		; pop save registers
	pop ecx
	pop ebx
	ret


