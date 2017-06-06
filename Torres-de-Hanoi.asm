.text 
	add $t0, $sp, -28	# primera posicion del palo A
	add $t1, $t0, 4		# primera posicion del palo B
	add $t2, $t1, 4		# primera posicion del palo C
	# para agregar otro valor a la pila usar (adress +20h, 32D)
	li $s0, 10		# n de discos
MAIN:
	add $s1, $s0, $zero	# s1 is used for loading the first stack
	jal FIRST_STACK		# Calling procedure
	j EXIT			# Jump to Main label
FIRST_STACK:
	slti $t3, $s1, 1 	# if n<1, t=1 hasta que imprima todas los discos
	beq $t3, $zero, LOAD 	# ciclo para cargar la primera columna
	add $t4, $zero, 1	# bit para checar si el número es impar
	and $t4, $t4, $s0	# si es par $t4 será 0, si es impar $t4 será 1
	j MOVE			# continuar a la rutina para mover los discos
LOAD:	
	sw $s1, 0($t0) 		# guarda el valor del discos actual en la localidad indicada
	addi $s1, $s1, -1 	# reducir n
	addi $t0, $t0, 32	# mover el puntero de la primera columna a la siguiente posición
	j FIRST_STACK		# continúa ordenando la primera columna
MOVE:
	
	
	
	jr $ra 
EXIT: