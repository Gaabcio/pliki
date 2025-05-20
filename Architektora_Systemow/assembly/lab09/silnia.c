#include <stdio.h>

int silnia(int n) {
	if (n == 0) 
		return 1;
	else 
		return n*silnia(n-1);
}
/*
- dokonaj analizy wywolania silnia(3)

* silnia1(3) = 6
  n = 3
  return 3*silnia2(2) = 3*2 = 6
  
* silnia2(2) = 2
  n = 2
  return 2*silnia3(1) = 2*1 = 2
  
* silnia3(1) = 1
  n = 1
  return 1*silnia4(0) = 1*1 = 1
  
* silnia4(0) = 1
  n = 0
  return 1  
  
- narysuj graf wywolan dla silnia(3)

silnia1(3) -> silnia2(2) -> silnia3(1) -> silnia4(0)
*/


int silniap(int n) {
	if (n == 0) return 1;
	if (n == 1) return 1;
	
	return n*silniap(n-2);
}
/*
- dokonaj analizy wywolania silniap(3)

* silnia1(3) = 6
  n = 3
  return 3*silnia2(2) = 3*2 = 6
  
* silnia2(2) = 2
  n = 2
  return 2*silnia3(1) = 2*1 = 2
  
* silnia3(1) = 1
  n = 1
  return 1*silnia4(0) = 1*1 = 1
  
* silnia4(0) = 1
  n = 0
  return 1  
  
- narysuj graf wywolan dla silnia(3)

silnia1(3) -> silnia2(2) -> silnia3(1) -> silnia4(0)
*/

int main() {
	printf("silnia.c\n\n");
	
    int n = 3;

	printf("%u! = %u\n", n, silnia(n));
	printf("%u!! = %u\n", n, silniap(n));

    return 0;
}

