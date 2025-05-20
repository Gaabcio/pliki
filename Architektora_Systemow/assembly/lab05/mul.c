#include <stdio.h>

int main() {
    int a = -4;  
    int b = 2;           
    int result;    

    result = (long long) a * b;

    printf("a = %i\n", a);
    printf("b = %i\n", b);
    printf("iloczyn = %d\n", result);

    return 0;
}