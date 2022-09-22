.data
	vetor: .word -2, 4, 7, -3, 0, -3, 5, 6
	numP: .word 0
	numN: .word 0
	.align 2 #align the data instruction on the correct position
	.space 32 #since it is 8 numbers in the array and each position needs 4 bytes, it should have 32 bytes reserved for all the numbers

.text
	la $t0, vetor #Starting the first addres in the array
	li $s1, 0 #counter = 0
	li $t1, 0 #$t1 will have the sum of positive numbers, and it will start with 0
	li $t2, 0 #$t2 will have the sum of the negative numbers, and it will start with 0
	li $t7, 8 #It will be used to compare with $s1, and stop the command when it reaches the last number in the array
	
	summing:
		lw $s2, 0($t0) #the register $s2 will start with the first number of the array
		blt $s2, 0, sumN #being the current value in the array a negative number, jumps to sumN
		bge $s2, 0, sumP #being the current value in the array equal or greater than 0, jumps to sumP
		
	sumP:
		add $t3, $t3, $s2 #the register $t3 will storage the sum of the positive numbers, it sums $t3 with the current number in the array, being this number a positive number
		j cArray
		
	sumN:
		add $t4, $t4, $s2 #the register $t4 will storage the sum of the negative numbers, it sums $t4 with the current number in the array, being this number a negative number 
		j cArray
	
	cArray:
		addi $s1, $s1, 1 #counter = counter + 1
		addi $t0, $t0, 4 #$t0 will be added 4 bytes to go to the nuext position of the array
		blt $s1, $t7, summing #if it is not equal or greater than 8, it goes to summing
		
	sw $t3, numP #store positive numbers
	sw $t4, numN #store negative numbers