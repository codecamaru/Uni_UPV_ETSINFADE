        ; z = a*x + y
        ; Tamaño de los vectores: 64 palabras
        ; Vector x
	.data
x:      .double 0,1,2,3,4,5,6,7,8,9
        .double 10,11,12,13,14,15,16,17,18,19
        .double 20,21,22,23,24,25,26,27,28,29
        .double 30,31,32,33,34,35,36,37,38,39
        .double 40,41,42,43,44,45,46,47,48,49
        .double 50,51,52,53,54,55,56,57,58,59

	; Vector y
y:      .double 100,100,100,100,100,100,100,100,100,100
	.double 100,100,100,100,100,100,100,100,100,100
	.double 100,100,100,100,100,100,100,100,100,100
	.double 100,100,100,100,100,100,100,100,100,100
	.double 100,100,100,100,100,100,100,100,100,100
	.double 100,100,100,100,100,100,100,100,100,100

        ; Vector z
	; 60 elementos son 480 bytes
z:      .space 480

        ; Escalar a
a:      .double 1

        ; El código
	.text

start:
	dadd r1,r0,y     ; r1 contiene la direccion de y
        dadd r2,r0,x     ; r2 contiene la direccion de x
	dadd r4,r0,z	 ; r4 contiene la direccion de z
        l.d f0,a(r0)     ; f0 contiene a
        dadd r3,r1,#480	 ; 60 elementos son 480 bytes
loop:
        l.d f4,0(r2)	; contenido componente x
	l.d f6,8(r2)
	l.d f2,0(r1)	; contenido componente y
	l.d f8,8(r1)
	mul.d f4,f0,f4	; multiplica comp.x por a
	mul.d f6,f0,f6
	dadd r1,r1,#16	; next y
	dadd r2,r2,#16	; next x
        add.d f4,f4,f2	; suma con comp.y
	add.d f6,f6,f8
	dsub r6,r3,r1	; contador
        s.d f4, 0(r4)	; guarda en z
	s.d f6, 8(r4)
        dadd r4,r4,#16	; next z
        bnez r6,loop	; conprueba contador

        trap #0         ; Fin de programa
        


