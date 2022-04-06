        .data
a:      .dword  9,8,0,1,0,5,3,1,2,0
tam:    .dword 10       ; Tamaño del vector
cont:   .dword 0        ; Número de componentes == 0

        .text
start:	dadd r1,$gp,a   ; Puntero
        ld r4,tam($gp)  ; Tamaño lista
        dadd r10,r0,r0  ; Contador de ceros
 
loop:	ld r2, 0(r1)
	seq r2, r2, r0 ; pone r2 a 1 si componente es 0
	beqz r2,noSuma  ; si r2 es 0, no sumamos
	daddi r10,r10,1  ; sumamos 1 a contador ceros
	sd r10,cont($gp)  ; almacenamos en cont memoria la cantidad de ceros
noSuma: dsubi r4,r4,1  ; disminuyo lo que recorro
	daddi r1,r1,8  ; iteramos puntero vector
	bnez r4, loop  ; si tamaño !=0, volvemos a loop
        trap #0 
