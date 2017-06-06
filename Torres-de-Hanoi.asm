.data

.text 
	add $t0, $sp, -28	# begin base adress
	# para agregar otro valor a la pila usar (adress +20h, 32D)
	add $t1, $t0, 4		# aux base adress 
	add $t2, $t1, 4		# end base adress
	li $s0,10		# n
MAIN:
	jal HANOIL 		# Calling procedure
	j EXIT			# Jump to Main label
	
HANOIL:	
	slti $t3, $s0, 1 	# if n<1, t=1
	beq $t3, $zero, MOVE 	# Branch to Loop
	addi $v0, $zero, 1 	# Confirm end
	jr $ra 			# Return to the caller	
MOVE:	
	# Check other base 
	sw $s0, 0($t0) 		# Storing the resturn address
	addi $s0, $s0, -1 	# Decreasing n
	addi $t0, $t0, 32
	j HANOIL
EXIT: