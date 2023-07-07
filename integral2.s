.data
result: .double 0.0
iterator: .int 0
lower_limit: .int 0 #-2.0
upper_limit: .int 0
num_intervals: .int 0 #10	# number of rectangles
constant_4: .int 4
constant_7: .int 7

.text
.global integral2

integral2:
	push %rbp
	movq %rsp, %rbp
	
	# arguments passed from function
	movl %edi, num_intervals
	movl %esi, lower_limit
	movl %edx, upper_limit

	movl iterator, %eax
	movl num_intervals, %ecx # upper bound of for

	fldl result	# loading the result onto the FPU stack
	fildl lower_limit # loading lower_lim
        fildl upper_limit # loading upper_lim
        fsub %st(1), %st(0) # subtraction of limits (HI-LO)
        fidivl num_intervals # dividing subtraction with amount of rect.
	
integrate_loop:
	push %rax	# save the interval counter
	fildl iterator	

	fmul %st(1), %st(0) # multiply dx with iterator
	fadd %st(2), %st(0) # added lower limit, now we have x in %st(0) 
	fld %st(0)	# duplicate x

	fmul %st(0), %st(0) # calculate the (x^2)
	fidivl constant_7 # divide (x^2)/7
	
	fildl constant_4 # load the 4
	fmul %st(2), %st(0) # multiply the (4x)
	
	fadd %st(1), %st(0) # add the squared term and linear term
	fmul %st(3), %st(0) # multiply function by dx
	fadd %st(0), %st(5) # add running sum with calculated rectangle

	fstp %st(0)	# just cleaning up...
	fstp %st(0)	# still cleaning...
	fstp %st(0)	# stiiill...
	
	pop %rax	# restore the rectangle counter
	incl %eax	# increment the rectangle counter
	movl %eax, iterator
	cmpl %eax, %ecx	# compare the rect. counter with the no. of rect.
	jne integrate_loop # if not equal, repeat the loop

	fstp %st(0)
	fstp %st(0)

	fstpl result
	movsd result, %xmm0
	
end:
	movl $1000000, %edi
	movl $35, %eax
	int $0x80	

	movq %rbp, %rsp	
	pop %rbp
	ret

	#fstpl result	# store the final result
