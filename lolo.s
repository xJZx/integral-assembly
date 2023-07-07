.text
.globl rdtsc_p

rdtsc_p:
	push %rbp
	
	cmpl $0, %esi
	jle end

loop:
	cmpb $1, %dl
	jne else
	xorl %eax, %eax
	cpuid
	rdtsc

else:
	rdtscp

	decl %esi	
	cmpl $0, %esi
	jg loop

end:
	movl %edx, %edx
	shl $32, %rdx
	addq %rdx, %rax

	pop %rbp
	ret
