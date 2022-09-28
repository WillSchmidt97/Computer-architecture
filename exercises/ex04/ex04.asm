.data
	message: .asciiz "Type a value: "
	message2: .asciiz "The sum of the values stored in the array is: "
	breakLine: .asciiz "\n\n"
	Array:
		.align 2 #align in the correct position
		.space 256 #each position needs 4 bytes to store a value. The array will have at most 64 values, in that case it is needed to reserve 256 bytes for this array,

.text
	main:
		li $v0, 4 #Printing the string
		la $a0, message
		syscall
		
		li $v0, 5 #Input an integer number
		syscall
		move $t0, $v0 #Storing the int number typed by the uses in the $t0 register
		
		#Call storeValues
		jal storeValues
		
		#Call computerSum
		jal computerSum
		
		#Breaking the line
		li $v0, 4
		la $a0, breakLine
		syscall
		
		#Printing the result message
		li $v0, 4
		la $a0, message2
		syscall
		
		#Printing the sum
		li $v0, 1
		move $a0, $s6
		syscall
		
		#end
		j exit
	storeValues:
		move $t7, $zero #aux
		move $s0, $zero
		ble $t7, $t0, Loop
		
		Loop:
			mult $t7, $t7 #multiply the value in the register with itself
			mflo $t1 #the register $t1 will receive the result of the multiplication of $t7
			sw $t1, Array($s0) #storing values in the array
			addi $s0, $s0, 4 #Getting the next position to store the next value in the array
			addi $t7, $t7, 1
			blt  $t7, $t0, Loop #if $t9 < $t0, the problem goes back to Loop
		
		jr $ra #Jump register to the returning address
			
		
	computerSum:
		move $t7, $zero #aux
		move $s0, $zero
		move $s6, $zero #Will storage the sum of all the elements of the array
		
		Loop2:
			lw $t3, Array($s0) #Read each value of the array
			move $s7, $t3
			add $s6, $s6, $s7  #$s6 += $s7
			addi $t7, $t7, 1 #aux += 1
			addi $s0, $s0, 4 #Getting the next position to load the next value stored in the array
			blt $t7, $t0, Loop2  #if $t7 < $t0, the problem goes back to Loop
			
		jr $ra #Jump register to the returning address

	exit:
		...