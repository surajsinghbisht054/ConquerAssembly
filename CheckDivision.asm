;	 Write A Program, That Takes User Input And Tell,
; 	Input Number is Divisible By 3 And 5
;
;	author: Suraj Singh Bisht
;	Email : surajsinghbisht054@gmail.com
;
%include 'CalculateArguments_without_start.asm'
; ====================================================
;              [ Includable File]
; Functions:
;       _strlen
;       _exit
;       _print
;       _printline
;
; Don't Forget To Create A Space in .bss Section 
;       SECTION bss:
;        save    resb    255;
;
;              [ Includable File]
; Functions:
;       _printsingle
;       _printdigit
;
;
; Function:
;       _asciitointeger
;
; ====================================================
;
; Don't forget to add this into .bss section
;       digitprintersave        resb    255;



; section .bss
SECTION .bss
	digitprintersave        resb    255;
	space	resb	255	; Blank Space

; section data
SECTION .data
	string00		db 	0Ah, "[+] Enter Your Number   : ", 0h		;
	string11		db	0Ah, "[+] User Entered Number : ", 0h		;
	string12		db	0Ah, "[+] Is Divisible By "
	string13		db	" : ",0h
	stringT			db	" True.",0Ah, 0h
	stringF			db	" False.",0Ah, 0h


; section text
SECTION .text
	global _start	; Linker



checkdivisionby:
	; Input :
	;	EAX = Number
	;	EBX = Dividend
	;
	; Output:
	;	EAX =  0 or 1+ Remainder
	;
	push ecx	; Save Register
	push edx	;
	push ebx	;
	xor edx, edx
	div ebx		; Perfrom Division
	pop ebx		;

	mov eax, string12;
	call _print;

	mov eax, ebx;
	call _printdigit;

	mov eax, string13
	call _print;

	cmp edx, 0	; Compare Remainder
	jne _notdivisible;

_yesdivisible:
	mov eax, stringT
	call _print

	mov eax, 1
	jmp _checkdivisionreturn ;

_notdivisible:
	mov eax, stringF
	call _print

	mov eax, 0

_checkdivisionreturn:
	pop edx		; POP Registers
	pop ecx
	ret

calculateUserinputDivision:
	; print string
	mov eax, string00		;
	call _print			;

	; Take User input
	mov eax, 3			; Invoke SYS_READ
	mov ebx, 1			; stdin
	mov ecx, space			; user space
	mov edx, 255			; Size
	int 80h				; kernel interpt


	; print string
	mov eax, string11		;
	call _print			;

	; perform ascii to integer conversion subroutine
	mov eax, space
	call _asciitointeger
	call _printdigit
	push eax
	mov ebx, 3
	call checkdivisionby
	pop eax
	mov ebx, 5
	call checkdivisionby


	ret				; Return

_start:
	call calculateUserinputDivision		;
	jmp _exit					; Exit Routine
