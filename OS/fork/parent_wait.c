#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]){
    int i;
    pid_t val;
    long pid;
    for(i=0;i<5;i++){
        wait();
        val = fork();
        pid = (long)getpid();
        if(val==0){
        printf("Hijo creado en iteración=%d con PID=%ld\n",i,pid);
        exit(i);
        }
    }
    sleep(10);
    exit(0);
    return 0;
}
