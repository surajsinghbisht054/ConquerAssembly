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




; Sub Routine To Iterate Argument
_calculateargument:
	; Bascially, Number Of Argument And Address of Argument String, Already Comes Into The Stack
	;	[Because Operating Pass This And other types of data also as Environment.]
	; So, We Just Need To Extract Data From Stack
	;

	; Get Stack Pointer Address
	mov eax, esp			; EAX = ESP

	; Increase Memory Address
	add eax, 4			; Increase EAX

	; Get Number of Argument
	mov ebx, [eax]			; EBX = Number of Argument

	; Set Pointer To Arguments Start Address
	add eax, 8			; Arguments

	; Now, WE Have EBX = Numbers of Arguments
	; and EAX = [arg1, arg2, arg3] (all arg1-3 are addresses of real data)
	push eax 			; Address of Stack
	push ebx 			; Number of argument
	push ecx			; Save Values of Registers 
	push edx			; Save Values of Registers
	xor edx,edx
	xor ecx, ecx			; ECX = 0
	inc ecx				; Than Increase +1

; Sub routine To Iterate Arguments
_iterateargument:
	; Now, From Here
	;	EAX = Address of Argument Address Into Stack
	;	EBX = Total Number of Argument
	;	ECX = Number of Arguments Processed
	;
	cmp ecx, ebx			; compare number of arguments with iteration routine

	; Jump if No Arguments Left
	je _calculateargumentReturn	; Jump if Equal Then Call _calculateargumentReturn

	push eax			; Save Value Into Stack 
	push ebx			; Save Value Into Stack
	mov eax, [eax]			; EAX = Load Argument Address
	mov esi, eax			;
	;
	; Here, Our Iterated Argument Value Address is Available At EAX
	;
	;call _printline			; Print Argument

	mov eax, newline		; Load '\n'
	call _print			; print '\n'

	mov eax, string0		; Load String
	call _print			; print string

	mov eax, esi			; EAX = ESI
	call _asciitointeger		; Call ASCII to Integer Conversion Subroutine
	add edx, eax			; Add to EDX

	; Check If Conversion Successful
	call _printdigit		; Print Digit Subroutine

	; Futher Process
	pop ebx				; 
	pop eax				; POP EAX Saved Value
	add eax, 4			; Point To next Argument address into stack
	inc ecx				; Increase Number of Argument Process Register Value
	jmp _iterateargument		; Repeat


_calculateargumentReturn:
	mov eax, newline		; Load '\n'
	call _print			; print '\n'

	mov eax, string1		; Load String
	call _print			; Print String

	mov eax, edx			; EAX = EBX
	call _printdigit		; Print Digit On Screen

	mov eax, newline		; Load '\n'
	call _print			; print '\n'

	pop edx				; POP saved values
	pop ecx				; POP saved value
	pop ebx				; Retrive Registers Values
	pop eax				; Pop Saved Values
	ret


; section .bss
SECTION .bss
	argumentsum	resb	200	; Save Here Sum
 	digitprintersave	resb	255;

; section .data
SECTION .data
	string0		db	"[+] Your Inserted Argument Number : ", 0h	; String Decleare
	string1		db	"[+] Your All Arguments SUM        : ",	0h	; String Decleare
	newline		db	" ",0Ah,0h	; New line

; section .text
SECTION .text
	global _start		; GCC linker Requirement

; Trigger
_start:
	call _calculateargument	; call iterateargument subroutine
	jmp _exit		; jmp routine
