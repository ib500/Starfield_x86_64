.include "src/inc/header.inc"
.include "src/inc/sys_render_header.inc"
.include "src/inc/utils_header.inc"


SYS_EXIT    =   60


.section .data


.section .text

.globl _main
.globl _start
_start:

    call _main

    //call sys_render_delete_screen

    mov rax, SYS_EXIT   /* RAX  sys_exit*/
    mov rdi, 7          /* RDI  error code*/
    syscall             /* Call sys_exit*/ 
   
_main:

    call sys_render_ini

    mov rdi, 24
    call utils_divide_int

    call sys_render_modify_string

    call sys_render_write

    ret
