;Escriba una subrutina que reciba como parámetros las direcciones del comienzo de dos cadenas terminadas en cero y
;retorne la posición en la que las dos cadenas difieren. En caso de que las dos cadenas sean idénticas, debe retornar -1.

			.data
cada:		.asciiz	"Hola"
cadb:		.asciiz	"Hola"

			.code
			daddi	$a0, $zero, cada
			daddi	$a1, $zero, cadb
			jal		compStr
			halt
			
;			cargamos las posiciones a mirar en dos registros.
compStr:	dadd	$t1, $a0, $zero
			dadd	$t2, $a1, $zero
			;y tomamos los valores de memoria.
loop:		ld		$t3, 0($t1)
			ld		$t4, 0($t2)
			;actualizamos los punteros para la siguiente pasada
			daddi	$t1, $t1, 1
			daddi	$t2, $t2, 1
			;ahora comparamos los valores tomados de memoria.
			dsub	$t3, $t3, $t4
			;llevamos un contador con la cantidad de caracteres que procesamos	(que es el numero de char en el que estabamos)
			daddi	$t7, $t7, 1
			;como las cadenas terminan en cero, nos fijamos si uno de los chars es cero
			beqz	$t4, charZ
			;si los datos eran iguales, seguimos comparando
			beqz	$t3, loop
			;si no, las cadenas son distintas y debemos devolver $t7
			dadd	$v0, $zero, $t7
			jr		$ra
			nop
			
;			Tenemos un char que es cero. Si los dos eran cero (t3-t4 = 0) entonces llegamos al final y los dos strings terminaron juntos
;			Si no, las cadenas no son iguales! Tenemos que informar la posicion en que se produce la diferencia 
charZ:		beqz	$t3, equal
			dadd	$v0, $zero, $t7
			jr		$ra
			nop
			
equal:		daddi	$v0, $zero, -1
			jr		$ra
			nop