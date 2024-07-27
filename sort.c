#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>

extern uint32_t ascSort(uint32_t sort[], uint32_t arrCount);
void failure(const char* failure);
uint32_t stringToNum(const char* str);
void printArr(uint32_t* arr, uint32_t count);

int main(int argC, char* args[])
{
    if(argC != 3)
    {
        failure("Too few or too many Args.");
    }
    uint32_t arrayCount = stringToNum(args[1]);
    uint32_t maxNum = stringToNum(args[2]);
    srand(time(0));
    uint32_t* randArray = (uint32_t*)malloc(4 * arrayCount);
    for(int i = 0; i < arrayCount; i++)
    {
        randArray[i] = rand() % maxNum;
    }
    printArr(randArray, arrayCount);
    ascSort(randArray, arrayCount);
    printArr(randArray, arrayCount);
    return EXIT_SUCCESS;
}

void failure(const char* failure)
{
    printf("Error Occured: %s\n", failure);
    exit(-1);
}

uint32_t stringToNum(const char str[])
{
    uint32_t num = 0;
    while(*(str) != 0)
    {
       
        uint32_t buf = *(str++) - 48;
        if(buf < 0 || buf > 9)
        {
            printf("%d\n", buf);
            failure("Arg 2 and 3 can only contain ints."); 
        }
        num *= 10;
        num += buf;
    }
    return num;
}

void printArr(uint32_t* arr, uint32_t count)
{
    printf("[");
    for(int i = 0; i < count - 1; i++)
    {
        printf("%d, ", arr[i]);
        if(((i + 1) % 4) == 0)
        {
            printf("\n");
        }
    }
    printf("%d]\n", arr[count - 1]);
}
