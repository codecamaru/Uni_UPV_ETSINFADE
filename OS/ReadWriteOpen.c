#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h> 
#include <stdio.h>
#include <unistd.h>
#include <errno.h>

#define BLKSIZE 1
#define NEWFILE (O_WRONLY | O_CREAT | O_EXCL)
#define MODE600 (S_IRUSR | S_IWUSR)

int main(int argc,char *argv[]){
    int fd1;
    int fd2;
    char buf[BLKSIZE];
    ssize_t readbytes;
    ssize_t wrotebytes; 

    if(argc < 3){
        printf("enter a source file and a destiny file please \n ");
        exit(1);
    }
    fd1 = open(argv[1],O_RDONLY);
    if (fd1 < 0){
        perror("File opening error\n");
        exit(1);
    }else {
        printf("Source file descriptor is %d\n",fd1);
    }
    fd2 = open(argv[2],NEWFILE,MODE600);
    if (fd2 < 0){
        perror("Could not create Destiny file\n");
        exit(1);
    }else {
        printf("Destiny file descriptor is %d\n",fd2);
    }
    while((readbytes = read(fd1, buf, sizeof(buf))) > 0){
        if (write(fd2,buf,readbytes) != readbytes){
            fprintf(stderr,"Could not write %s because %s\n", argv[2],strerror(errno));
        }
    }
    if(readbytes == -1){
        fprintf(stderr,"Could not read %s because %s", argv[2],strerror(errno));
    }
    close(fd1);
    close(fd2);
}