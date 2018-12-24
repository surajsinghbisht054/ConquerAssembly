; Find String Length
; author : surajsinghbisht054@gmail.com
;
;

; Section BSS
SECTION .bss

; Section Data
SECTION .data
	string db "0123456789", 0AH ; This is the example string to find the length 

; Section Text
SECTION .text
	global _start

;
; Plan
;	Iterate String From Starting to End, Until 0 bit found (End).
;	Then, Simply Subtract The Ending Memory Address From Starting memory
;	address to find the length of string.
;
; Routine
_start:
	mov eax, string		; Now, EAX points to starting of string
	mov ebx, string		; Now, EBX also points to starting of String

; Iterate Routine
_iterate:
	cmp 	byte[eax], 0	; Compare EAX first Byte with 0, if equal then set zero flag else pass
	jz	_length		; If Zero flag is set, then follow _lenth routine else pass
	inc	eax		; increase EAX += 1
	jmp	_iterate	; Repeat

; Length 
_length:
	sub	eax, ebx	; EAX = EBX - EAX [Difference Between memory Address of Starting and Ending Point ]
	mov	edx, eax	; Set length of string
	mov 	eax, 4		; invoke SYS_WRITE
	mov	ebx, 1		; STDOUT
	mov	ecx, string	; Set Memory address
	int 80h			; kernel interpt
	call _exit		; exit routine


; Exit Routine
_exit:
	mov eax, 1	; Invoke SYS_EXIT 
	mov ebx, 0	; Return Value
	int 80h		; kernel interpt
