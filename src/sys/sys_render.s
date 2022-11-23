.include "src/inc/header.inc"

SYS_WRITE   =   1
STDOUT      =   1

.section .data

delete_screen: .ascii "\033[H\033[J"
delete_screen_size = . - delete_screen


string: .ascii "Hola mundo!\n"
string_size = . - string

.section .text

.globl write_in_terminal



change_color_ini: .ascii "\033[38;3;"
R1: .byte 0 
R2: .byte 0 
R3: .byte 0
G1: .byte 0 
G2: .byte 0 
G3: .byte 0 
B1: .byte 0 
B2: .byte 0 
B3: .byte 0 
.ascii  "m"
change_color_ini_size = . - change_color_ini

move_cursor_ini: .ascii "\033["
X_H: .byte 0 
X_L: .byte 0
.ascii ";"
Y_H: .byte 0 
Y_L: .byte 0
.ascii "H"
move_cursor_ini_size = . - move_cursor_ini


////////////////////////////////////////////
//write_in_terminal
//writes what is inside the string variable on the terminal
//INPUT:
//  None
//OUTPUT:
//  None
//MODIFIES:
//  RAX,RDI,RSI,RDX
//
write_in_terminal:
    push rbp    
    mov rbp,rsp

    mov rax, SYS_WRITE           /*RAX sys_write*/
    mov rdi, STDOUT              /*RDI File descriptor == code for the file*/
    lea rsi, [string]            /*RSI Buffer for the writing*/
    mov rdx, string_size         /*Size of string to write*/
    syscall                      /*syscall must always be called in order to use system functions*/

    pop rbp
 ret
