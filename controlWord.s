.section .data
control_word:
	.word 0	# new control word value for single precision
.section .text
.global precision

precision:
	push %rbp
	movq %rsp, %rbp

	fstcw control_word
	movw control_word, %ax
	andw $0xFCFF, %ax
	movw %ax, control_word
	#orw $0x0200, %ax
	fldcw control_word
	
	# Set single precision
	
end:
	movq %rbp, %rsp
	pop %rbp	
	ret
