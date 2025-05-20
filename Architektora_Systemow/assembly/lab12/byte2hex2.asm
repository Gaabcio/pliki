         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

bajt     equ 10  ; bajt = 0..255

         call getaddr

table    db "0123456789ABCDEF"
format   db "byte2hex = "
hex      db 0, 0, 0xA, 0

getaddr:

;        esp -> [table][ret]

         mov ebp, ebx    ; ebp = ebx

         mov ebx, [esp]  ; ebx = *(int*)esp = table

         lea edi, [ebx + hex - table + 1]  ; edi = ebx + hex - table + 1 = hex + 1

         mov al, bajt    ; al = bajt

         mov dl, al      ; dl = al

         and al, 1111b   ; al = al & 1111b

         xlat            ; al = *(char*)(ebx + al) ; table lookup translation

         mov [edi], al   ; *(char*)edi = al

         dec edi         ; edi--

         mov al, dl      ; al = dl

         shr al, 4       ; al = al >> 4

         and al, 1111b   ; al = al & 1111b

         xlat            ; al = *(char*)(ebx + al) ; table lookup translation

         mov [edi], al   ; *(char*)edi = al

         add dword [esp], format - table  ; *(int*)esp = *(int*)esp + format - table = format

;        esp -> [format][ret]

         call [ebp+3*4]  ; printf(format, eax);
         add esp, 3*4    ; esp = esp + 12

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebp+0*4]  ; exit(0);

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