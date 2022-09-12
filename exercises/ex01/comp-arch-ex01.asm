.text
	addi $s0, $s0, 4 #$s0 will receive 4
	move $t0, $zero #k=$t0
	loop:
		beq $t0, 20, exit #if $t0 = 20, go to exit
		addi $t0, $t0, 1 #$t0 = $t0 + 1
		mul $s1, $s0, $t0 #$s1 = $s0 * $t0
		addi $s2, $s1, 2 #4*k+2
		add $t1, $t1, $s2 #result
		j loop
	exit: