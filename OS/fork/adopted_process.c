#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]){
    int i;
    pid_t val;
    for(i=0;i<5;i++){
        val = fork();
        if(val==0){
        printf("Hijo creado en iteración=%d\n",i);
        sleep(20);
        exit(i);
        }
    }
    sleep(10);
    exit(0);
    return 0;
}
