
#hellowrold.s print "hello,world!"

.section .data
	output: 
		.ascii "hello,world\n" 

.section .text  
.globl _main

_main:
	movl $4, %eax  
    movl $1, %ebx  
    movl $output,%ecx  
    movl $12,%edx  
    int  $0x80  
    movl $1, %eax  
    movl $0, %ebx  
    int  $0x80  
