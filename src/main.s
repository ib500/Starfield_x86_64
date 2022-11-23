.include "src/inc/header.inc"
.include "src/inc/sys_render_header.inc"


SYS_EXIT    =   60

.section .data

.section .text

.globl _main
.globl _start
_start:

    call _main

    mov rax, SYS_EXIT   /* RAX  sys_exit*/
    mov rdi, 7          /* RDI  error code*/
    syscall             /* Call sys_exit*/ 
   
_main:

    call write_in_terminal

    ret
