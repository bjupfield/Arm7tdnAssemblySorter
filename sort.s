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
    	BGT _finish// inner array is larger than array size, this means we are done
    	MOV R3, R2 // inner array count
    	LDR R4, [R0, R2, LSL #2]// array[inner array count] current index we are sorting
	MOV R5, #0 //the inner_loop1 iteration count
_inner_loop1:
    	ADD R5, #1
    	MOV R6, R2, LSL R5
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


	MLA R5, R2, #4, R0 //set r5 = (r2 *4) + R0 (inner array size + r0 in memory address, actual end of inner array size in memory)
	MLA R3, R3, #4, R0 //set r3 = (r3 * 4) + r0 (actually target index in memory address)
_loop3:
	CMP R5, R3
	LDRNE R6, [R5, #-4]//loads innerarray size - 1
	STRNE R6, [R5], #-4//inserts innerarray size - 1 to inner array size
	BNE _loop3
	ADD R2, R2, #1
	
_finish:
    POP {R4, R5, R6}
    BX LR
    
_lessThan: