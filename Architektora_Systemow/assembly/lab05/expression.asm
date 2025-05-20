         [bits 32]

;        esp -> [ret] ; ret - adres powrotu do asmloader

a        equ 4
b        equ 5
c        equ 6

;        exp = a + b*c = 4 + 5*6 = 34

         mov eax, b    ; eax = b
         mov ecx, c    ; ecx = c
         mul ecx       ; edx:eax = eax*ecx = b*c
         mov ecx, a    ; ecx = a
         add eax, ecx  ; eax = eax + ecx = b*c + a

;        mul arg       ; edx:eax = eax*arg

         push eax

;        esp -> [eax][ret]

         call getaddr
format:
         db "wynik = %u", 0xA, 0
getaddr:

;        esp -> [format][eax][ret]

         call [ebx+3*4]  ; printf("suma = %i\n", eax);
         add esp, 2*4    ; esp = esp + 8

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0);
                              