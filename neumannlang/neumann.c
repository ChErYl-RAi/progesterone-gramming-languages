/*
                                               _                   
  _ __   ___ _   _ _ __ ___   __ _ _ __  _ __ | | __ _ _ __   __ _ 
 | '_ \ / _ \ | | | '_ ` _ \ / _` | '_ \| '_ \| |/ _` | '_ \ / _` |
 | | | |  __/ |_| | | | | | | (_| | | | | | | | | (_| | | | | (_| |
 |_| |_|\___|\__,_|_| |_| |_|\__,_|_| |_|_| |_|_|\__,_|_| |_|\__, |
                                                             |___/ 

instruction list so your DID ass doesnt forget

0: end program
1: set address
2: add to second memory
3: substract to second memory
4: set second memory 
5: set ram[i] to second memory
6: 
7:
8:
9:
A: output
B:
C:
D:
E:
F: mode 1-3 (no load scr, normal, print every time)

*/


#include <stdio.h>



FILE *ptr;
char ram[16] = {0};
int secmem = 0;
int address = 0;

int printarray(char arr[]){
    for (size_t i = 0; i < 16; i++)
    {
        if ((arr[i]/16)<10){
            printf("%s:",(arr[i]/16)+48);
        }else{
            printf("%c:",(arr[i]/16)+55);
        }
        
        if ((arr[i]%16)<10){
            printf("%c, ",(arr[i]%16)+48);
        }else{
            printf("%c, ",(arr[i]%16)+55);
        }
    }
    return 0;
}



int main(int argc, char *argv[])
{

    ptr = fopen("test.nm","rb");
    fread(ram,16,1,ptr);
    
    // this was for testing awawa
    //for (size_t i = 0; i < 16; i++)
    //{
    //    ram[i] = 16*i+i;
    //}
    
    if (argc > 1)
    {
        printf("file loaded: %s\n", argv[1]);
        printf("~\n");
        printarray(ram);
        printf("\n");
        
    }
    else
    {
        printf("Please supply an input file\n");
    }

    return 0;
}
