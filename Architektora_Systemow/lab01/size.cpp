#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]){
		
	int a = 260;
	char *p = &a;
	
	printf("Adres1: %p\n",p);
	p++;
	printf("Adres2: %p\n",p);
	
	//printf("Wartosc: %d\n", *p);

	return 0;
}