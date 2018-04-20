# Shellcode

- [Tutorial to write a simple shellcode (FR)](http://www.bases-hacking.org/afficher-shell.html)
- [Shellcodes Database](http://shell-storm.org/shellcode/)
- [Security related Youtube channel](https://www.youtube.com/channel/UClcE-kVhqyiHCcjYwcpfj9w/videos)

> In my opinion, the best way to create your own shellcode is to code in assembly. This way you can execute precisely the instructions that you want, and you can use differents tricks to avoid NULL bytes.

- Since you have written your assembly code, you have to compile it to generate an object file from which you will get the operation codes. Some scripts exist to extract easily the op codes from an object file, maybe I will try some and put a link here, or write my own. Meanwhile, I let you handle this part :-) 

## From assembly to shellcode

You have written an awesome assembly file which spawn a shell, chmod the entire file system and make the coffee in less than 42 bytes ? Good ! Now you need to get the op codes.

### ELF 32 bit architecture

```
nasm -f elf file.asm
objdump -d -M intel file.o
```
### WIP