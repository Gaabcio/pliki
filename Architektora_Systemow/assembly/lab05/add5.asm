         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

%define  UINT_MAX 4294967295

%define  INT_MIN -2147483648
%define  INT_MAX  2147483647

a        equ -2147483648
b        equ -1

;        edi:esi
;        edx:eax +
;        -------
;        edx:eax

;        edi:esi = a
;        edx:eax = b

         mov eax, a  ; eax = a

         cdq  ; edx:eax = eax  ; signed conversion

         mov esi, eax  ; esi = eax
         mov edi, edx  ; edi = edx

         mov eax, b  ; eax = b

         cdq  ; edx:eax = eax  ; signed conversion

         add eax, esi  ; eax = eax + esi
         adc edx, edi  ; edx = edx + edi

         push edx  ; edx -> stack
         push eax  ; eax -> stack

;        esp -> [eax][edx][ret]

         call getaddr
format:
         db "suma = %lld", 0xA, 0
getaddr:

;        esp -> [format][eax][edx][ret]

         call [ebx+3*4]  ; printf(format, edx:eax);
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