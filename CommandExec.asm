;
;	Program To Execute Commands
;
;	author : Suraj Singh Bisht
;	Email  : surajsinghbisht054@gmail.com
;


; section bss
SECTION .bss


; section data
SECTION .data
	filename	db	"/bin/ping", 0h ; Decleare String
	argv		db	"www.bitforestinfo.com", 0h	; Argument

	arg_array	dd	filename	;
			dd	argv		; Array of Arguments
			dd	0h		; End of Argument

	environ		db	0h ; Empty Argument

; section text
SECTION .text
	global _start	; Linker Trigger

; Routine
_start:
	mov eax, 11		; Invoke SYS_EXECVE () - > execve(const char *filename, char *const argv[], char *const envp[])
	mov ebx, filename	; EBX = File name
	mov ecx, arg_array;	; ECX = array of argument addresses
	mov edx, environ	; EDx= Environment
	int 80h			; kernel Interpt

	mov eax, 1		; InVoke SYS_EXIT
	mov ebx, 0		; Return 0
	int 80h			; Kernel Interpt
