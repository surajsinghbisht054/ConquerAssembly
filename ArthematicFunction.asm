;	Arthematic Functions Examples
;
;	author	: suraj singh bisht
;	Email	: surajsinghbisht054@gmail.com
;
; includable functions
;
; ====================================================
;              [ Includable File]
; Functions:
;       _strlen
;       _exit
;       _print
;       _printline
;
; ====================================================
; ====================================================
;              [ Includable File]
; Functions:
;       _printsingle
;       _printdigit
; ====================================================

%include 'DigitPrinter_without_start.asm'



; section .bss
SECTION .bss

; section data
SECTION .data
; ------------------------------------------------------------------------------------------------
; 	Variable	| Size	| newline |	String			| Null Character |
; -----------------------------------------------------------------------------------------------
	string0		db	0Ah, "[+] Your Addition Answer       : ",0h	; String Deceleration
	string1		db	0Ah, "[+] Your Subtraction Answer    : ",0h	; String Decleration
	string2		db	0Ah, "[+] Your Multiplication Answer : ",0h
	string3		db	0Ah, "[+] Your Division Answer        : ",0h
	rem		db	     " Answer And Remainder is : ",  0h

; section text
SECTION .text
	global _start		; Linker Trigger


_start:
	; print first string
	mov eax, string0	; print string
	call _print		; call printline

	; Perform Addition
	mov eax, 50	; Load NUMBER1 into eax
	mov ebx, 5	; Load NUMBER2 into eax
	add eax, ebx		; Perform Addition [EAX = EAX + EBX ]
	call _printdigit	; print answer


	; print second string
	mov eax, string1	; load string address
	call _print		; call print line

	; perform subtraction
	mov eax, 50	; Load First Number 
	mov ebx, 5	; Load Second Number
	sub eax, ebx		; Perform Subtraction [EAX = EAX - EBX]
	call _printdigit

	; Print third string
	mov eax, string2	; load string address
	call _print		; print answer

	; perform multiplication
	mov eax, 10	; Load First Number
	mov ebx, 5	; Load Second Number
	mul ebx			; Perform Multiplication, First Argument is Default Set To = EAX,
				; Hence, no need to pass first register, [EAX = EAX * EBX ]
	call _printdigit	; print answer

	; print string
	mov eax, string3	; load string address
	call _print		; call printline

	; perform division
	mov eax, 100	; Load First Number
	mov ebx, 9	; Load Second Number
	mov edx, 0	; Make Sure, Edx = 0
	div ebx			; perform division, First Argument is Default Set To = EAX,
				; Hence, No need to pass first register, [EDX, EAX = EAX / EBX]
				; Here, EAX = Quotient & EDX = Remainder
	push edx		; Save Remainder Into Stack

	call _printdigit	; print answer Quotient

	; print remainer text
	mov eax, rem		; Load Address
	call _print		; 

	; print remainder
	pop eax			; Load Remainder
	call _printdigit	; call printline


	; exit
	jmp _exit		; exit routine
