;    Digit printing concept
;	author	: Suraj Singh Bisht
;	Email   : surajsinghbisht054@gmail.com
;
; includable functions
%include 'includable_functions_without_start.asm'
;
;   I Think This Script needs Little Finishing. 
;
;	So, i will left this work to reader :))
;
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
;
;
; section bss
;  
;	digitprintersave	resb	255;
;
; Simple Concept to print multi digit numbers
;
; For Example :
;	Dividend  = 1000 (Dividend)
;	Divisor   = 10
;
;	( Quotient, Remainder ) = ( Dividend / Divisor )
;
;
; While (if Quotient is Not Equal To 0){
;	print (Remainder);
;
;	( Quotient, Remainder ) = ( Quotient / Divisor )
;
; }
;
;
;
; Come On! Use Mind And Calculate Above Provided Algo.
;
;

__printreverse:
	; input
	; 	eax = address of string
	;
	; output
	;	nothing
	push ebx
	push ecx
	push edx

	; store value into stack
	push eax
	call _strlen		; Find String length
	mov ecx, eax		; ECX = Length Of String
	pop ebx			; EBX = Address of string

_printreverseiterate:
	mov al, [ebx+ecx]		; Load Address Into EAX
	call _printsingle		; print single number over terminal
	cmp ecx, 0			; Compare if ECX is zero
	je _printreversereturn		; Return
	dec ecx
	jmp _printreverseiterate	; Repeat


_printreversereturn:
	pop edx
	pop ecx
	pop ebx
	ret


; routine to print single digit
_printsingle:
        ; Input:
        ;       EAX = Value
        ; Output:
        ;       nothing
        push ebx        ; store register into stack

        mov ebx, 0      ; EBX = 0
        push ebx        ; push ebx
        push eax        ; push eax
        mov eax, esp    ; EAX = ESP
        call _print     ; call print 

        pop eax         ; pop Eax
        pop ebx         ; pop EBX Null Value
        pop ebx         ; pop eax

        ret             ; return 


; Digit To ASCII Digit Convertion Subroutine
_printdigit:
        ; Input:
        ;       EAX = Digit Number
        ; Output
        ;       EAX
        ;

	; Save Values
        push eax                ; Save Digit [Previous Arguments]
        push ebx                ; Push Ebx To Stack [Previous Arguments]
	push ecx
	push edx
	mov ebx, 10		; Set EBX = 10
	mov ecx, 0		;

; division loop
_divisionloop:
	xor edx, edx		; EDX = 0
        div ebx                 ; Perform Division Between EAX, EBX [EDX, EAX = EAX / EBX ]
                                ; EAX = Quotient And EDX = Remainder

        push eax                ; Push EAX Into Stack [Division Answer]
        mov eax, edx            ; EAX = EDX [EAX = Remainder]

        add eax, 48             ; ASCII code Difference Is 48
	mov [digitprintersave+ecx], eax		;
        ;call _printsingle       ; Call printsingle routine
	inc ecx;
        pop eax                 ; Get EAX
        cmp eax, 0              ; Compare
        je _comparisionsection  ; To Avoid Print
	jmp _divisionloop	; Repeat


_comparisionsection:
	mov eax, digitprintersave		;
	call __printreverse
	; Pop Values
	pop edx
	pop ecx
        pop ebx                 ; Pop Digit [Previous Arguments]
        pop eax                 ; Pop Digit[Previous Arguments]

        ret             ; Return




