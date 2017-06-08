.text 
	add $t0, $sp, -28	# primera posicion del palo A
	# para agregar otro valor a la pila usar (adress +20h, 32D)
	addi $s0, $zero, 4	# n de discos
MAIN:
	add $s1, $zero, 1	# s1 is used for loading the first stack
	#jal FIRST_STACK	# Calling procedure
	#j EXIT			# Jump to Main label
FIRST_STACK:
	#slti $t3, $s1, $s0 	# if n<1, t=1 hasta que imprima todas los discos
	bne $s1, $s0, LOAD 	# ciclo para cargar la primera columna
	sw $s1, 0($t0) 		# guarda el valor del discos actual en la localidad indicada
	j CONTINUE		# continuar a la rutina para mover los discos
LOAD:	
	sw $s1, 0($t0) 		# guarda el valor del discos actual en la localidad indicada
	addi $s1, $s1, 1 	# reducir n
	addi $t0, $t0, 32	# mover el puntero de la primera columna a la siguiente posición
	j FIRST_STACK		# continúa ordenando la primera columna
CONTINUE:
	add $t1, $t0, 4		# primera posicion del palo B
	add $t2, $t1, 4		# primera posicion del palo C
	add $t0, $sp, -28	# primera posicion del palo A
	sub $sp, $sp, 20
	add $s2, $zero, $zero
	# condiciones para mover la primera ficha
	add $t6, $t0, $zero	# 
	add $t7, $t1, $zero	# 
	add $t5, $t2, $zero	# 
COLI: 
	add $s2, $s2, 1
	beq $s2, 4, CASE4
	beq $s2, 1, CASE1
	beq $s2, 2, CASE2
	beq $s2, 3, CASE3
	j EXIT
CASE4:	add $s2, $s2, -3
CASE1:	add $t0, $t6, $zero	# 
	add $t1, $t7, $zero	# 
	add $t2, $t5, $zero	# 
	add $t5, $t0, $zero	# primera columna A
	add $t6, $t1, $zero	# primera columna B
	add $t7, $t2, $zero	# primera columna C
	j MOVE			# keep moving
CASE2:	add $t0, $t5, $zero	# 
	add $t1, $t6, $zero	# 
	add $t2, $t7, $zero	# 
	add $t5, $t2, $zero	# primera columna A
	add $t6, $t0, $zero	# primera columna B
	add $t7, $t1, $zero	# primera columna C
	j MOVE			# keep moving
CASE3:	add $t0, $t7, $zero	# 
	add $t1, $t5, $zero	# 
	add $t2, $t6, $zero	# 
	add $t5, $t1, $zero	# primera columna A
	add $t6, $t2, $zero	# primera columna B
	add $t7, $t0, $zero	# primera columna C
MOVE:	
	lw $s1, 0($sp)
	beq $s1, 1, EXIT
	add $t4, $zero, 1	# bit para checar si el número es impar
	and $s4, $t4, $s0	# si es par $s4 será 0, si es impar $t4 será 1
	lw $s3, 0($t5)		# valor de la pila actual
	and $t4, $t4, $s3	# si es par $t4 será 0, si es impar $t4 será 
	beq $s4, $zero, PAR	# brinca si es par
	beq $t4, $zero, DER	# el valor en A es par
	j IZQ			# el valor en A es impar
PAR:
	beq $t4, $zero, IZQ	# el valor en A es par
	j DER			# el valor en A es impar
CHECKMOVE:
	beq $a0, $zero, COLI
	beq $a1, $zero, RET
	sub $a0, $a1, $a0
	srl $a0, $a0, 31
	beq $a0, $zero, RET
	j COLI
RET:	jr $ra
DER: 
	lw $a0, 0($t5)
	lw $a1, 0($t6)
	jal CHECKMOVE
	beq $a1, $zero, ZEROD #lw $s7, 0($t6)
	add $t6, $t6, -32
ZEROD:	lw $s7, 0($t5)
	sw $zero, 0($t5)
	sw $s7, 0($t6)
	#lw $s7, 0($t5)
	#beq $s7, $zero, MOVE
	add $t5, $t5, 32
	j MOVE 	
IZQ: 
	lw $a0, 0($t5)
	lw $a1, 0($t7)
	jal CHECKMOVE
	beq $a1, $zero, ZEROI
	add $t7, $t7, -32
ZEROI:	lw $s7, 0($t5)
	sw $zero, 0($t5)
	sw $s7, 0($t7)
	#lw $s7, 0($t5)
	#beq $s7, $zero, MOVE
	add $t5, $t5, 32
	j MOVE 	
EXIT:
