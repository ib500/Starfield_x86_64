.include "src/inc/header.inc"


INI_ENTITIES = 0


.section .data

entity_default:
    .byte 0x7F
    .byte 1
    .byte 1
    .byte -1
entity_size = . - entity_default
array_size  = entity_size*10
.section .bss

entity_array_n: .space array_size
reserved_entities_b: .byte 0
next_free_entity_q: .quad 0



.section .text

.globl man_entity_createEntity
.globl man_entity_init

////////////////////////////////////////////
//man_entity_init
//initialize entity manager
//INPUT:
//  None
//OUTPUT:
//  None
//MODIFIES:
//  RBX
//
man_entity_init:
    push rbp    
    mov rbp,rsp

    lea rbx, [reserved_entities_b]
    mov rbx, INI_ENTITIES

    lea rbx, [next_free_entity_q]
    mov rbx, entity_array_n

    mov rsp, rbp
    pop rbp
 ret

////////////////////////////////////////////
//man_entity_createEntity
//create one entity and return reference to it
//INPUT:
//  None
//OUTPUT:
//  RAX: pointer to the entity
//MODIFIES:
//  RAX,RDI,RSI,RDX
//
man_entity_createEntity:
    push rbp    
    mov rbp,rsp

    //Add new entity to entity counter
    mov ebx, [reserved_entities_b]      
    inc ebx
    mov [reserved_entities_b], ebx

    //recover pointer to next free entity
    lea ebx, [next_free_entity_q]
    mov ecx, entity_size
    //point to next entity
    add ecx, ebx
    //load new pointer
    mov [next_free_entity_q], ecx

    //assign default entity values to new entity
    lea esi, [entity_default]   /*SOURCE*/
    lea edi, [entity_array_n]   /*DESTINATION*/
    mov ecx, entity_size        /*COUNTER*/
    /*The B stands for byte*/
    rep movsb 

    lea rax [entity_array_n]

    mov rsp, rbp
    pop rbp
 ret

