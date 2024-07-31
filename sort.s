.global ascSort

.text

//R0 = array
//R1 = arrayCount
//R2 = innercount
//R3 = targetindex
//R4 = array[innercount]
//R5 = innerarraycount / 2 => divided by two every iteration, removes need for another register
//R6 = target index left right value
//R7 = multiplier
//R8 = zero for one compare 
ascSort: 
    	PUSH {R4, R5, R6, R7, R8}
    	MOV R2, #0
    	MOV R5, #0
    	MOV R6, #0
    	MOV R7, #4
    	MOV R8, #0
_loop1:
        ADD R2, R2, #1
    	CMP R2, R1
    	BEQ _finish// inner array is larger than array size, this means we are done
    	MOV R3, R2// target index intiliazation
    	LDR R4, [R0, R2, LSL #2]// array[inner array count] current index we are sorting
        MOV R5, R2, LSR #1
	SUB R3, R5
_loop2:

        LDR R6, [R0, R3, LSL #2]
        CMP R4, R6
        CMPLS R8, R3
        BEQ _preloop3
        BLS _left
        CMP R3, R2
        ADDNE R3, R3, #1
        LDRNE R6, [R0, R3, LSL #2]
        CMPNE R4, R6
        SUBHI R3, R3, #1
        BHI _right
_preloop3:
    	MLA R5, R2, R7, R0 //set r5 = (r2 *4) + R0 (inner array size + r0 in memory address, actual end of inner array size in memory)
    	MOV R6, R3
        MLA R3, R6, R7, R0 //set r3 = (r3 * 4) + r0 (actually target index in memory address)
_loop3:
    	CMP R5, R3
    	LDRNE R6, [R5, #-4]//loads innerarray size - 1
    	STRNE R6, [R5], #-4//inserts innerarray size - 1 to inner array size
    	BNE _loop3
    	STR R4, [R3]//stores our number we are sorting at the target index, after bumping up all the right side values to not overwrite any
    	B _loop1
_finish:
        POP {R4, R5, R6, R7, R8}
        BX LR
_left:
	LSR R5, #1
	SUB R3, R3, R5
	CMP R5, #0
	SUBEQ R3, R3, #1
	B _loop2
_right:
	LSR R5, #1
	ADD R3, R3, R5
	CMP R5, #0
	ADDEQ R3, R3, #1
	B _loop2

    