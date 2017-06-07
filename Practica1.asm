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
	beq $s6, 1, INICIO
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

INICIO:	
	lw $s1, 0($sp)		# Guardamos valor de la columna inicial a s1
 COLC:	lw $t7, 0($t2)		#Cargamos lo que hay en t2 a t7
	bne $t7, $zero, COLB 	# Si t2 tiene un valor revisar columna B
	sw $s1, 0($t2)
	bne $s1, $zero, CERO
	addi $s3, $s3, 3
	j MOV
 COLB:	lw $t7, 0($t1)		# Cargar valor de
	bne $t7, $zero, HANOI
	sw $s1, 0($t1)
  CERO:	addi $s3, $s3, 2
	j MOV	
	
HANOI:	lw $s1, 0($sp)		# Guardamos valor de la columna inicial a s1
	beq $t2, $zero, COLC
	beq $t1, $zero, COLB
	and $s6, $s1, 1		# Para ver si es par o non. 1 es impar
	beq $s6, 1, RESTAR
	jal SUMAR

COLI: 	
	addi $t2, $t2, -0x20
	addi $t1, $t1, -0x20
	beq $s3, 1, UNO
	beq $s3, 2, DOS
	beq $s3, 3, tres
	
SUMAR:	addi $s3, $s3, 1
	beq $s3, 4, CAMB
	jal COLI
	
RESTAR: 	beq $s3, 1, NADA
	addi $s3, $s3, -1
  NADA: 	jal COLI
	
CAMB:	addi $s3, $s3, -2

UNO:	add $t5, $t5, $t0
DOS:	add $t5, $t5, $t1
TRES:	add $t5, $t5, $t2


		
MOV: 
	sw $zero, 0($sp)
	addi $sp, $sp, 0x20
	j HANOI
EXIT:
