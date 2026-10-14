/*
                                               _                   
  _ __   ___ _   _ _ __ ___   __ _ _ __  _ __ | | __ _ _ __   __ _ 
 | '_ \ / _ \ | | | '_ ` _ \ / _` | '_ \| '_ \| |/ _` | '_ \ / _` |
 | | | |  __/ |_| | | | | | | (_| | | | | | | | | (_| | | | | (_| |
 |_| |_|\___|\__,_|_| |_| |_|\__,_|_| |_|_| |_|_|\__,_|_| |_|\__, |
                                                             |___/ 
neumannlang: a shitty programming language based on von neumann architecture if it was worse

instruction list so your DID ass doesnt forget

0: end program (param of >0 means file is overwritten)
1: set address
2: add to second memory
3: substract to second memory
4: set second memory 
5: set ram[address] to second memory
6: set second memory to ram[param]
7: swap ram[address] and second memory
8: jump to address in second memory
9: jump param[address] steps if second memory is 0
A: print ram[param]
B: print second memory
C: stall param[address] eighths of a second
D: secmem = gates between secmem and ram[address]. see below
E: 
F: mode 0-2 (no load scr, normal, print every time)

the address advances when an instruction is finished, except when the instruction affects the ram.

(given sm 10010110 ri 01011010)
D0 = and            00010010
D1 = or             11011110
D2 = nand           11101101
D3 = nor            00100001
D4 = xor            11001100
D5 = xnor           00110011
D6 = not secmem     01101001
D7 = not ram[i]     10100101

this fucking sucks lmao. have fun or something

*/


#include <stdio.h>
#include <stdbool.h>
#include <time.h>
#include <stdint.h>



FILE *ptr;
unsigned char ram[16] = {0};
int secmem = 0;
int address = 0;
bool ldscr = true;
bool peverytime = true;


static char wawa[6] = {'A','B','C','D','E','F'};

void printarray(unsigned char arr[]){
    for (size_t i = 0; i < 16; i++)
    {
        if ((arr[i]/16)<10){
            printf("%d:",(arr[i]/16));
        }else{
            printf("%c:",wawa[(arr[i]/16-10)]);
        }
        
        if ((arr[i]%16)<10){
            printf("%d, ",(arr[i]%16));
        }else{
            printf("%c, ",wawa[(arr[i]%16-10)]);
        }
    }
    printf("\n");
    printf("address:%d \n", address);
    printf("secmem:%d \n", secmem);
    printf("\n");
}



int main(int argc, char *argv[])
{

    
    
    // this was for testing awawa
    //for (size_t i = 0; i < 16; i++)
    //{
    //    ram[i] = 16*i+i;
    //}
    
    if (argc > 1)
    {
        ptr = fopen(argv[1],"rb");
        if (!ptr){
        printf("No such file\n");
            return 1;
        }
        
        fread(ram,16,1,ptr);
        if ( ram[0] / 16 == 15){ // (no load scr, normal, print every time)
            if ( ram[0] % 16 ==0 ) {
                ldscr = false;
                peverytime = false;
            } else if ( ram[0] % 16 ==1 ) {
                ldscr = true;
                peverytime = false;
            } else {
                ldscr = true;
                peverytime = true;
            }
        }
        if (ldscr){
            printf("file loaded: %s\n", argv[1]);
            printf("~\n");
            printarray(ram);
            printf("\n");
        }

        while (ram[address]/16 != 0)
        {
            address = address%16;
            switch (ram[address]/16)
            {
            case 1:
                /* code */
                address = ram[address]%16;
                break;
            case 2:
                secmem += ram[address]%16;
                secmem = secmem%256;
                address++;
                break;
            case 3:
                secmem -= ram[address]%16;
                if (secmem<0){
                    secmem+=256;
                }
                secmem = secmem%256;
                address++;
                break;
            case 4:
                secmem = ram[address];
                secmem = secmem%256;
                address++;
                break;
            case 5:
                ram[address]=secmem;
                break;
            case 6:
                secmem = ram[ram[address]%16];
                secmem = secmem%256;
                address++;
                break;
            case 7: 
                int tempSM = secmem;
                secmem = ram[address];
                secmem = secmem%256;
                ram[address]=tempSM;
                break;
            case 8:
                address=secmem;
                address = address%16;
                break;
            case 9:
                if (secmem == 0) {
                    address+=ram[address]%16;
                }else{
                    address++;
                }
                break;
            case 10:
                printf("%c",ram[ram[address]%16]);
                address++;
                break;
            case 11:
                printf("%c",secmem);
                address++;
                break;
            case 12:
                nanosleep(&(struct timespec){ .tv_sec = 0, .tv_nsec = 125000000L * (ram[address] % 16) }, NULL);
                address++;
                break;
            case 13: {
                uint8_t a = secmem;
                uint8_t b = ram[address];
                switch (ram[address] % 16) {
                    case 0: secmem = a & b;             break;
                    case 1: secmem = a | b;             break;
                    case 2: secmem = (uint8_t)~(a & b); break;
                    case 3: secmem = (uint8_t)~(a | b); break;
                    case 4: secmem = a ^ b;             break;
                    case 5: secmem = (uint8_t)~(a ^ b); break;
                    case 6: secmem = (uint8_t)~a;       break;
                    case 7: secmem = (uint8_t)~b;       break;
                }
                address++;
                break;
            }
            default:
                address++;
                break;
            }

            if (peverytime){
                printarray(ram);
                printf("instruction: %d, params: %d.\n\n", ram[address]/16, ram[address]%16);
            }
        }
        
        
    }
    else
    {
        printf("Please supply an input file\n");
        return 1;
    }

    fclose(ptr);
    return 0;
}
