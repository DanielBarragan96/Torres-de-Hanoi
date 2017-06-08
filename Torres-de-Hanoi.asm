# Daniel Barragán Alvarez ie702554
# Sergio Chung Correa ie702272
.text 
	addi $t0, $sp, -28	# primera posicion del palo A
	# para agregar otro valor a la pila usar (adress +20h, 32D)
	addi $s0, $zero, 8	# n de discos
MAIN:
	addi $s1, $zero, 1	# s1 is used for loading the first stack
FIRST_STACK:
	bne $s1, $s0, LOAD 	# ciclo para cargar la primera columna
	sw $s1, 0($t0) 		# guarda el valor del discos actual en la localidad indicada
	j CONTINUE		# continuar a la rutina para mover los discos
LOAD:	
	sw $s1, 0($t0) 		# guarda el valor del discos actual en la localidad indicada
	addi $s1, $s1, 1 	# reducir n
	addi $t0, $t0, 32	# mover el puntero de la primera columna a la siguiente posición
	j FIRST_STACK		# continúa ordenando la primera columna
CONTINUE:
	addi $t1, $t0, 4	# primera posicion del palo B
	addi $t2, $t1, 4	# primera posicion del palo C
	addi $t0, $sp, -28	# primera posicion del palo A
	sub $sp, $sp, 20	# se mueve el sp a la última posición de la última columna
	# condiciones para mover la primera ficha
	add $s2, $zero, $zero	# se inicializa i en cero
	add $t6, $t0, $zero	# se cargan los valores de t6 para el primer caso
	add $t7, $t1, $zero	# se cargan los valores de t7 para el primer caso
	add $t5, $t2, $zero	# se cargan los valores de t5 para el primer caso
COLI: 
	addi $s2, $s2, 1	# se aumenta i (contador de columna actual)
	beq $s2, 4, CASE4	# si i = 4
	beq $s2, 1, CASE1	# si i = 1
	beq $s2, 2, CASE2	# si i = 2
	beq $s2, 3, CASE3	# si i = 3
	j EXIT			# en caso de error termina
CASE4:	addi $s2, $s2, -3	# si fue 4 se resetea a 1
CASE1:	add $t0, $t6, $zero	# actualiza valor de columna A
	add $t1, $t7, $zero	# actualiza valor de columna B
	add $t2, $t5, $zero	# actualiza valor de columna C
	add $t5, $t0, $zero	# primera columna A
	add $t6, $t1, $zero	# primera columna B
	add $t7, $t2, $zero	# primera columna C
	j MOVE			# keep moving
CASE2:	add $t0, $t5, $zero	# actualiza valor de columna A
	add $t1, $t6, $zero	# actualiza valor de columna B
	add $t2, $t7, $zero	# actualiza valor de columna C
	add $t5, $t1, $zero	# primera columna A
	add $t6, $t2, $zero	# primera columna B
	add $t7, $t0, $zero	# primera columna C
	j MOVE			# keep moving
CASE3:	add $t0, $t7, $zero	# actualiza valor de columna A
	add $t1, $t5, $zero	# actualiza valor de columna B
	add $t2, $t6, $zero	# actualiza valor de columna C
	add $t5, $t2, $zero	# primera columna A
	add $t6, $t0, $zero	# primera columna B
	add $t7, $t1, $zero	# primera columna C
MOVE:	
	lw $s1, 0($sp)		# obtiene el valor de la última pila
	beq $s1, 1, EXIT	# checa si el valor más alto de la última pila es 1
	lw $s3, 0($t5)		# valor de la pila actual
	beq $s3, $zero, COLI	# si el último valor de esa columna es cero pasa a la siguiente
	addi $t4, $zero, 1	# bit para checar si el número es impar
	and $s4, $t4, $s0	# si es par $s4 será 0, si es impar $t4 será 1
	and $t4, $t4, $s3	# si es par $t4 será 0, si es impar $t4 será 
	#beq $s4, $zero, PAR	# brinca si es par
	beq $t4, $zero, DER	# el valor en A es par
	j IZQ			# el valor en A es impar
#PAR:	#si quisiera optimizarse para fichas pares, debería de cambiarse COLI
	#beq $t4, $zero, IZQ	# el valor en A es par
	#j DER			# el valor en A es impar
CHECKMOVE:
	beq $a0, $zero, COLI	# si tu valor en la columna es cero pasa a la siguiente
	beq $a1, $zero, RET	# si vas a mover a una posicion con valor cero regresar a hacerlo
	sub $a0, $a1, $a0	# restarle al valor de fin el valor de origen
	srl $a0, $a0, 31	# hace shift right logical 31 veces para quedarnos con el bit más significativo
	beq $a0, $zero, RET	# si el bit fue cero entonces la ficha a mover es menor, y se puede hacer el movimiento
	j COLI			# si el bit fue uno se pasa a la siguiente columna
RET:	jr $ra			# regresa a donde fue llamado
DER: 
	lw $a0, 0($t5)		# carga el valor de la columna actual
	lw $a1, 0($t6)		# carga el valor de la columna a enviar
	jal CHECKMOVE		# verifica si es un valor válido a mover
	beq $a1, $zero, ZEROD 	# si el valor en la posicion a mover es cero no se mueve su dirección #lw $s7, 0($t6)
	addi $t6, $t6, -32	# si el valor no es cero se aumenta su dirección
ZEROD:	lw $s7, 0($t5)		# se carga el valor de la ficha a mover
	sw $zero, 0($t5)	# se borra el valor de la ficha a mover	
	sw $s7, 0($t6)		# se escribe el valor de la ficha a mover
	addi $t5, $t5, 32	# se mueve la dirección de origen
	lw $a2, 0($t5)		# se carga el valor de t5
	bne $a2, $zero, MOVE	# si el valor no es cero aún hay fichas por lo que seguimos con MOVE
	sub $t5, $t5, 32	# si fue cero, le restamos 32 a t5 para quedar en la posición inicial
	j MOVE 			# regresa a MOVE
IZQ: 
	lw $a0, 0($t5)		# carga el valor de la columna actual
	lw $a1, 0($t7)		# carga el valor de la columna a enviar
	jal CHECKMOVE		# verifica si es un valor válido a mover
	beq $a1, $zero, ZEROI	# si el valor en la posicion a mover es cero no se mueve su dirección #lw $s7, 0($t6)
	addi $t7, $t7, -32	# si el valor no es cero se aumenta su dirección
ZEROI:	lw $s7, 0($t5)		# se carga el valor de la ficha a mover
	sw $zero, 0($t5)	# se borra el valor de la ficha a mover
	sw $s7, 0($t7)		# se escribe el valor de la ficha a mover
	addi $t5, $t5, 32	# se mueve la dirección de origen
	lw $a2, 0($t5)		# se carga el valor de t5
	bne $a2, $zero, MOVE	# si el valor no es cero aún hay fichas por lo que seguimos con MOVE
	sub $t5, $t5, 32	# si fue cero, le restamos 32 a t5 para quedar en la posición inicial
	j MOVE 			# regresa a MOVE
EXIT:
