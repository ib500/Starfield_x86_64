.include "src/inc/header.inc"

.section .data




entity_default:
    .byte 0x7F
    .byte 1
    .byte 1
    .byte -1
entity_size= . - entity_default
array_size = entity_size*10
.section .bss

    entity_array: .space array_size


.section .text

