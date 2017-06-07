.text 
	add $t0, $sp, -28	# primera posicion del palo A
	add $t1, $t0, 4		# primera posicion del palo B
	add $t2, $t1, 4		# primera posicion del palo C
	# para agregar otro valor a la pila usar (adress +20h, 32D)
	li $s0, 10		# n de discos
MAIN:
	add $s1, $zero, 1	# s1 is used for loading the first stack
	#jal FIRST_STACK	# Calling procedure
	#j EXIT			# Jump to Main label
FIRST_STACK:
	#slti $t3, $s1, $s0 	# if n<1, t=1 hasta que imprima todas los discos
	bne $s1, $s0, LOAD 	# ciclo para cargar la primera columna
	sw $s1, 0($t0) 		# guarda el valor del discos actual en la localidad indicada
	add $t4, $zero, 1	# bit para checar si el n�mero es impar
	and $t4, $t4, $s0	# si es par $t4 ser� 0, si es impar $t4 ser� 1
	j CONTINUE			# continuar a la rutina para mover los discos
LOAD:	
	sw $s1, 0($t0) 		# guarda el valor del discos actual en la localidad indicada
	addi $s1, $s1, 1 	# reducir n
	addi $t0, $t0, 32	# mover el puntero de la primera columna a la siguiente posici�n
	j FIRST_STACK		# contin�a ordenando la primera columna
CONTINUE:
	add $t1, $t0, 4		# primera posicion del palo B
	add $t2, $t1, 4		# primera posicion del palo C
	add $t0, $sp, -28	# primera posicion del palo A
	
	jr $ra 
EXIT:
