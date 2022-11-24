.include "src/inc/header.inc"
.include "src/inc/sys_render_header.inc"

X_DISPLACMENT = 6
Y_DISPLACMENT = 9

.section .data
//move_cursor: .ascii "\033[??;??H"
move_cursor: .ascii "????[??;??H"
move_cursor_size = . - move_cursor



.section .text


.globl sys_physics_modify_pos



////////////////////////////////////////////
//sys_physics_modify_pos
//writes what is inside the string variable on the terminal
//INPUT:
//  ???: memory address of first component of entity
//OUTPUT:
//  None
//MODIFIES:
//  RAX,RDI,RSI,RDX
//
sys_physics_modify_pos:
    push rbp    
    mov rbp,rsp
    //recover position component from entity

    //update new position by adding velocity




    mov rsp, rbp
    pop rbp

 ret
