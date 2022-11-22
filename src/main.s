.intel_syntax noprefix

// section .data

// msg db "Hola\n",0x0A,0

// section .text
SYS_EXIT    =   60
SYS_WRITE   =   1
STDOUT      =   1

.section .data

string: .ascii "Hola mundo!\n"
string_size = . - string

.section .text

.globl _main

.globl _start
_start:

_main:

    mov rax, SYS_WRITE           /*RAX sys_write*/
    mov rdi, STDOUT              /*RDI File descriptor == code for the file*/
    lea rsi, [string] /*RSI Buffer for the writing*/
    mov rdx, string_size                  /*Size of string to write*/
    syscall                      /*syscall must always be called in order to use system functions*/

    mov rax, SYS_EXIT   /* RAX  sys_exit*/
    mov rdi, 7          /* RDI  error code*/
    syscall             /* Call sys_exit*/    
    ret
