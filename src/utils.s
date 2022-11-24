.include "src/inc/header.inc"

.section .data

ascii_add: .byte 48

.section .text

.globl utils_divide_int

// ////////////////////////////////////////////
// //utils_int_to_str
// //convert int value to ascii code
// //INPUT:
// //  RAX: integer value to be converted
// //OUTPUT:
// //  RAX: integer value as ascii
// //MODIFIES:
// //  RAX,
// //
// utils_int_to_str:
//     push rbp    
//     mov rbp,rsp

//     add rax, [ascii_add]

//     mov rsp, rbp
//     pop rbp
//  ret

////////////////////////////////////////////
//utils_int_to_str
//convert int value to ascii code
//INPUT:
//  rdi: integer value to be divided
//OUTPUT:
//  None
//MODIFIES:
//  RAX,RBX,
//
utils_divide_int:
    push rbp    
    mov rbp,rsp

    cmp rdi, 0                  /* compare rdi to 0 */
    je done                     /*if rdi == 0 then we are done*/

    _printint_loop:
    cmp rdi, 0                  /* compare rdi to 0 */
    je  done                    /* if rdi == 0 then we are done */
    xor rdx, rdx                /* Negate to 0 rdx so that remainder can be recovered */
    mov rax, rdi                /* Load numbr to be divided */
    mov rcx, 10                 /* Load a 10 on RCX so that remiander is lat unit of the number */
    div rcx                     /* divide and remainder by 10 */
    mov rdi, rax                /* move quotient back to rdi */
    add dl, 48                  /* convert remainder to ascii */
    //mov byte [rbx], dl          /* move remainder to buffer */
    //dec rbx                     /* shift 1 position to the left in buffer */
    xor rax, rax
    add al, dl

    done:
    mov rsp, rbp
    pop rbp
 ret


