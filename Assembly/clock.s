                ##########################################################
                # Segmento de datos
                ##########################################################

                .data 0x10000000
reloj:          .word 0                # HH:MM:SS (3 bytes de menor peso)

cad_asteriscos: .asciiz "\n  **************************************"
cad_horas:      .asciiz "\n   Horas: "
cad_minutos:    .asciiz " Minutos: "
cad_segundos:   .asciiz " Segundos: "
cad_reloj_en_s: .asciiz "\n   Reloj en segundos: "

                ##########################################################
                # Segmento de c�digo
                ##########################################################

                .globl __start
                .text 0x00400000

              #  la $a0, reloj #
              #  li $a1, 0x0002030C #
               # jal inicializa_reloj #

               # la $a0, reloj #
               # li $a1, 0x12  #
                #li $a2, 0x20 #
                #li $a3, 0x2d #
                #jal inicializa_reloj_alt #
               # la $a0, reloj #
               # jal devuelve_reloj_en_s #
                #move $a0,$v0 #
               # jal imprime_s #

               la $a0,reloj
               li $a1,66765
               jal inicializa_reloj_en_s

__start:        la $a0, reloj
                jal imprime_reloj
             
salir:          li $v0, 10              # C�digo de exit (10)
                syscall                 # �ltima instrucci�n ejecutada
                .end


                ########################################################## 
                # Subrutina que imprime el valor del reloj
                # Entrada: $a0 con la direcci�n de la variable reloj
                ########################################################## 

imprime_reloj:  move $t0, $a0
                la $a0, cad_asteriscos  # Direcci�n de la cadena
                li $v0, 4               # C�digo de print_string
                syscall

                la $a0, cad_horas       # Direcci�n de la cadena
                li $v0, 4               # C�digo de print_string
                syscall

                lbu $a0, 2($t0)         # Lee el campo HH
                li $v0, 1               # C�digo de print_int
                syscall

                la $a0, cad_minutos     # Direcci�n de la cadena
                li $v0, 4               # C�digo de print_string
                syscall

                lbu $a0, 1($t0)         # Lee el campo MM
                li $v0, 1               # C�digo de print_int
                syscall

                la $a0, cad_segundos    # Direcci�n de la cadena
                li $v0, 4               # C�digo de print_string
                syscall

                lbu $a0, 0($t0)         # Lee el campo SS
                li $v0, 1               # C�digo de print_int
                syscall

                la $a0, cad_asteriscos  # Direcci�n de la cadena
                li $v0, 4               # C�digo de print_string
                syscall
                jr $ra

                ########################################################## 
                # Subrutina que imprime los segundos calculados
                # Entrada: $a0 con los segundos a imprimir
                ########################################################## 

imprime_s:      move $t0, $a0
                la $a0, cad_asteriscos  # Direcci�n de la cadena
                li $v0, 4               # C�digo de print_string
                syscall


                la $a0, cad_reloj_en_s  # Direcci�n de la cadena
                li $v0, 4               # C�digo de print_string
                syscall

                move $a0, $t0           # Valor entero a imprimir
                li $v0, 1               # C�digo de print_int
                syscall

                la $a0, cad_asteriscos  # Direcci�n de la cadena
                li $v0, 4               # C�digo de print_string
                syscall
                jr $ra
                
                ########################################################## 
                # Subrutina que incrementa el reloj en una hora
                # Entrada: $a0 con la direcci�n del reloj
                # Salida: reloj incrementado en memoria
                # Nota: 23:MM:SS -> 00:MM:SS
                ########################################################## 
                
inicializa_reloj: 
                li $t0,0x001F3F3F
                and $a1, $a1, $t0
                sw $a1,0($a0) 
                jr $ra 

inicializa_reloj_alt: 
                sll $a1,$a1,16
                sll $a2,$a2,8
                or $a1,$a1,$a2 
                or $a1,$a1,$a3 
                sw $a1,0($a0) 
                jr $ra 

inicializa_reloj_hh:
                sw $a1, 2($a0)
                jr $ra

inicializa_reloj_mm:
                sw $a1, 1($a0)
                jr $ra

inicializa_reloj_ss:
                sw $a1, 0($a0)
                jr $ra

devuelve_reloj_en_s:
                lbu $t0,2($a0)
                li $t1, 3600
                multu $t0,$t1
                mflo $v0 
                lbu $t0,1($a0)
                li $t1, 60
                multu $t0,$t1
                mfhi $t4
                bne $zero,$t4,salir
                mflo $t2
                lbu $t3,0($a0)
                addu $t2,$t2,$t3
                addu $v0, $v0, $t2
                jr $ra

inicializa_reloj_en_s:
                li $t2,60
                divu $a1,$t2
                mfhi $t0
                sb $t0,0($a0)
                mflo $t1
                beqz $t1, salir
                divu $t1,$t2
                mfhi $t0
                sb $t0,1($a0)
                mflo $t3
                sb $t3,2($a0)
                jr $ra

pasa_hora:      lbu $t0, 2($a0)         # $t0 = HH
                addiu $t0, $t0, 1       # $t0 = HH++
                li $t1, 24
                beq $t0, $t1, H24       # Si HH==24 se pone HH a cero
                sb $t0, 2($a0)          # Escribe HH++
                j fin_pasa_hora
H24:            sb $zero, 2($a0)        # Escribe HH a 0
fin_pasa_hora:  jr $ra
