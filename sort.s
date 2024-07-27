.global ascSort

.text

    //R0 = *sortArray
    //R1 = arrayCount
    //using R0-R6
ascSort: 
    PUSH {R4, R5, R6}
    MOV R2, #1
    MOV R5, #0
    MOV R6, #0
_outer_loop:
    CMP R2, R1
    BGT _finish
    MOV R3, R2 // inner array count
    MOV R4, #0
    LDR R5, [R0, R2, LSL #2]// array[inner array count] current index we are sorting
_inner_loop1:
    ADD R4, #1
    MOV R6, R2, LSL R4
    SUBLT R3, R3, R6
    ADDGT R3, R3, R6
    LDR R6, [R0, R3, LSL #2]//array[target index]
    CMP R5, R6
    BLT _iterate_above
    ADD R6, R3, #1
    LDR R6, [R0, R6, LSL #2]// array[target index + 1]
    CMP R5, R6
    BGT _iterate_below
    SUB R4, R2, R3
    ADD R4, R4, #-1
    LSL R3, #2
    ADD R3, R3, R0
_inner_loop2:
    
    LDR R6 [R3, R4, LSL #2]
    ADD R4, R4, #1
    STR R6, [R3, R4, LSL #2]
    ADDS R4, R4, #-2
_finish:
    POP {R4, R5, R6}
    BX LR
    
_lessThan:

