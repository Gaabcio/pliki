         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         call getaddr
format:
         db "a = ", 0
getaddr:

;        esp -> [format][ret]

         call [ebx+3*4]  ; printf("a = ");

;        esp -> [a][ret]  ; zmienna a, adres format1 nie jest juz potrzebny

         push esp  ; odkladamy na stos adres zmiennej a ; *(int*)(esp-4) = esp ; esp = esp - 4

;        esp -> [addr_a][a][ret]

         call getaddr2
format2:
         db "%i", 0
getaddr2:

;        esp -> [format2][addr_a][a][ret]

         call [ebx+4*4]  ; scanf("%i", &a);
         add esp, 2*4    ; esp = esp + 8

;        esp -> [a][ret]

         call getaddr3
format3:
         db "a = %i", 0xA, 0
getaddr3:

;        esp -> [format3][a][ret]

         call [ebx+3*4]  ; printf("a = %i\n", a);
         add esp, 2*4    ; esp = esp + 8

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0);

; asmloader API
;
; ESP wskazuje na prawidlowy stos
; argumenty funkcji wrzucamy na stos
; EBX zawiera pointer na tablice API
;
; call [ebx + NR_FUNKCJI*4] ; wywolanie funkcji API
;
; NR_FUNKCJI:
;
; 0 - exit
; 1 - putchar
; 2 - getchar
; 3 - printf
; 4 - scanf
;
; To co funkcja zwróci jest w EAX.
; Po wywolaniu funkcji sciagamy argumenty ze stosu.
;
; https://gynvael.coldwind.pl/?id=387