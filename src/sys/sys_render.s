.include "src/inc/header.inc"
.include "src/inc/utils_header.inc"

SYS_WRITE   =   1
STDOUT      =   1

.section .data

delete_screen: .ascii "\033[H\033[J"
delete_screen_size = . - delete_screen


string: .ascii "Hola mundo me muero!\n"
string_size = . - string

change_color_ini: .ascii "\033[38;3;???;???;???m"
change_color_ini_size = . - change_color_ini

move_cursor_ini: .ascii "\033[??;??H"
move_cursor_ini_size = . - move_cursor_ini

color_value: 
.byte 2
.byte 5
.byte 6

.section .bss

X:
.word 0
Y:
.word 0

.section .text


.globl sys_render_write
.globl sys_render_ini
.globl sys_render_delete_screen
.globl sys_render_modify_string


sys_render_modify_string:
    mov [string], rax
 ret

////////////////////////////////////////////
//sys_render_write
//writes what is inside the string variable on the terminal
//INPUT:
//  None
//OUTPUT:
//  None
//MODIFIES:
//  RAX,RDI,RSI,RDX
//
sys_render_write:
    push rbp    
    mov rbp,rsp
    
    mov rax, SYS_WRITE           /*RAX sys_write*/
    mov rdi, STDOUT              /*RDI File descriptor == code for the file*/
    mov rsi, [string]            /*RSI Buffer for the writing*/
    mov rdx, string_size         /*Size of string to write*/
    syscall                      /*syscall must always be called in order to use system functions*/

    mov rsp, rbp
    pop rbp
 ret
////////////////////////////////////////////
//sys_render_ini
//initialize render system
//INPUT:
//  None
//OUTPUT:
//  None
//MODIFIES:
//  RAX,RDI,RSI,RDX
//
sys_render_ini:
    push rbp    
    mov rbp,rsp

    //Load new color values
    // mov rax, R1
    // call sys_change_color
    //call sys_render_delete_screen

    //Write Ansi escape code to change screen color
    // mov rax, SYS_WRITE              /*RAX sys_write*/
    // mov rdi, STDOUT                 /*RDI File descriptor == code for the file*/
    // lea rsi, [change_color_ini]     /*RSI Buffer for the writing*/
    // mov rdx, change_color_ini_size  /*Size of string to write*/
    // syscall                         /*syscall must always be called in order to use system functions*/

    mov rsp, rbp
    pop rbp
 ret

////////////////////////////////////////////
//sys_change_color
//change color of the system
//INPUT:
//  None
//OUTPUT:
//  None
//MODIFIES:
//  RAX,RDI,RSI,RDX
//
sys_render_change_color:

    push rbp    
    mov rbp,rsp

    mov rsp, rbp
    pop rbp
 ret

////////////////////////////////////////////
//sys_delete_screen
//Deletes entire screen
//INPUT:
//  None
//OUTPUT:
//  None
//MODIFIES:
//  RAX,RDI,RSI,RDX
//
sys_render_delete_screen:
    push rbp    
    mov rbp,rsp

    mov rax, SYS_WRITE           /*RAX sys_write*/
    mov rdi, STDOUT              /*RDI File descriptor == code for the file*/
    lea rsi, [delete_screen]            /*RSI Buffer for the writing*/
    mov rdx, delete_screen_size         /*Size of string to write*/
    syscall                      /*syscall must always be called in order to use system functions*/

    mov rsp, rbp
    pop rbp
 ret

////////////////////////////////////////////
//sys_render_shift_cursor
//Deletes entire screen
//INPUT:
//  None
//OUTPUT:
//  None
//MODIFIES:
//  RAX,RDI,RSI,RDX
//
sys_render_shift_cursor:
    push rbp    
    mov rbp,rsp

    // mov rax, 2
    // mov rbx, X_H
    // call util_assign_to_variable

    // mov rax, 0
    // mov rbx, X_L
    // call util_assign_to_variable

    // mov rax, 6
    // mov rbx, Y_H
    // call util_assign_to_variable

    // mov rax, 7
    // mov rbx, Y_L
    // call util_assign_to_variable

    mov rax, SYS_WRITE                  /*RAX sys_write*/
    mov rdi, STDOUT                     /*RDI File descriptor == code for the file*/
    lea rsi, [move_cursor_ini]            /*RSI Buffer for the writing*/
    mov rdx, move_cursor_ini_size         /*Size of string to write*/
    syscall                             /*syscall must always be called in order to use system functions*/


    mov rsp, rbp
    pop rbp
 ret

////////////////////////////////////////////
//sys_render_shift_cursor
//Deletes entire screen
//INPUT:
//  RCX: value to be loaded on the variable
//  RDX: memory address of the variable
//OUTPUT:
//  None
//MODIFIES:
//  RCX,RDX
//
util_assign_to_variable:
    push rbp    
    mov rbp,rsp

    mov [rcx], rdx

    mov rsp, rbp
    pop rbp
 ret
