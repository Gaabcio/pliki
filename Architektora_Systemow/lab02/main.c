#include <stdio.h>
#include <stdlib.h>

void dec2bin(int x){
	int tab[16];
	int i = 0;
		while(x > 0){
		tab[i] = x % 2;
		x = x/2;
		i++;
	}

	for (int j = i; j >= 0; j--) {
		printf("%d", tab[j]);
	}
	

}

int main(void) {

//    void *x = malloc(sizeof(int));
//    void *y = malloc(sizeof(int));
//
//	int *wsk = (int *)x;
//
//    *((int *)y) = 1;
//    *((int *)x) = 2;
//
//    printf("Adres bloku pamieci x: %p\n",x);
//    printf("Adres bloku pamieci y: %p\n",y);
//    printf("Rozmiar bloku x = %d\n", (y-x));
//
//	printf("wartosc x = %d\n", *((int *)x));
//	printf("wartosc y = %d\n", *((int *)y));

	dec2bin(65);

    return 0;
}

