; Assembly Includable File
;	author : suraj singh bisht
;	Email  : surajsinghbisht054@gmail.com
;
; ====================================================
;              [ Includable File]
; Functions:
;	_strlen
;	_exit
;	_print
;	_printline
;
; ====================================================





; Routine To Find String length
_strlen:
	; Input
	;	EAX = address of string
	; Output
	;	EAX = Length of String

	; Initialize Registers
	push ebx	; push ebx value into stack
	mov ebx, 0	; Set EBX = 0


; iteration Routine
_iterate:
	cmp byte [eax],	0	; Compare Last bit, if true, Set Zero flag = 1 Else Zero flag = 0
	jz _return		; If Zero Flag = 1, Then Call function else pass
	inc eax			; Move Memory Address Pointer 
	inc ebx			; Keep Record of Iteration
	jmp _iterate		; Repeat

; Return String Calculated Length
_return:
	mov eax, ebx	; Set Return Value EAX = EBX
	pop ebx		; POP EBX Value
	ret		; Return

; Exit Routine
_exit:
	mov eax, 1 	; Invoke SYS_EXIT
	mov ebx, 0	; set Return Value Zero
	int 80h		; interpt kernel


; Print Line
_print:
	; Input 
	;	EAX = addressof(string)
	; Output
	;	Nothing

	push ebx 	; Store Registers Into Stack
	push ecx
	push edx
	push eax

	call _strlen	; Find String Len
	mov edx, eax	; Set EDX= EAX {String Length}
	mov eax, 4	; invoke SYS_WRITE
	mov ebx, 1	; STDOUT
	pop ecx		; POP String Address
	int 80h		; interpt Kernel
	pop edx		; POP all registers previous values
	pop ecx		;
	pop ebx		;
	ret		; return

; PrintLine 
_printline:
	; Input
	;	EAX = addressof(string)
	; Output
	; 	nothing
	
	call _print	; Print String 

	; 
	mov eax, 0	; SET EAX = 0
	push eax	; PUSH EAX Into Stack To make Sure; String End Character is 0

	mov eax, 0AH	; New Line ASCII Code
	push eax	; Push into The Stack

;
;	 Now Our Stack Look Like This
;	    ->     ->        ->       ->        ->
;	 ---------------------------------------------------
;	  |   EAX[0AH]   |   EAX [0]   | previous data |
;	 ---------------------------------------------------
;	 ESP                                             EBP
;

	mov eax, esp	; Set EAX = ESP
	call _print	; call _print routine
	pop eax		; Remove not useful pushed values from stack
	pop eax		;
	ret		; Return

