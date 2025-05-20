         [bits 32]

;        esp -> [ret] ; ret - adres powrotu do asmloader

liczba   equ -5

         mov eax, liczba  ; eax = liczba
         mov edx, eax     ; edx = eax

         test eax, 0    ; eax - 0            ; SF affected
         jnz dodatnia  ; jump if not signed ; jump if SF = 0
         neg edx       ; edx = -edx

dodatnia:

         push edx
         push eax

;        esp -> [eax][edx][ret]

         call getaddr
format:
         db "liczba = %i", 0xA
         db "modul = %i", 0xA, 0
getaddr:

;        esp -> [format][eax][edx][ret]

         call [ebx+3*4]  ; printf("liczba = %i\nmodul = %i\n", eax, edx);
         add esp, 3*4    ; esp = esp + 12

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