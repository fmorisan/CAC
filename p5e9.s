;Implemente la subrutina factorial definida en forma recursiva. Tenga presente que el factorial de un número
;entero n se calcula como el producto de los números enteros entre 1 y n inclusive: 

			.data
valor:		.word	6
result:		.word	0

			.text
			daddi	$sp, $0, 0x400	; definimos nuestro vector de pila
			ld		$a0, valor($0)	; cargamos el valor
			ld		$a1, valor($0)	; dos veces para saber cuando es que entramos a la subrutina
			jal		factorial
			sd		$v0, result($0)	; guardamos el resultado del proceso
			halt
			
factorial:	bne		$a0, $a1, calc	; si esta es la primer vez que iteramos, hacemos el procedimiento sig.
			daddi	$sp, $sp, -8	; agarramos lugar en la pila
			sd		$ra, 0($sp)		; apilamos el $ra
			daddi	$v0, $0, 1		; y definimos $v0 como el lugar donde vamos a dejar los productos parciales

calc:		beqz	$a0, fin		; si $a0 = 0 llegamos al final y no debemos multiplicar mas
			dmul	$v0, $v0, $a0	; multiplicamos
			daddi	$a0, $a0, -1	; decrementamos $a0
			jal		factorial		; y llamamos de vuelta a factorial
fin:		ld		$ra, 0($sp)		;
			daddi	$sp, $sp, 8
			nop
			jr		$ra
			