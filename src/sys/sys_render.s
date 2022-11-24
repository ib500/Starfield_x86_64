.include "src/inc/header.inc"
.include "src/inc/utils_header.inc"

SYS_WRITE   =   1
STDOUT      =   1

X_DISPLACMENT = 6
Y_DISPLACMENT = 9

.section .data

move_cursor: .ascii "\033[??;??H"
move_cursor_size = . - move_cursor

delete_screen: .ascii "\033[H\033[J"
delete_screen_size = . - delete_screen


string: .ascii "*"
string_size = . - string

change_color_ini: .ascii "\033[38;3;122;1;102m"
change_color_ini_size = . - change_color_ini



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
.globl sys_render_entity




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

    lea rsi, [change_color_ini]     /*RSI Buffer for the writing*/
    mov rdx, change_color_ini_size  /*Size of string to write*/

    call sys_render_write

    mov rsp, rbp
    pop rbp
 ret

////////////////////////////////////////////
//sys_render_write
//writes what is inside the string variable on the terminal
//INPUT:
//  RSI: pointer to the first byte of the string
//  RSX: size of the string
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
sys_render_entity:
    push rbp    
    mov rbp,rsp

    mov rdi, 23                /*shouldnt exixst later on*/
    mov rcx, X_DISPLACMENT

    call sys_render_update_cursor

    mov rdi, 44                /*shouldnt exixst later on*/
    mov rcx, Y_DISPLACMENT

    call sys_render_update_cursor

    lea rsi, [move_cursor]        /*RSI Buffer for the writing*/
    mov rdx, move_cursor_size     /*Size of string to write*/

    call sys_render_write

    lea rsi, [string]        /*RSI Buffer for the writing*/
    mov rdx, string_size     /*Size of string to write*/

    call sys_render_write

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
//sys_render_update_cursor
//Deletes entire screen
//INPUT:
//  RCX: Displacment of the variable to be updated
//  RDI: new value
//OUTPUT:
//  None
//MODIFIES:
//  RCX,RDX
//
sys_render_update_cursor:
    push rbp    
    mov rbp,rsp

    lea rbx, [move_cursor]

    call utils_update_string

    mov rsp, rbp
    pop rbp
 ret
