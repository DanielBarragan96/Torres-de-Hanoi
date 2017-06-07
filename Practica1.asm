.text 
	addi $sp, $sp, -28 		# Para comenzar en la primer colulmna
	add $t0, $sp, 0x00		# Begin base adress
	add $s7, $zero, 0x03	# N
	addi $s0, $zero, 0x01	# Contador
	
MAIN:
	jal IDATOS 		# Calling procedure
	addi $t1, $t0, 4 		# Columna B
	addi $t2, $t1, 4 		# Columna C
	and $s6, $s7, 1		# Para ver si es par o non
	beq $s6, 1, HANOI
	lw $s1, 0($sp)		# Guardamos valor de la columna inicial a s1
	j COLB			# Jump to Main label
	
IDATOS:	
	bne $s0, $s7, INTRODUCIR
	sw $s0, 0($t0) 		#Incertamos dato en la columna
	jr $ra			# Return to the caller	

INTRODUCIR:	
	sw $s0, 0($t0) 		# Storing the resturn address
	addi $s0, $s0, 1 		# Decreasing n
	addi $t0, $t0, 0x20		# Avanzar fila
	j IDATOS

HANOI:	
	lw $s1, 0($sp)		# Guardamos valor de la columna inicial a s1
	beq $s1, $s7, FINAL		# Si ya llegamos al último valor agregado
 COLC:	lw $t7, 0($t2)
	bne $t7, $zero, COLB 	# Revisar columna C
	sw $s1, 0($t2)
	sub $s5, $s1, 1
	beq $s5, 1, ESDOS
	j MOV
 COLB:	lw $t7, 0($t1)		# Revisar columna B
	bne $t7, $zero, NIVELAR
	sw $s1, 0($t1)
	sub $s5, $s1, 1
	beq $s5, 1, ESDOS
	j MOV	

NIVELAR:	
	#COMO SABER QUE EL NUMERO ES MAYOR. CON UNA RESTA?
	#j UNO
	addi $t2, $t2, -0x20
	addi $t1, $t1, -0x20
	j COLC

ESDOS:	lw 1, -32(t
	
MOV: 
	sw $zero, 0($sp)
	addi $sp, $sp, 0x20
	j HANOI
MOV2:	
	sw $s1, 0($t0)

FINAL:    
	
	sw $s1, 0($t2)		# Movemos ultimo valor a la columna C
	sw $zero, 0($sp)		# Borramos el valor de la columna A
	j COLC			# Continuamos llenando la columna
	
EXIT: