#include <stdio.h>

int main(int argc, char *argv[]) {   
     // A completar 
    int i;
    printf("Numero de argumentos = %d\n", argc);
    int j;
    for(j=1;j<argc;j++){
        switch(argv[j][1]){
            case 'c':
                printf("Argumento %d es Compilar \n",j);
                break;
            case 'E':
                printf("Argumento %d es Preprocesar \n",j);
                break;
            case 'i':
                printf("Argumento %d es Incluir %s\n",j,&argv[j][2]);
                break;
            default: 
                printf ("Opción incorrecta\n");
        }
        
        
    }
}
