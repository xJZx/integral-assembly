.data
result: .float 0
iterator: .float 0
lower_limit: .float 0 #-2.0
upper_limit: .float 0
num_intervals: .float 0 #10       # number of rectangles
constant_1: .float 1
constant_4: .float 4
constant_7: .float 7
 
.text
.global integralFaster
 
integralFaster:
	push %rbp
	movq %rsp, %rbp
	
	# loading the function parameter into memory
	#movups %xmm0, num_intervals
        #movups %xmm1, lower_limit
        #movups %xmm2, upper_limit

	#movl num_intervals, %eax
	movl iterator, %ecx

	# loading memory into xmm registers
	movups iterator, %xmm3
	movups constant_1, %xmm9
	movups constant_4, %xmm4
	movups constant_7, %xmm7
	#movups result, %xmm6

	movups %xmm0, %xmm5	# move num_intervals to xmm5
	movups %xmm2, %xmm0	# move hi limit to xmm0
	subps %xmm1, %xmm0	# subtract lo limit from hi limit
	divps %xmm5, %xmm0	# subtraction divided by num_intervals (dx)
	movups %xmm0, %xmm10	# saving the dx

loop:
	movups %xmm10, %xmm0	# bringing back the dx to xmm0
	mulps %xmm3, %xmm0	# multiplying dx by an iterator
	addps %xmm1, %xmm0	# adding lower limit and now we have x
	movups %xmm0, %xmm8	# making copy of the x
	
	mulps %xmm0, %xmm0	# making x^2
	divps %xmm7, %xmm0	# making (x^2)/7
	
	mulps %xmm4, %xmm8	# making 4x
	
	addps %xmm8, %xmm0	# add the squared term and linear term
	mulps %xmm10, %xmm0	# multiply function by dx
	
	addps %xmm0, %xmm6	# adding all to result
		
	addps %xmm9, %xmm3	# incrementing the iterator
	incl %ecx
			
	cmpl $1000, %ecx
	jne loop
	
	movups %xmm6, %xmm0	# move result to xmm0

end:
	movq %rbp, %rsp
	pop %rbp
	ret
