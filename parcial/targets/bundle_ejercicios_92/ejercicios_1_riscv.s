.text:
main:
    # Cargo posicion de memoria del arreglo
    la a0, arr
    # Cargo cuantos elementos me quedan por ver (hardcodeado)
    li a1, 12
    # Defino al registro s2 en 0, para que al hacerle OR sea el "elemento neutro"
    mv a2, zero

    call ej1
    
exit:
    # Imprime la suma
    mv a0, t4
    li a7, 34
    ecall

    # Termina el programa.
    li a0, 0
    li a7, 93
    ecall

ej1:
    # Guardo los valores que quiero mantener
    mv s0, a0    # direccion del array
    mv s1, a1    # elementos por ver
    mv s2, a2    # suma
    mv s3, ra    # return address
    mv s4, zero  # indice

loop:
    # si i=long, termino el loop
    beq s1, s4, return
    
    # Si el indice es par, no hago la disyuncion y sigo adelante
    andi t0, s4, 1  # Compruebo si el indice de elemento es par
    beqz t0, prox_iteracion
    
    # cargo la halfword en a0. Uso lhu así carga sin FFFF al principio, sino con 0000
    lhu a0, 0(s0)
    
    # Pongo en a1 la suma, así hago or(a0, a1)
    mv a1, s2
    call disyuncion

    # En a0 tengo el resultado de or(a0, a1). Piso s2 con eso.
    mv s2, a0

prox_iteracion:
    # Incremento la dirección al siguiente elemento en 2, para la siguiente posicion del array
    addi s0, s0, 2
    
    # aumento el indice
    addi s4, s4, 1

    j loop

return:
    # Piso t4, donde tengo que poner el resultado para imprimir la suma, con mi respuesta
    mv t4, s2
    # Devuelvo ra a su valor previo a ejecutar el ciclo
    mv ra, s3
    ret 


disyuncion:
    # hace la disyuncion entre a0 y a1, y la guarda en a0
    or a0, a0, a1
    ret


.data:
arr:
.half	0xffff, 0x9555, 0xf444, 0xf111
.half	0xffff, 0xf500, 0x9544, 0xf111
.half	0xff00, 0xf555, 0xa444, 0xA155
