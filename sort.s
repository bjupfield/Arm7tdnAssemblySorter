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
//R4 = array[innercount]
//R5 = inner_loop1 iteration count
//R6 = target index memory address
//R7 = targetindex left/right value
//R8? = innerarray count / (2 ^ R5)
	
    	


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