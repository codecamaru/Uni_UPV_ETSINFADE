//Cuestion 1-3 apartado a
void prodmv(double a[N], double c[N], double B[N][N])
         {
           int i, j;
           double sum;
           #pragma omp parallel for private(sum,j)
           for (i=0; i<N; i++) {
             sum = 0;
             for (j=0; j<N; j++)
               sum += B[i][j] * c[j];
             a[i] = sum;
} }
// Cuestion 1-4 apartado b
double funcion(double A[M][N])
         {
           int i,j;
           double suma;
           #pragma omp parallel for private(i)
           for (j=0; j<N; j++) {
             for (i=0; i<M-1; i++) {
               A[i][j] = 2.0 * A[i+1][j];
            }
           }
           suma = 0.0;
           #pragma omp parallel for reduction(+:suma) private(j)
           for (i=0; i<M; i++) {
             for (j=0; j<N; j++) {
               suma = suma + A[i][j];
            }
           }
           return suma;
         }
// Cuestion 1-5 apartado a
// primera forma y la + eficiente
double fun_mat(double a[n][n], double b[n][n])
         {
           int i,j,k;
           double aux,s=0.0;
           #pragma omp parallel for reduction(+:s) private(j,k,aux)
           for (i=0; i<n; i++) {
             for (j=0; j<n; j++) {
               aux=0.0;
               s += a[i][j];
               for (k=0; k<n; k++) {
                 aux += a[i][k] * a[k][j];
               }
               b[i][j] = aux;
             }
}
return s; }
// segunda forma y la de eficiencia intermedia
double fun_mat(double a[n][n], double b[n][n])
         {
           int i,j,k;
           double aux,s=0.0;
           for (i=0; i<n; i++) {
            #pragma omp parallel for reduction(+:s), private(k,aux)
             for (j=0; j<n; j++) {
               aux=0.0;
               s += a[i][j];
               for (k=0; k<n; k++) {
                 aux += a[i][k] * a[k][j];
               }
               b[i][j] = aux;
             }
}
return s; }
// tercera forma y la - eficiente
double fun_mat(double a[n][n], double b[n][n])
         {
           int i,j,k;
           double aux,s=0.0;
           for (i=0; i<n; i++) {
             for (j=0; j<n; j++) {
               aux=0.0;
               s += a[i][j];
               #pragma omp parallel for reduction(+:aux)
               for (k=0; k<n; k++) {
                 aux += a[i][k] * a[k][j];
               }
               b[i][j] = aux;
             }
}
return s; }
// apartado c
double fun_mat(double a[n][n], double b[n][n])
         {
           int i,j,k;
           double aux,s=0.0;
           int numit = 0;
           int id;
           #pragma omp parallel for reduction(+:s) private(j,k,aux,id)
           for (i=0; i<n; i++) {
             for (j=0; j<n; j++) {
               aux=0.0;
               s += a[i][j];
               for (k=0; k<n; k++) {
                 aux += a[i][k] * a[k][j];
               }
               b[i][j] = aux;
             }
             id = omp_get_thread_num();
             if(!id){ numit++;}
            }
            printf("numero iteraciones realizadas por hilo 0 : %d", numit);
            return s;
         }
// Cuestion 1-6
#include <stdio.h>
#include <omp.h>
void main(){
    printf("introduce un nº positivo\n");
    int n,i;
    int ultimo;
    scanf("%d", &n);
    int suma = 0;
    omp_set_num_threads(6);
    #pragma omp parallel for reduction(+:suma) lastprivate(ultimo) schedule(dynamic,2)
    for(i = 1; i <= n; i++){
        ultimo = omp_get_thread_num();
        suma += i;
    }
    printf("identificador del hilo que ha sumado el último número %d y la suma total calculada = %d\n",ultimo,suma);
}
// Cuestion 1-7 apartado a
#define EPS 1e-9
#define N 128
int fun(double a[N][N], double b[], double x[], int n, int nMax)
{
    int i, j, k;
    double err=100, aux[N];
    // como el coste de este bucle es despreciable, no lo vamos a paralelizar
    for (i=0;i<n;i++){
        aux[i]=0.0;
    }
    for (k=0;k<nMax && err>EPS;k++) {
            err=0.0;
            #pragma omp parallel for reduction(+:err) private(j)
            for (i=0;i<n;i++) {
                x[i]=b[i];
                for (j=0;j<i;j++){
                    x[i]-=a[i][j]*aux[j];
                }
                for (j=i+1;j<n;j++){
                        x[i]-=a[i][j]*aux[j];
                }
                x[i]/=a[i][i];
                err+=fabs(x[i]-aux[i]);
            }
            for (i=0;i<n;i++){
                aux[i]=x[i];
            }
    }
    return k<nMax;
}
// cuestion 1-8

         #define N 6000
         #define PASOS 6
         double funcion1(double A[N][N], double b[N], double x[N])
         {
           int i, j, k, n=N, pasos=PASOS;
           double max=-1.0e308, q, s, x2[N];
           for (k=0;k<pasos;k++) {
             q=1;
             #pragma omp parallel for private(s,j) reduction(*:q)
             for (i=0;i<n;i++) {
               s = b[i];
               for (j=0;j<n;j++)
                 s -= A[i][j]*x[j];
               x2[i] = s;
               q *= s;
             }
             #pragma omp parallel for
             for (i=0;i<n;i++)
               x[i] = x2[i];
             if (max<q)
                max = q; }
            return max; 
        }
// cuestion 1-9
// apartado b
void func(double A[M][P], double B[P][N], double C[M][N], double v[M]) {
            int i, j, k;
            double mf, val;
            for (i=0; i<M; i++) {
               mf = 0;
               #pragma omp parallel for private(k,val) reduction(min: mf)
               for (j=0; j<N; j++) {
                  val = 2.0*C[i][j];
                  for (k=0; k<i; k++) {
                     val += A[i][k]*B[k][j];
                  }
                  C[i][j] = val;
                  if (val<mf) mf = val;
               }
                v[i] += mf;
            }
}
// apartado a
void func(double A[M][P], double B[P][N], double C[M][N], double v[M]) {
            int i, j, k;
            double mf, val;
            #pragma omp parallel for private(j,k,val,mf)
            for (i=0; i<M; i++) {
               mf = 0;
               for (j=0; j<N; j++) {
                  val = 2.0*C[i][j];
                  for (k=0; k<i; k++) {
                     val += A[i][k]*B[k][j];
                  }
                  C[i][j] = val;
                  if (val<mf) mf = val;
               }
                v[i] += mf;
            }
}
// cuestion 2-10
double cuad_mat(double a[N][N], double b[N][N])
         {
            int i,j,k;
            double aux, s=0.0;
            #pragma omp parallel for private(j,k,aux) reduction(+:s) schedule(dynamic,1)
            for (i=0; i<N; i++) {
               for (j=0; j<N; j++) {
                  aux = 0.0;
                  for (k=i; k<N; k++)
                     aux += a[i][k] * a[k][j];
                  b[i][j] = aux;
                  s += aux*aux;
               }
}
            return s; 
}
// cuestion 2-11
// apartado a
double f(double A[N][N], double B[N][N], double vs[N], double bmin) {
           int i, j;
           double x, y, aux, stot=0;
           #pragma omp parallel for private(aux,j,x,y) reduction(+:stot)
            for (i=0; i<N; i++) {
                aux = 0;
                for (j=0; j<N; j++) {
                    x = A[i][j]*A[i][j]/2.0;
                    A[i][j] = x;
                    aux += x;
                }
                for (j=i; j<N; j++) {
                    if (B[i][j]<bmin) y = bmin;
                    else              y = B[i][j];
                    B[i][j] = 1.0/y;
                }
                vs[i] = aux;
                stot += vs[i];
    }
            return stot;
        }
// apartado b
double f(double A[N][N], double B[N][N], double vs[N], double bmin) {
           int i, j;
           double x, y, aux, stot=0;
            for (i=0; i<N; i++) {
                aux = 0;
                #pragma omp parallel{
                    #pragma omp for reduction(+:aux) private(x) nowait
                    for (j=0; j<N; j++) {
                        x = A[i][j]*A[i][j]/2.0;
                        A[i][j] = x;
                        aux += x;
                    }
                    #pragma omp for private(y)
                    for (j=i; j<N; j++) {
                        if (B[i][j]<bmin) y = bmin;
                        else              y = B[i][j];
                        B[i][j] = 1.0/y;
                    }
                }
                vs[i] = aux;
                stot += vs[i];
    }
            return stot;
        }

// Cuestion 2-1
 int busqueda(int x[], int n, int valor)
         {
            volatile int encontrado=0; // con volatile aseguras que cuando se cambie su valor todos los hilos lo sepan 
            int i,salto;
            #pragma omp parallel private(i){
            i = omp_get_thread_num();
            salto = omp_get_num_threads();
            while (!encontrado && i<n) {
               if (x[i]==valor) {
                    encontrado=1; 
                }
               i += salto; 
            }
            }
            return encontrado;
         }
// cuestion 2-2
double norma(double v[], int n)
{
    int i,p;
    double r=0;
    #pragma omp parallel private(id){
        id = omp_get_thread_num();
        p = omp_get_num_threads();
        suma[id] = 0.0;
        #pragma omp for schedule(static)
        for(i = 0; i<n; i++){
            suma[id] += v[i]*v[i];
        }
    }
    for (i=0; i<p; i++){
           r += suma[i];
    }
    return sqrt(r);
}
// cuestion 2-3
void f(int n, double a[], double b[])
         {
            int i,id,numit;
            #pragma omp parallel private(id,numit,i){
                numit = 0; 
                id = omp_get_thread_num();
                #pragma omp for{
                for (i=0; i<n; i++) {
                    b[i]=cos(a[i]);
                    numit++;
                }}
                printf("yo soy %d y he hecho %d iteraciones", id, numit);
            }
}
// cuestion 2-4
// apartado b
void normaliza(double A[N][N])
         {
           int i,j;
           double suma=0.0,factor;
           #pragma omp parallel private(j) {
            #pragma omp for reduction(+:suma){ // si aquí pones un nowait, debido a la reducción,
            for (i=0; i<N; i++) {
             for (j=0; j<N; j++) {
               suma = suma + A[i][j]*A[i][j];
             }
            }
            }
           factor = 1.0/sqrt(suma); // podría ser que aquí se utilizara un valor incorrecto de suma
            #pragma omp for{
            for (i=0; i<N; i++) {
             for (j=0; j<N; j++) {
               A[i][j] = factor*A[i][j];
             }
            }
            }
           }
}
// cuestion 2-5
// apartado a
double ej(double x[M], double y[N], double A[M][N])
         {
            int i,j;
            double aux,s=0.0;
            #pragma omp parallel{
            #pragma omp for nowait{
            for (i=0; i<M; i++){
               x[i] = x[i]*x[i];
            }// al poner el nowait evitamos la sincronización al final de este for
            }
            #pragma omp for{
            for (i=0; i<N; i++){
               y[i] = 1.0+y[i];
            }
            }
            #pragma omp for private(j,aux) reduction(+:s)
            for (i=0; i<M; i++){
               for (j=0; j<N; j++) {
                  aux = x[i]-y[j];
                  A[i][j] = aux;
                  s += aux;
                }
            }
            }
            return s;
        }
// cuestion 2-6
         int n=...;
         double a,b[3];
    #pragma omp parallel sections{
        #pragma omp section{
         a = -1.8;
         fun1(n,&a);
         b[0] = a;
        }
        #pragma omp section{
         a = 3.2;
         fun2(n,&a);
         b[1] = a;
        }
        #pragma omp section{
         a = 0.25;
         fun3(n,&a);
         b[2] = a;
        }
    }
// cuestion 2-7
 void func(double a[],double b[],double c[],double d[])
         {
        #pragma omp parallel sections{
            #pragma omp section{
                f1(a,b);
                f2(b,b);
            }
            #pragma omp section{
                f3(c,d);
                f4(d,d);
            }
        }
           f5(a,a,b,c,d);
}
// cuestion 2-8
double f(double x[], double y[], double z[], int n)
         {
            int i, j;
            double s1, s2, a, res;
            #pragma omp parallel private(i,j){
                #pragma omp sections{
                    #pragma omp section{
                        T1(x,n);/* Tarea T1 */
                    }
                    #pragma omp section{
                        T2(y,n);/* Tarea T2 */
                    }
                    #pragma omp section{
                        T3(z,n);/* Tarea T3 */
                    }
                }
                #pragma omp sections{
                    #pragma omp section{ // como esto es secuencial, no tengo que especificar alcance variables
                        /* Tarea T4 */
                        for (i=0; i<n; i++) {
                            s1=0;
                            for (j=0; j<n; j++) s1+=x[i]*y[i];
                            for (j=0; j<n; j++) x[i]*=s1;
                                }
                    }
                    #pragma omp section{
                        /* Tarea T5 */
                        for (i=0; i<n; i++) {
                            s2=0;
                            for (j=0; j<n; j++) s2+=y[i]*z[i];
                            for (j=0; j<n; j++) z[i]*=s2;
                        }
                    }
                }                
            }

            /* Tarea T6 */
            a=s1/s2;
            res=0;
            for (i=0; i<n; i++) res+=a*z[i];
            return res;
}
// cuestion 2-9
    #pragma omp parallel{
        #pragma omp sections{
            #pragma omp section{
                minx = minimo(x,n); /*T1*/
            }
            #pragma omp section{
                maxx = maximo(x,n); /*T2*/
            }
            #pragma omp section{
                calcula_y(y,x,n); /*T4*/
            }
        }
        #pragma omp sections{
            #pragma omp section{
                calcula_z(z,minx,maxx,n); /* T3 */
            }
            #pragma omp section{
                calcula_x(x,y,n);/*T5*/
            }
        }
    }
    calcula_v(v,z,x);/*T6*/  
// cuestion 2-10    
// apartado a
double fun1(double a[],int n, int v0)
{// no se puede paralelizar debido a las dependencias entre las distintas iteraciones
        int i;
        a[0] = v0;
        for (i=1;i<n;i++){
            a[i] = genera(a[i-1],i);
        }
}
double compara(double x[],double y[],int n)
{
        int i;
        double s=0;
        #pragma omp parallel for reduction(+:s)
        for (i=0;i<n;i++){
            s += fabs(x[i]-y[i]);
        }
        return s;
}         
// apartado c
        /* fragmento del programa principal (main) */
        int i, n=10;
        double a[10], b[10], c[10], x=5, y=7, z=11, w;
        #pragma omp parallel{
            #pragma omp sections{
                #pragma omp section{
                    fun1(a,n,x);/*T1*/
                }
                #pragma omp section{
                    fun1(b,n,y);/*T2*/
                }
                #pragma omp section{
                    fun1(c,n,z);/*T3*/
                }
            }
            #pragma omp sections{
                #pragma omp section{
                    x = compara(a,b,n);/*T4*/
                }
                #pragma omp section{
                    y = compara(a,c,n);/*T5*/
                }
                #pragma omp section{
                    z = compara(c,b,n);/*T6*/
                }                
            }
        }
        w = x+y+z;/*T7*/
        printf("w:%f\n", w);
// cuestion 2-11
        double x,y,z,w=0.0;
        double x0=1.0,y0=3.0,z0=2.0;     /* punto inicial */
        double dx=0.01,dy=0.01,dz=0.01;  /* incrementos */
        #pragma omp parallel sections private(x,y,z) reduction(+:w){
                #pragma omp section{
                    x=x0;y=y0;z=z0;    /* busca en x */
                    while (fabs(f(x,y,z))<fabs(g(x0,y0,z0))) {x += dx;}
                    w += (x-x0);
                }
                #pragma omp section{
                    x=x0;y=y0;z=z0;    /* busca en y */
                    while (fabs(f(x,y,z))<fabs(g(x0,y0,z0))){ y += dy;}
                    w += (y-y0);
                }
                #pragma omp section{
                    x=x0;y=y0;z=z0;    /* busca en z */
                    while (fabs(f(x,y,z))<fabs(g(x0,y0,z0))) {z += dz;}
                    w += (z-z0);
                }
        }
        printf("w = %g\n",w);
// cuestion 2-13
void updatemat(double A[N][N])
         {
            int i,j;
            double s[N];
            #pragma omp parallel private(i,j)
            #pragma omp for
            for (i=0; i<N; i++) {/* suma de filas */
                s[i] = 0.0;
                for (j=0; j<N; j++)
                s[i] += A[i][j];
            }
            #pragma omp single
            for (i=1; i<N; i++)/* suma prefija */
                s[i] += s[i-1];
            #pragma omp for 
            for (j=0; j<N; j++) {/* escalado de columnas */
                for (i=0; i<N; i++)
                A[i][j] *= s[j];
            }
}
// cuestiones 2-14
double calcula()
         {
            double A[N][N],B[N][N],a,b,x,y,z;
            rellena(A,B); // T1
            #pragma omp parallel
            #pragma omp sections
            #pragma omp section
            a = calculos(A);// T2
            #pragma omp section
            b = calculos(B);// T3
            #pragma omp sections    
            #pragma omp section
            x = suma_menores(B,a);//T4
            #pragma omp section
            y = suma_en_rango(B,a,b); /* T5 */ 

            z=x+y; /*T6*/ 
            return z;
}
// cuestion 2-15
void procesa(image f1,image f2,image f3,image f4,image r1,image r2)
         {
            image d1,d2,d3;
            #pragma omp parallel sections{
                #pragma omp section{
                    difer(f2,f1,d1);/* Tarea 1 */
                }
                #pragma omp section{
                    difer(f3,f2,d2);/* Tarea 2 */
                }
                #pragma omp section{
                    difer(f4,f3,d3);/* Tarea 3 */
                }
                #pragma omp section{
                    difer(f4,f1,r2);/* Tarea 5 */
                }
            }
            suma(d1,d2,d3,r1);/* Tarea 4 */
}
// cuestion 2-16
double calculos_matriciales(double mat[n][n])
         {
           double x,y,z,aux,total;
           double t = omp_get_wtime();
           int nh;
           #pragma omp parallel{
            nh = omp_get_num_threads();
            #pragma omp sections{
                #pragma omp section{
                    x = A(mat);/* tarea A, coste: 3 n^2         */
                }
                #pragma omp section{
                    aux = B(mat);/* tarea B, coste: n^2           */
                }
            }
            #pragma omp sections{
                #pragma omp section{
                    y = C(mat,aux);/* tarea C, coste: n^2           */
                }
                #pragma omp section{
                    z = D(mat); /* tarea D, coste: 2 n^2         */
                }
            }
           }
           t = omp_get_wtime() - t;
           printf("el numero de hilos utilizado ha sido %d y se ha tardado %f", nh,t);
            total=x+y+z; /* tarea E (calcula tú su coste) */
            return total;
}
// cuestion 2-17
// apartado b
double funcion(double A[M][N], double maximo, double pf[])
         {
            int i,j,j2;
            double a,x,y;
            x = 0;
            for (i=0; i<M; i++) {
               y = 1;
               #pragma omp parallel{
                    #pragma omp for private(a) reduction(+:x) nowait
                    for (j=0; j<N; j++) {
                    a = A[i][j];
                    if (a>maximo) a = 0;
                    x += a;
                }
                #pragma omp for reduction(*:y)
                for (j2=1; j2<i; j2++) {
                    y *= A[i][j2-1]-A[i][j2];
                }
               }
               pf[i] = y; }
            return x; 
}
// apartado a
double funcion(double A[M][N], double maximo, double pf[])
         {
            int i,j,j2;
            double a,x,y;
            x = 0;
            #pragma omp parallel for reduction(+:x) private(y,a,j,j2)
            for (i=0; i<M; i++) {
               y = 1;
               for (j=0; j<N; j++) {
                  a = A[i][j];
                  if (a>maximo) a = 0;
                  x += a;
               }
               for (j2=1; j2<i; j2++) {
                  y *= A[i][j2-1]-A[i][j2];
               }
               pf[i] = y; }
            return x; 
}
// cuestion 2-18
void funcion() {
  double x,y,z,a,b,c,d,e;
  int n;
  n = lee_datos(&x,&y,&z);/* Tarea 1 (n flops)    */
  a = f2(x,n);/* Tarea 2 (2n flops)   */
  b = f3(y,n);/* Tarea 3 (2n flops)   */
  c = f4(z,a,n);/* Tarea 4 (n^2 flops)  */
  d = f5(&x,&y,n);/* Tarea 5 (3n^2 flops) */
  e = f6(z,b,n);/* Tarea 6 (n^2 flops)  */
  escribe_resultados(c,d,e);/* Tarea 7 (n flops)    */
}


// cuestion 3-2
void f(int n, double v[], double x[], int ind[])
         {
            int i;
            double aux;
            #pragma omp parallel for private(aux)
            for (i=0; i<n; i++) {
               aux = max(x[ind[i]],f2(v[i]));
               if(x[ind[i]]<aux){
                #pragma omp critical {
                if(x[ind[i]]<aux){
                    x[ind[i]] = aux;
                }
               }
               }
               
            }
}
// cuestion 3-3
int buscar(int x[], int n, int valor)
         {
            int i, pos=-1;
            #pragma omp parallel for reduction(max:pos)
            for (i=0; i<n; i++)
               if (x[i]==valor)
                pos=i;
            return pos; 
        }
// cuestion 3-4
        #pragma omp parallel for private(j,s) 
        for (i=0; i<n; i++) {
             s = 0;
             for (j=0; j<n; j++)
               s += fabs(A[i][j]);
             if (s>norm)
               #pragma omp critical 
               if (s>norm)
                norm = s;
        }
// cuestion 3-5
double prod(double v[], int n)
         {
           double p=1;
           int i;
           #pragma omp parallel for reduction(*:p)
           for (i=0;i<n;i++)
             p *= v[i];
           return p;
}
double prod(double v[], int n)
         {
           double p=1;
           int i; double aux;
           #pragma omp parallel private(aux){
                #pragma omp for nowait
                for (i=0;i<n;i++)
                    aux *= v[i];
                #pragma omp critical 
                p *= aux;
           }
           return p;
}
// cuestion 3-6
// apartado a
int cmp(int n, double x[], double y[], int z[])
         {
           int i, v, equal=0;
           double aux;
           #pragma omp parallel for private(aux,v) reduction(+:equal)
           for (i=0; i<n; i++) {
             aux = x[i] - y[i];
             if (aux > 0) v = 1;
             else if (aux < 0) v = -1;
             else v = 0;
             z[i] = v;
             if (v == 0){
                equal++;
             } 
            }
           return equal;
         }
// apartado b
int cmp(int n, double x[], double y[], int z[])
         {
           int i, v, equal=0;
           double aux; int numhilos, id;
           #pragma omp parallel private(aux,v)
                numhilos = omp_get_num_threads();
                id = omp_get_thread_num();
           for (i=id; i<n; i+=numhilos) {
             aux = x[i] - y[i];
             if (aux > 0) v = 1;
             else if (aux < 0) v = -1;
             else v = 0;
             z[i] = v;
             if (v == 0) 
                #pragma omp atomic
                    equal++;
            }
           return equal;
         }
// cuestion 3-7
// apartado a
#pragma omp parallel for private(j,s) schedule(dynamic,1)
for (i=0; i<n; i++) {
            s = 0;
            for (j=0; j<i; j++) {// las últimas iteraciones costarán más
               s += A[i][j]*b[j];
            }
            c[i] = s;
            #pragma omp atomic
            x[ind[i]] += s;
}
// apartado b
for (i=0; i<n; i++) {
            s = 0;
            #pragma omp parallel for reduction(+:s)
            for (j=0; j<i; j++) {
               s += A[i][j]*b[j];
            }
            c[i] = s;
            x[ind[i]] += s;
}
// cuestion 3-8
void normalize(double *a, int n)
         {
           double mx, mn, factor;
           int i, nh;
           mx = a[0];
           mn = a[0];
                #pragma omp parallel 
                        #pragma omp for reduction(max:mx) nowait
                        for (i=1;i<n;i++) {
                            if (mx<a[i]) mx=a[i];
                        }
                        #pragma omp for reduction(min:mn)
                        for (i=1;i<n;i++) {
                            if (mn>a[i]) mn=a[i];
                        }
                        factor = mx-mn;
                        #pragma omp for 
                        for (i=0;i<n;i++) {
                        a[i]=(a[i]-mn)/factor;
                        }
                    #pragma omp single
                    printf(" numero de hilos usados %d\n", omp_get_num_threads());
}
// cuestion 3-9
int funcion(int n, double v[])
         {
           int i,pos_max=-1;
           double suma,norma,aux,max=-1;
           suma = 0;
           #pragma omp parallel{
            #pragma omp for reduction(+:suma) schedule(dynamic,2)
                for (i=0;i<n;i++)
                    suma = suma + v[i]*v[i];
            norma = sqrt(suma);
            #pragma omp for schedule(dynamic,2)
            for (i=0;i<n;i++)
             v[i] = v[i] / norma;
            #pragma omp for reduction(max:pos_max,max) private(aux) schedule(dynamic,2)
                for (i=0;i<n;i++) {
                    aux = v[i];
                    if (aux < 0)  aux = -aux;
                    if (aux > max) {
                    pos_max = i;  max = aux;
                    }
                }
           }
           return pos_max;
}
// cuestiones 3-11
double funcion(double A[N][N],double B[N][N])
         {
           int i,j;
           double aux, maxi = 0.0;
           #pragma omp parallel private(i,j)
           #pragma omp for
           for (j=0; j<N; j++) {
           for (i=1; i<N; i++) {
               A[i][j] = 2.0+A[i-1][j];
} }
           #pragma omp for
           for (i=0; i<N-1; i++) {
             for (j=0; j<N-1; j++) {
               B[i][j] = A[i+1][j]*A[i][j+1];
             }
           }
           
           #pragma omp for private(aux) reduction(max:maxi)
           for (i=0; i<N; i++) {
             for (j=0; j<N; j++) {
               aux = B[i][j]*B[i][j];
               if (aux>maxi) maxi = aux;
} }
           return maxi;
         }
// cuestion 3-12
int funcion(double A[N][N],double posiciones[][2])
         {
           int i,j,k=0;
           double maximo;
           /* Calculamos el máximo */
           maximo = A[0][0];
           #pragma omp parallel{
            int id = omp_get_thread_num();
            int cont = 0;
            #pragma omp for private(j) reduction(max:maximo){
             for (i=0;i<N;i++) {
             for (j=0;j<N;j++) {
               if (A[i][j]>maximo) maximo = A[i][j];
             }
            }
            }
            #pragma omp for private(j){
                    /* Una vez localizado el máximo, buscar sus posiciones */
              for (i=0;i<N;i++) {
                for (j=0;j<N;j++) {
                if (A[i][j] == maximo) {
                    #pragma omp critical{
                            posiciones[k][0] = i;
                            posiciones[k][1] = j;
                            k = k+1;
                    }
                    cont++;
                    }
                }
              }
            }
            printf("soy %d y he encontrado %d maximos", id, cont);
           }
            return k; 
}