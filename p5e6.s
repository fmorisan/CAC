;Escriba una subrutina que reciba como parámetros un número positivo M de 64 bits, la dirección del comienzo de una
;tabla que contenga valores numéricos de 64 bits sin signo y la cantidad de valores almacenados en dicha tabla.
;La subrutina debe retornar la cantidad de valores mayores que M contenidos en la tabla.

			.data
Ml:			.word	350
cant:		.word	5
tabla:		.word	12, 13, 14, 351, 390

			.code
			ld		$a0, Ml($zero)
			daddi	$a1, $zero, tabla
			ld		$a2, cant($zero)
			jal		SUBRUT
			halt
			
;			Asumimos que tenemos valor de M en $a0, y tabla en $a1
SUBRUT:		dadd	$t0, $zero, $a1			;cargo offset de la tabla en registro $t0
			dadd	$t4, $zero, $a2			;cuantos datos tengo para procesar?
loop:		beqz	$t4, finSUBRUT			;si procese todos los datos, termino
			ld		$t1, 0($t0)				;cargo dato en posicion actual
			slt		$t2, $t1, $a0			; t2=1 si t1>a0
			daddi	$t0, $t0, 8				;agrego 8 al offset actual
			daddi	$t4, $t4, -1			;decremento el contador de elementos restantes en la tabla
			bnez	$t2, loop				;si mi comparacion fallo vuelvo al loop
											;si no...
			daddi	$t2, $zero, 0			;reseteo el registro de comparacion
			daddi	$v0, $v0, 1				;agrego 1 al resultado de "cuantos son mayores"
			j		loop					;y vuelvo al loop

finSUBRUT:	jr		$ra