.text:

main:
    # Cargo posicion de memoria de src y dst
    la a0, src
    la a1, dst
    
    # Cargo longitud del array (hardcodeada)
    li a2, 12
    
    call ej2
    j imprimir
    
ej2:
    # Guardo los valores que quiero mantener
    mv s0, a0    # direccion del src
    mv s1, a1    # direccion del dst
    mv s2, a2    # elementos por ver
    mv s3, ra    # return address para que, cuando termine el loop, vuelva a linea 12 
    mv s4, zero

loop:
    # si tengo 0 elementos por ver, termino el loop
    beq s2, s4 return
   
    
    # Si el índice es par, voy a la siguiente iteracion
    andi t0, s4, 1  
    beqz t0, prox_iteracion
    
    # Si es impar, copio la posicion de src a dst
    # Cargo la word actual de src en a0
    lw a0, 0(s0)
    
    sw a0, 0(s1)  # Escribo el elemento de src en dst si el índice es impar

prox_iteracion:
    # Incremento la dirección del src y reduzco el total de elementos
    addi s0, s0, 4  # Incremento src
    addi s1, s1, 4  # Incremento dst
    addi s4, s4, 1  # Incremento índice
    j loop

return:
    ret

imprimir:
    la t2, dst
    # Cantidad de datos.
    li t3, 12
loop_imprimir:
    beqz t3, exit
    addi t3, t3, -1
    lw t4, 0(t2)
    # Imprime el resultado
    mv a0, t4
    li a7, 34
    ecall
    addi t2, t2, 4

    j loop_imprimir
exit:
    # Termina el programa.
    li a0, 0
    li a7, 93
    ecall

.data:
src:
.word 0xffffffff, 0x95555555, 0xf4444444, 0xf1111111
.word 0xffffff00, 0xf5005555, 0x95444444, 0xf1113311
.word 0xff00ffff, 0xf5550055, 0xa4444433, 0xa1551111
dst:
.word 0, 0, 0, 0
.word 0, 0, 0, 0
.word 0, 0, 0
