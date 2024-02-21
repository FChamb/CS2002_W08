	.file	"Factorial.c"
	.text
	.type	factorial, @function
factorial:
.LFB0:
	.cfi_startproc
	pushq	%rbp                    # Creates the instance of the stack for this function. Stores the stack pointer at rbp.
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp              # The pointer for the stack is given the value of the base pointer, rsp.
	.cfi_def_cfa_register 6
	subq	$16, %rsp               # Save space on the stack by removing 16 bytes.
	                                # The stack works downwards, so if the stack pointer is at 0, then rsp, the base pointer, is set to -16.
	movq	%rdi, -8(%rbp)          # Copy the value of n given by to the function, with rdi, into the negative 8 bytes space on the stack.
	                                # This call also brings the stack base pointer up so that it is half the available size from defined above.
	movq	%rsi, -16(%rbp)         # Copy the value of the accumulator given to the function with rsi into the negative 16 bytes space on the stack.
	                                # By doing this we have brought the base pointer and the stack pointer to the same level.
	cmpq	$1, -8(%rbp)            # Perform a subtraction between the value n (-8(%rbp)) and the value 1 ($1).
	ja	.L2                         # Tests whether the difference is non zero. Jump to L2 if the above is True, the factorial segment of the code.
	movl	$7, %edi                # Moves, or copies the default value of n plus 1 to the variable edi which will be passed into the below call to printStackFrames.
	call	printStackFrames        # Call to the printStackFrames function in the StackFrame file.
	movq	-16(%rbp), %rax         # Moves the value of the accumulator into the the return value.
	jmp	.L3                         # Jump to .L3 to exit the function and clean the program.
.L2:
	movq	-8(%rbp), %rax          # Moves the stack pointer for the value of n (-8(%rbp)) into the return value.
	imulq	-16(%rbp), %rax         # Multiplies n by the accumulator and stores in the return value.
	movq	-8(%rbp), %rdx          # Moves the value of n (-8(%rbp)) into a new storage address, rdx.
	subq	$1, %rdx                # Subtracts one from the value stored in rdx, which was just set to n.
	movq	%rax, %rsi              # The result of the last factorial call is moved to the value of the accumulator.
	movq	%rdx, %rdi              # The result of n - 1 which was calculated above is moved to rdi which is the storage for the value of n for the next call.
	call	factorial               # Calls the factorial again with the new parameters.
.L3:
	leave                           # Releases the stack used in the function.
	.cfi_def_cfa 7, 8
	ret                             # Frees the stack by popping all of the values therein cleaning it.
	.cfi_endproc
.LFE0:
	.size	factorial, .-factorial
	.section	.rodata
	.align 8
.LC0:
	.string	"executeFactorial: basePointer = %lx\n"
	.align 8
.LC1:
	.string	"executeFactorial: returnAddress = %lx\n"
	.align 8
.LC2:
	.string	"executeFactorial: about to call factorial which should print the stack\n"
	.align 8
.LC3:
	.string	"executeFactorial: factorial(%lu) = %lu\n"
	.text
	.globl	executeFactorial
	.type	executeFactorial, @function
executeFactorial:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movl	$0, %eax
	call	getBasePointer
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	call	getReturnAddress
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movl	$.LC2, %edi
	call	puts
	movq	$0, -24(%rbp)
	movq	$6, -32(%rbp)
	movq	$1, -40(%rbp)
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	factorial
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC3, %edi
	movl	$0, %eax
	call	printf
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	executeFactorial, .-executeFactorial
	.ident	"GCC: (GNU) 11.4.1 20230605 (Red Hat 11.4.1-2)"
	.section	.note.GNU-stack,"",@progbits
