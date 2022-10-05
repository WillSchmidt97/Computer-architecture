
message: .asciiz "Type the size of the array:  "
message2: .asciiz "Array sum: "
message3: .asciiz "Type each value of the array: "
array:
	.align 2 #align in the correct position
	.space 512

	.text
	li $v0, 4 #Printing the string
	la $a0, message
	syscall
	
	#Asking the user the size of the array
	li $v0, 5 #Input an integer number
	syscall
	move $t0, $v0 #Storing the int number typed by the uses in the $t0 register
	
	la $t1, array #ponteiro para vet
	li $v1, 0 #$v1 - 0
	
	#Printing message3
	li $v0, 4
	la $a0, message3
	syscall
	
loop:
	beq $t0, $0, print
	
	#Asking the user the values of the array
	li $v0, 5 #Input an integer number
	syscall
	sw $v0, 0($t1)
	
	lw $t2, 0($t1)
	add $v1, $v1, $t2 #soma do array
	addi $t1, $t1, 4
	addi $t0, $t0, -1
	j loop
	
print:
	#Printing the array's sum result
	li $v0, 4 #Printing the string
	la $a0, message2
	syscall
	
	#Printing an integer
	li $v0, 1
	move $a0, $v1
	syscall
	
exit:
	