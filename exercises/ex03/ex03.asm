.data
	number: .asciiz "Type a number to check if it is a perfect number: "
	PerfectNumber: .asciiz "Perfect number."
	NotPerfNum: .asciiz "Not a perfect number."
	
.text
	#Printing the string "number"
	li $v0, 4
	la $a0, number
	syscall
	
	#Input a number
	li $v0, 5
	syscall
	move $t1, $v0
	
	#auxiliar register
	move $t2, $zero #aux
	
	li $t3, 0 #Loop "for" index
	
	Loop:
		addi $t3, $t3, 1
		beq $t3, $t1, end # if $t1 == $t3 then "end"
		div $t1, $t3
		mfhi $t5
		beqz $t5, Aux #if $t5 == 0, then "Aux"
		j Loop
		
	Aux:
		add $t2, $t2, $t3
		j Loop
	
	Print:
		#Printing the string if the number is a perfect number
		li $v0, 4
		la $a0, PerfectNumber
		syscall
		j exit 
		
	end:
		beq $t1, $t2, Print #if $t1 == $t2, the program goes to Print to tell the user the number is a perfect number
		
		#Print in case the number is not a perfect number
		li $v0, 4
		la $a0, NotPerfNum
		syscall 
		
	exit:
		...
	