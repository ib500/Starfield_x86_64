.include "src/inc/header.inc"

.section .data

ascii_add: .byte 48

.section .text

.globl utils_divide_int
.globl utils_update_string

////////////////////////////////////////////
//utils_update_string
//updates dynamic values on unknown string
//INPUT:
//  RAX: new value
//  RBX: pointer to the string to be updated
//  RCX: displacment on the string
//OUTPUT:
//  None
//MODIFIES:
//  RAX,
//
utils_update_string:
    push rbp    
    mov rbp,rsp

    Update_String_Loop:
        push rcx
        //load in RDI position first X then Y
        call utils_divide_int
        pop rcx
        //use returned value from past function and update string value 
        mov [rbx+rcx], al
        dec rcx
    //IF RDI==0 there's no more number to convert to int
    cmp rdi, 0
    jne Update_String_Loop

    mov rsp, rbp
    pop rbp
 ret

////////////////////////////////////////////
//utils_divide_int
//convert int value to ascii code
//INPUT:
//  RDI: integer value to be divided
//OUTPUT:
//  RAX: ascii value of the integer
//  RDI: new number resulting from extracting last unit from past number i. e. Input_RDI == 24 => Output_RDI == 2
//MODIFIES:
//  RAX,RCX,RDX
//
utils_divide_int:
    push rbp    
    mov rbp,rsp

    //check if integer value == 0
    cmp rdi, 0                  /* compare rdi to 0 */
    je done                     /*if rdi == 0 make especial case in case input number == 0*/

    //if number != 0 divide by ten and convert remainder value to ascii
    xor rdx, rdx                /* Negate to 0 rdx so that remainder can be recovered */
    mov rax, rdi                /* Load numbr to be divided */
    mov rcx, 10                 /* Load a 10 on RCX so that remiander is lat unit of the number */
    div rcx                     /* divide and remainder by 10 */
    mov rdi, rax                /* move quotient back to rdi */
    add dl, 48                  /* convert remainder to ascii */
    xor rax, rax
    add al, dl

    done:
    mov rsp, rbp
    pop rbp
 ret


