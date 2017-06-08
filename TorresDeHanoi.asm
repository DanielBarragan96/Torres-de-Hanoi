.text
	addi $sp, $sp, -28 		# Para comenzar en la primer colulmna
	add $t0, $sp, 0x00		# Begin base adress
	addi $t1, $t0, 32		# Columna B
	addi $t2, $t1, 32 		# Columna C
	add $s7, $zero, 0x03	# N
	addi $s0, $zero, 0x01	# Contador

IDATOS:	
	bne $s0, $s7, INTRODUCIR
	sw $s0, 0($t0) 		#Incertamos dato en la columna
	jr $ra			# Return to the caller	

INTRODUCIR:	
	sw $s0, 0($t0) 		# Storing the resturn address
	addi $s0, $s0, 1 		# Decreasing n
	addi $t0, $t0, 4	# Avanzar fila
	j IDATOS
	
HANOI: 	

	beq $s7, 1, MOV		
	sw $s0, 0($s2)
	addi $s1, $s1, 0x04
	jal CAMBIO
	j HANOI
	
CAMBIO:
	la $t2, ($t3)
	la $t3, ($t2)
	jr $ra

MOV:	lw $s0, 0($s1)
	sw $s0, 0($s3)
	j HANOI2

HANOI2: 	addi $s7, $s0, -1
	lw $t0, 0($s2)
	sw $t0, 0($s3)
	addi $s1, $s1, 0x04
	la $s1, ($s2)
	la $s0, ($s1)
	j HANOI