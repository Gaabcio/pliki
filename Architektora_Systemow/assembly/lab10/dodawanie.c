#include <stdio.h>
#include <math.h>

/*
Plan aplikacji:

- pobranie wartosci a i b
- okreslenie wiekszej i mniejszej wartosci z a i b
- wyznaczenie tablicy przeniesien
- wypisanie przeniesien
- wypisanie wiekszej liczby
- wypisanie znaku plus i mniejszej liczby
- wypisanie podkreslenia
- wypisanie wyniku dodawania
*/

int main() {
    int a, b;

    printf("a = "); scanf("%d", &a);
    printf("b = "); scanf("%d", &b);

    int max_a_b = a > b ? a : b;
    int min_a_b = a < b ? a : b;

    int width_max_a_b = max_a_b > 0 ? log10(max_a_b) + 1 : 1;

    int carry[width_max_a_b];

    /*
    a = 9237
    b = 1267

    Sposób 1

    7 + 7     = 14   c = 1
    3 + 6 + 1 = 10   c = 1
    2 + 2 + 1 = 5    c = 0
    9 + 1 + 0 = 10   c = 1

    Sposób 2

    7 + 7       = 14      c = 1
    37 + 67     = 104     c = 1
    237 + 267   = 504     c = 0
    9237 + 1267 = 10504   c = 1
    */

    int d = 10;

    int i;
    for (i = width_max_a_b - 1; i >= 0; i--) {
        int digits_a = a % d;
        int digits_b = b % d;

        carry[i] = digits_a + digits_b >= d ? 1 : 0;

        d = d*10;
    }

    printf("\n ");

    for (i = 0; i < width_max_a_b; i++) printf(carry[i] == 1 ? "1" : " ");

    printf("\n  %d\n", max_a_b);

    printf("+ %*d\n", width_max_a_b, min_a_b);

    for (i = 1; i <= width_max_a_b + 2; i++) printf("-");

    printf("\n%*d\n\n", width_max_a_b + 2, a + b);

    return 0;
}

