.section .data

move:
	.asciz "move dish %d from  %s to %s \n"
dishnum:
	.asciz "Hanoi number is %d ! \n"
usage:
	.asciz "Usage : %s <number> !\n"
x:
	.asciz "x"
y:
	.asciz "y"
z:
	.asciz "z"

.section .text

.globl _start
_start:

	#check args
	cmp $2, (%esp)
	jl if0 #if args < 2, return
	jmp endif0

if0:
	pushl 4(%esp)
	pushl $usage
	call printf
	addl $4, %esp #reset stack after call function
    pushl $0
    call exit

endif0:

#get the number of dishs
	pushl 8(%esp)
	call atoi
	addl $4, %esp #reset stack after call function

	pushl %eax #backup eax
	pushl %eax 
	pushl $dishnum
	call printf

	addl $8, %esp #reset stack after call function
	popl %eax #reset eax

	pushl $z
	pushl $y
	pushl $x
	pushl %eax

	call hanoi

	addl $16, %esp #reset stack after call function
    pushl $0
    call exit

.type hanoi, @function

	#void hanoi(int n, char* x,  char* y,  char* z)
hanoi:
	pushl %ebp
	movl %esp, %ebp

	cmpl $1, 8(%ebp)
	je if1
	jmp else1
if1:

	pushl 20(%ebp) #z
	pushl 12(%ebp) #x
	pushl 8(%ebp)  #n
	pushl $move
	call printf

	jmp endif1
else1:

	movl 8(%ebp), %eax
	decl %eax #n-1
	pushl 16(%ebp) #y
	pushl 20(%ebp) #y
	pushl 12(%ebp) #x
	pushl %eax  #n-1

	call hanoi

	addl $16, %esp #reset stack after call function

	pushl 20(%ebp) #z
	pushl 12(%ebp) #x
	pushl 8(%ebp)  #n
	pushl $move
	call printf

	addl $16, %esp #reset stack after call function

	movl 8(%ebp), %eax
	decl %eax #n-1
	pushl 20(%ebp) #z
	pushl 12(%ebp) #z
	pushl 16(%ebp) #y
	pushl %eax  #n-1
	call hanoi

	addl $16, %esp #reset stack after call function

endif1:

	movl %ebp, %esp
	popl %ebp
	ret
