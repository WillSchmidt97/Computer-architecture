.data 
	number1: .asciiz "Enter the first number: "
	number2: .asciiz "\nEnter the second number: "
	separator: .asciiz " "
	notPossible: .asciiz "Not possible to verify multiples of negative numbers."
	end: .asciiz "\nHere the program ends!"
.text
	move $s0, $zero # $s0 will receive the values to multiply number1
	addi $s0, $s0, 2
	
	#GETTING THE FIRST NUMBER
	li $v0, 4 #4 is the code we are showing the computer we want to print a text
	la $a0, number1 #load the address to print the first string
	syscall
	
	#Input the first number
	li $v0, 5 #load 5 to tell the system we want to get an integer from the user
	syscall
	move $t0, $v0 #storing the value in $t0
	
	
	#GETTING THE SECOND NUMBER
	li $v0, 4
	la $a0, number2 #load the adress to print the second string
	syscall
	
	#Input the second number
	li $v0, 5
	syscall
	move $t1, $v0 #storing the second number in $t1
	
	
	#GETTING NUMBER1 X NUMBER2
	mul $t2, $t0, $t1 #Multiply number1 and number2 and the result will be stored in $t2
	
	move $t7, $t0 #$t7 will receive the value of $t0 and store the multiples
	bgez $t2, Loop #If number1 and number2 are not negative, than the program jumps to Loop
	
	#If any of the numbers less than zero, the program ends
	nPos:
		li $v0, 4 #Command to print a string
		la $a0, notPossible #loads the value of the string
		syscall 
		j exit #the program jumps to print the string telling the user the program is over
	
	#Loop to multiple the numbers until number1 <= (number1 x number2)
	Loop:
	
		#Display first number
		li $v0, 1 #Printing an integer
		move $a0, $t0 #moving the number to the argument to be printed
		syscall
		
		#Printing the space between the numbers
		li $v0, 4 #Tells the program the user wants to print a string
		la $a0, separator #load $a0 to print the first string
		syscall
	
		mul $t0, $t7, $s0 #$s0 will be the counter and will multiply $t0
		addi $s0, $s0, 1 # $s0 = $s0 + 1, the counter will added one to multiply with number1 and find the next multiple
		ble $t0, $t2, Loop #if $t0<$t2 the program goes to Loop
	
	exit:
		li $v0, 4
		la $a0, end #Loading the string to tell the user the program is over
		syscall