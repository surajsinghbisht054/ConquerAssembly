; Assembly Includable File
;	author : suraj singh bisht
;	Email  : surajsinghbisht054@gmail.com
;
; Compile :
;
; $ mkdir bin
; $ mkdir output
; $ nano includable_functions.asm 
; $ nasm -f elf includable_functions.asm -o bin/includable_function.o
; $ ld -m elf_i386 bin/includable_function.o -o output/includable_function
; $ ./output/includable_function aaaa bbbb
;
;
; Run
; :~$ ./output/includable_function aaaa bbbb
; [+] Your Program Executing Command   :  ./output/includable_function
; [+] Your First Provide Argument      :  aaaa
; [+] Your Second Provide Argument     :  bbbb
; [+] Hello Guys, How are You?            
; [+] Nice !                              
; [+] Welcome To Our Blog,                
; [+] My name is suraj singh              
; [+] EMail : surajsinghbisht054@gmail.com
;
;





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

; bss section
SECTION .bss


; data section
SECTION .data
	string0 	db	"[+] Hello Guys, How are You?            ", 0h	; Decleare String
	string1		db	"[+] Nice !                              ", 0h	; Decleate String
	string2		db	"[+] Welcome To Our Blog,                ", 0h	;
	string3		db	"[+] My name is suraj singh              ", 0h	;
	string4		db	"[+] EMail : surajsinghbisht054@gmail.com", 0h  ;
	string5		db	"[+] Your Program Executing Command   :  ", 0h  ;
	string6		db	"[+] Your First Provide Argument      :  ", 0h  ;
	string7		db	"[+] Your Second Provide Argument     :  ", 0h	;

; text section
SECTION .text
	global _start		; Trigger

; print all arguments
_argument:
	; Input
	; 	EAX = ESP
	; Output
	; 	nothing
	;
	; Argument Available At The Start of Stack
	;

	push ebx		; PUSH EBX Values Into The STack
	mov ebx, esp		; Point To Starting of Stack
	add ebx, 8		; because of calling _argument, _start function, 12 Bytes Are Already Added To Stack 

	; +++++++++++++ First Line
	; print string without new line character
	mov eax, string5	; EXA = string5
	call _print		; 

	; print script execution command
	mov eax, [ebx+4]		; Load memory Address Content
	call _printline		; call _printline

	; +++++++++++ Second Line ++++++++++++++++++++
        ; print string without new line character
        mov eax, string6        ; EXA = string5
        call _print             ; 

        ; print script execution command
        mov eax, [ebx+8]          ; Load memory Address Content
        call _printline         ; call _printline


	; +++++++++++ Third Line +++++++++++++++++++++++++++
        ; print string without new line character
        mov eax, string7        ; EXA = string5
        call _print             ; 

        ; print script execution command
        mov eax, [ebx+12]          ; Load memory Address Content
        call _printline         ; call _printline



	pop ebx			; POP Ebx Value
	ret

_trigger:
	mov eax, string0	; EAX = addressof(string)
	call _printline		; Call _print

	mov eax, string1	; Second String
	call _printline

	mov eax, string2	; Third String
	call _printline

	mov eax, string3	; Fourth String
	call _printline

	mov eax, string4	; Fifth String
	call _printline 

	ret

_start:
	call _argument		; Print Arguments 
	call _trigger		; Perform All Function
	jmp _exit		; EXIT Routine
