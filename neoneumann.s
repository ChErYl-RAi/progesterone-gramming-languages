	.file	"neoneumann.c"
	.text
	.globl	ptr
	.bss
	.align 8
ptr:
	.space 8
	.globl	ram
	.align 32
ram:
	.space 256
	.globl	secmem
	.align 4
secmem:
	.space 4
	.globl	address
	.align 4
address:
	.space 4
	.globl	octave
	.align 4
octave:
	.space 4
	.globl	ldscr
	.data
ldscr:
	.byte	1
	.globl	peverytime
peverytime:
	.byte	1
wawa:
	.ascii "ABCDEF"
	.section .rdata,"dr"
.LC0:
	.ascii "%d:\0"
.LC1:
	.ascii "%c:\0"
.LC2:
	.ascii "%d, \0"
.LC3:
	.ascii "%c, \0"
.LC4:
	.ascii "address:%d \12\0"
.LC5:
	.ascii "secmem:%d \12\0"
	.text
	.globl	printarray
	.def	printarray;	.scl	2;	.type	32;	.endef
	.seh_proc	printarray
printarray:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	$0, -8(%rbp)
	jmp	.L2
.L7:
	movq	16(%rbp), %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$-97, %al
	ja	.L3
	movq	16(%rbp), %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	shrb	$4, %al
	movzbl	%al, %eax
	leaq	.LC0(%rip), %rcx
	movl	%eax, %edx
	call	printf
	jmp	.L4
.L3:
	movq	16(%rbp), %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	shrb	$4, %al
	movzbl	%al, %eax
	subl	$10, %eax
	cltq
	leaq	wawa(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movsbl	%al, %eax
	leaq	.LC1(%rip), %rcx
	movl	%eax, %edx
	call	printf
.L4:
	movq	16(%rbp), %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	andl	$15, %eax
	cmpb	$9, %al
	ja	.L5
	movq	16(%rbp), %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	andl	$15, %eax
	movl	%eax, %edx
	leaq	.LC2(%rip), %rax
	movq	%rax, %rcx
	call	printf
	jmp	.L6
.L5:
	movq	16(%rbp), %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	andl	$15, %eax
	subl	$10, %eax
	cltq
	leaq	wawa(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movsbl	%al, %eax
	leaq	.LC3(%rip), %rcx
	movl	%eax, %edx
	call	printf
.L6:
	addq	$1, -8(%rbp)
.L2:
	cmpq	$255, -8(%rbp)
	jbe	.L7
	movl	$10, %ecx
	call	putchar
	movl	address(%rip), %eax
	leaq	.LC4(%rip), %rcx
	movl	%eax, %edx
	call	printf
	movl	secmem(%rip), %eax
	leaq	.LC5(%rip), %rcx
	movl	%eax, %edx
	call	printf
	movl	$10, %ecx
	call	putchar
	nop
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC6:
	.ascii "rb\0"
.LC7:
	.ascii "No such file\0"
.LC8:
	.ascii "file loaded: %s\12\0"
.LC9:
	.ascii "~\0"
	.align 8
.LC10:
	.ascii "instruction: %d, params: %d.\12\12\0"
.LC11:
	.ascii "Please supply an input file\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$80, %rsp
	.seh_stackalloc	80
	.seh_endprologue
	movl	%ecx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	call	__main
	cmpl	$1, 16(%rbp)
	jle	.L9
	movq	24(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC6(%rip), %rdx
	movq	%rax, %rcx
	call	fopen
	movq	%rax, ptr(%rip)
	movq	ptr(%rip), %rax
	testq	%rax, %rax
	jne	.L10
	leaq	.LC7(%rip), %rax
	movq	%rax, %rcx
	call	puts
	movl	$1, %eax
	jmp	.L11
.L10:
	movq	ptr(%rip), %rdx
	leaq	ram(%rip), %rax
	movq	%rdx, %r9
	movl	$1, %r8d
	movl	$256, %edx
	movq	%rax, %rcx
	call	fread
	movzbl	ram(%rip), %eax
	cmpb	$-17, %al
	jbe	.L12
	movzbl	ram(%rip), %eax
	andl	$15, %eax
	testb	%al, %al
	jne	.L13
	movb	$0, ldscr(%rip)
	movb	$0, peverytime(%rip)
	jmp	.L12
.L13:
	movzbl	ram(%rip), %eax
	andl	$15, %eax
	cmpb	$1, %al
	jne	.L14
	movb	$1, ldscr(%rip)
	movb	$0, peverytime(%rip)
	jmp	.L12
.L14:
	movb	$1, ldscr(%rip)
	movb	$1, peverytime(%rip)
.L12:
	movzbl	ldscr(%rip), %eax
	testb	%al, %al
	je	.L16
	movq	24(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC8(%rip), %rcx
	movq	%rax, %rdx
	call	printf
	leaq	.LC9(%rip), %rax
	movq	%rax, %rcx
	call	puts
	leaq	ram(%rip), %rax
	movq	%rax, %rcx
	call	printarray
	movl	$10, %ecx
	call	putchar
	jmp	.L16
.L46:
	movl	address(%rip), %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$28, %eax
	addl	%eax, %edx
	andl	$15, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, address(%rip)
	movl	octave(%rip), %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	address(%rip), %eax
	addl	%edx, %eax
	cltq
	leaq	ram(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	shrb	$4, %al
	movzbl	%al, %eax
	cmpl	$14, %eax
	je	.L17
	cmpl	$14, %eax
	jg	.L18
	cmpl	$13, %eax
	je	.L19
	cmpl	$13, %eax
	jg	.L18
	cmpl	$12, %eax
	je	.L20
	cmpl	$12, %eax
	jg	.L18
	cmpl	$11, %eax
	je	.L21
	cmpl	$11, %eax
	jg	.L18
	cmpl	$10, %eax
	je	.L22
	cmpl	$10, %eax
	jg	.L18
	cmpl	$9, %eax
	je	.L23
	cmpl	$9, %eax
	jg	.L18
	cmpl	$8, %eax
	je	.L24
	cmpl	$8, %eax
	jg	.L18
	cmpl	$7, %eax
	je	.L25
	cmpl	$7, %eax
	jg	.L18
	cmpl	$6, %eax
	je	.L26
	cmpl	$6, %eax
	jg	.L18
	cmpl	$5, %eax
	je	.L27
	cmpl	$5, %eax
	jg	.L18
	cmpl	$4, %eax
	je	.L28
	cmpl	$4, %eax
	jg	.L18
	cmpl	$3, %eax
	je	.L29
	cmpl	$3, %eax
	jg	.L18
	cmpl	$1, %eax
	je	.L30
	cmpl	$2, %eax
	je	.L31
	jmp	.L18
.L30:
	movl	octave(%rip), %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	address(%rip), %eax
	addl	%edx, %eax
	cltq
	leaq	ram(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movzbl	%al, %eax
	andl	$15, %eax
	movl	%eax, address(%rip)
	jmp	.L32
.L31:
	movl	octave(%rip), %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	address(%rip), %eax
	addl	%edx, %eax
	cltq
	leaq	ram(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movzbl	%al, %eax
	andl	$15, %eax
	movl	%eax, %edx
	movl	secmem(%rip), %eax
	addl	%edx, %eax
	movl	%eax, secmem(%rip)
	movl	secmem(%rip), %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, secmem(%rip)
	movl	address(%rip), %eax
	addl	$1, %eax
	movl	%eax, address(%rip)
	jmp	.L32
.L29:
	movl	secmem(%rip), %ecx
	movl	octave(%rip), %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	address(%rip), %eax
	addl	%edx, %eax
	cltq
	leaq	ram(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movzbl	%al, %eax
	andl	$15, %eax
	movl	%eax, %edx
	movl	%ecx, %eax
	subl	%edx, %eax
	movl	%eax, secmem(%rip)
	movl	secmem(%rip), %eax
	testl	%eax, %eax
	jns	.L33
	movl	secmem(%rip), %eax
	addl	$256, %eax
	movl	%eax, secmem(%rip)
.L33:
	movl	secmem(%rip), %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, secmem(%rip)
	movl	address(%rip), %eax
	addl	$1, %eax
	movl	%eax, address(%rip)
	jmp	.L32
.L28:
	movl	octave(%rip), %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	address(%rip), %eax
	addl	%edx, %eax
	cltq
	leaq	ram(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movzbl	%al, %eax
	movl	%eax, secmem(%rip)
	movl	secmem(%rip), %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, secmem(%rip)
	movl	address(%rip), %eax
	addl	$1, %eax
	movl	%eax, address(%rip)
	jmp	.L32
.L27:
	movl	secmem(%rip), %ecx
	movl	octave(%rip), %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	address(%rip), %eax
	addl	%edx, %eax
	cltq
	leaq	ram(%rip), %rdx
	movb	%cl, (%rax,%rdx)
	jmp	.L32
.L26:
	movl	octave(%rip), %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	address(%rip), %eax
	addl	%edx, %eax
	cltq
	leaq	ram(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movzbl	%al, %eax
	andl	$15, %eax
	movl	%eax, %edx
	movl	octave(%rip), %eax
	sall	$4, %eax
	addl	%edx, %eax
	cltq
	leaq	ram(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movzbl	%al, %eax
	movl	%eax, secmem(%rip)
	movl	secmem(%rip), %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, secmem(%rip)
	movl	address(%rip), %eax
	addl	$1, %eax
	movl	%eax, address(%rip)
	jmp	.L32
.L25:
	movl	secmem(%rip), %eax
	movl	%eax, -16(%rbp)
	movl	octave(%rip), %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	address(%rip), %eax
	addl	%edx, %eax
	cltq
	leaq	ram(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movzbl	%al, %eax
	movl	%eax, secmem(%rip)
	movl	secmem(%rip), %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, secmem(%rip)
	movl	octave(%rip), %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	address(%rip), %eax
	addl	%edx, %eax
	movl	-16(%rbp), %edx
	movl	%edx, %ecx
	cltq
	leaq	ram(%rip), %rdx
	movb	%cl, (%rax,%rdx)
	jmp	.L32
.L24:
	movl	secmem(%rip), %eax
	movl	%eax, address(%rip)
	movl	address(%rip), %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$28, %eax
	addl	%eax, %edx
	andl	$15, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, address(%rip)
	jmp	.L32
.L23:
	movl	secmem(%rip), %eax
	testl	%eax, %eax
	jne	.L34
	movl	octave(%rip), %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	address(%rip), %eax
	addl	%edx, %eax
	cltq
	leaq	ram(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movzbl	%al, %eax
	andl	$15, %eax
	movl	%eax, %edx
	movl	address(%rip), %eax
	addl	%edx, %eax
	movl	%eax, address(%rip)
	jmp	.L32
.L34:
	movl	address(%rip), %eax
	addl	$1, %eax
	movl	%eax, address(%rip)
	jmp	.L32
.L22:
	movl	octave(%rip), %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	address(%rip), %eax
	addl	%edx, %eax
	cltq
	leaq	ram(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movzbl	%al, %eax
	andl	$15, %eax
	movl	%eax, %edx
	movl	octave(%rip), %eax
	sall	$4, %eax
	addl	%edx, %eax
	cltq
	leaq	ram(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movzbl	%al, %eax
	movl	%eax, %ecx
	call	putchar
	movl	address(%rip), %eax
	addl	$1, %eax
	movl	%eax, address(%rip)
	jmp	.L32
.L17:
	movl	octave(%rip), %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	address(%rip), %eax
	addl	%edx, %eax
	cltq
	leaq	ram(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movzbl	%al, %eax
	andl	$15, %eax
	movl	%eax, -4(%rbp)
	movl	address(%rip), %eax
	leal	1(%rax), %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$28, %eax
	addl	%eax, %edx
	andl	$15, %edx
	subl	%eax, %edx
	movl	octave(%rip), %eax
	sall	$4, %eax
	addl	%edx, %eax
	cltq
	leaq	ram(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movzbl	%al, %eax
	andl	$15, %eax
	movl	%eax, -8(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, octave(%rip)
	movl	-8(%rbp), %eax
	movl	%eax, address(%rip)
	jmp	.L32
.L21:
	movl	secmem(%rip), %eax
	movl	%eax, %ecx
	call	putchar
	movl	address(%rip), %eax
	addl	$1, %eax
	movl	%eax, address(%rip)
	jmp	.L32
.L20:
	movq	$0, -48(%rbp)
	movl	octave(%rip), %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	address(%rip), %eax
	addl	%edx, %eax
	cltq
	leaq	ram(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movzbl	%al, %eax
	andl	$15, %eax
	imull	$125000000, %eax, %eax
	movl	%eax, -40(%rbp)
	leaq	-48(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	$0, -32(%rbp)
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rax, %rcx
	call	nanosleep64
	movl	address(%rip), %eax
	addl	$1, %eax
	movl	%eax, address(%rip)
	jmp	.L32
.L19:
	movl	secmem(%rip), %eax
	movb	%al, -9(%rbp)
	movl	octave(%rip), %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	address(%rip), %eax
	addl	%edx, %eax
	cltq
	leaq	ram(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movb	%al, -10(%rbp)
	movl	octave(%rip), %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	address(%rip), %eax
	addl	%edx, %eax
	cltq
	leaq	ram(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movzbl	%al, %eax
	andl	$15, %eax
	cmpl	$7, %eax
	je	.L37
	cmpl	$7, %eax
	jg	.L38
	cmpl	$6, %eax
	je	.L39
	cmpl	$6, %eax
	jg	.L38
	cmpl	$5, %eax
	je	.L40
	cmpl	$5, %eax
	jg	.L38
	cmpl	$4, %eax
	je	.L41
	cmpl	$4, %eax
	jg	.L38
	cmpl	$3, %eax
	je	.L42
	cmpl	$3, %eax
	jg	.L38
	cmpl	$2, %eax
	je	.L43
	cmpl	$2, %eax
	jg	.L38
	testl	%eax, %eax
	je	.L44
	cmpl	$1, %eax
	je	.L45
	jmp	.L38
.L44:
	movzbl	-9(%rbp), %eax
	andb	-10(%rbp), %al
	movzbl	%al, %eax
	movl	%eax, secmem(%rip)
	jmp	.L38
.L45:
	movzbl	-9(%rbp), %eax
	orb	-10(%rbp), %al
	movzbl	%al, %eax
	movl	%eax, secmem(%rip)
	jmp	.L38
.L43:
	movzbl	-9(%rbp), %eax
	andb	-10(%rbp), %al
	notl	%eax
	movzbl	%al, %eax
	movl	%eax, secmem(%rip)
	jmp	.L38
.L42:
	movzbl	-9(%rbp), %eax
	orb	-10(%rbp), %al
	notl	%eax
	movzbl	%al, %eax
	movl	%eax, secmem(%rip)
	jmp	.L38
.L41:
	movzbl	-9(%rbp), %eax
	xorb	-10(%rbp), %al
	movzbl	%al, %eax
	movl	%eax, secmem(%rip)
	jmp	.L38
.L40:
	movzbl	-9(%rbp), %eax
	xorb	-10(%rbp), %al
	notl	%eax
	movzbl	%al, %eax
	movl	%eax, secmem(%rip)
	jmp	.L38
.L39:
	movzbl	-9(%rbp), %eax
	notl	%eax
	movzbl	%al, %eax
	movl	%eax, secmem(%rip)
	jmp	.L38
.L37:
	movzbl	-10(%rbp), %eax
	notl	%eax
	movzbl	%al, %eax
	movl	%eax, secmem(%rip)
	nop
.L38:
	movl	address(%rip), %eax
	addl	$1, %eax
	movl	%eax, address(%rip)
	jmp	.L32
.L18:
	movl	address(%rip), %eax
	addl	$1, %eax
	movl	%eax, address(%rip)
	nop
.L32:
	movzbl	peverytime(%rip), %eax
	testb	%al, %al
	je	.L16
	leaq	ram(%rip), %rax
	movq	%rax, %rcx
	call	printarray
	movl	octave(%rip), %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	address(%rip), %eax
	addl	%edx, %eax
	cltq
	leaq	ram(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movzbl	%al, %eax
	andl	$15, %eax
	movl	%eax, %r8d
	movl	octave(%rip), %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	address(%rip), %eax
	addl	%edx, %eax
	cltq
	leaq	ram(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	shrb	$4, %al
	movzbl	%al, %eax
	leaq	.LC10(%rip), %rcx
	movl	%eax, %edx
	call	printf
.L16:
	movl	octave(%rip), %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	address(%rip), %eax
	addl	%edx, %eax
	cltq
	leaq	ram(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	cmpb	$15, %al
	ja	.L46
	jmp	.L48
.L9:
	leaq	.LC11(%rip), %rax
	movq	%rax, %rcx
	call	puts
	movl	$1, %eax
	jmp	.L11
.L48:
	movq	ptr(%rip), %rax
	movq	%rax, %rcx
	call	fclose
	movl	$0, %eax
.L11:
	addq	$80, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (Rev5, Built by MSYS2 project) 16.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	fopen;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	fread;	.scl	2;	.type	32;	.endef
	.def	nanosleep64;	.scl	2;	.type	32;	.endef
	.def	fclose;	.scl	2;	.type	32;	.endef
