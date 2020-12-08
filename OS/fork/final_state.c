#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]){
    int final_state;
    int i;
    pid_t val;
    for(i=0;i<4;i++){
        wait();
        val = fork();
        if(val==0){
        printf("Hijo creado en iteración=%d con PID=%ld\n",i,(long)getpid());
        }else{
            printf("Padre %ld, iteracion %d\n",(long)getpid(),i);
            printf("He creado un hijo %ld\n",(long)val);
            break;
        }
        }
    while(wait(&final_state)>0){
        printf("Padre %ld iteracion %d\n",(long)getpid(),i);
        printf("Mi hijo dijo %d\n",WEXITSTATUS(final_state));
        printf("Mi hijo dijo %d\n",final_state/256);
    }
    sleep(10);
    exit(i);
    return 0;
}
