#include <stdio.h>

char hexDigit(char x) {
    if (0 <= x && x <= 9) return '0' + x;
    
    if (10 <= x && x <= 15) return 'A' + x - 10;
}

char hexDigit2(char x) {
    char digits[] = "0123456789ABCDEF";
    
    return digits[x];
}

void byte2hex(unsigned char byte) {
    char hex[2];
    
    char maska = 1 + 2 + 4 + 8; // 00001111
    
    hex[1] = hexDigit(byte & maska);
    
    byte = byte >> 4;
    
    hex[0] = hexDigit(maska);
    
    printf("%c%c", hex[0], hex[1]);
}

/*
244 / 16 = 15   r0 = 4
15 / 16  = 0    r1 = F
*/

void byte2hex2(unsigned char byte) {
    char hex[2];
    
    hex[1] = hexDigit(byte % 16);
    
    byte = byte / 16;
    
    hex[0] = hexDigit(byte % 16);
    
    printf("%c%c", hex[0], hex[1]);
}

void dec2hex(unsigned int dec) {
    char hex[8+1] = "";
    
    int i;
    for (i = 7; i >= 0; i--) {
        hex[i] = hexDigit(dec % 16);
        
        dec = dec / 16;
    }
        
    printf("%s", hex);
}

void dec2hex2(unsigned int dec) {
    char hex[8+1] = "";
    
    char maska = 1 + 2 + 4 + 8; // 00001111
    
    int i;
    for (i = 7; i >= 0; i--) {
        hex[i] = hexDigit(dec & maska);
        
        dec = dec >> 4;
    }
    
    printf("%s", hex);
}

int main() {    
    printf("konwersje2.c\n\n");
    
    char n = 12; // n = 0..15
    
    printf("hexDigit(%u)  = %c\n", n, hexDigit(n));
    
    printf("hexDigit2(%u) = %c\n", n, hexDigit2(n));
    
    printf("\n");
    
    unsigned char byte = 244;
    
    printf("byte2hex(%u)  = ", byte); byte2hex(byte); printf("\n");
    printf("byte2hex2(%u) = ", byte); byte2hex2(byte); printf("\n");
    
    printf("\n");   
    
    unsigned int dec = 4484545; // 4294967295u;
    
    printf("dec2hex(%u)  = ", dec); dec2hex(dec); printf("\n");
    printf("dec2hex2(%u) = ", dec); dec2hex2(dec); printf("\n");

    printf("\n");

    return 0;
}

