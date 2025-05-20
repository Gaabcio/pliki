[bits 32]

n       equ 3

         ; Umieszczamy pocz¹tkow¹ wartoœæ licznika bezpoœrednio na stosie
         push dword n

petla:
         ; Pobieramy bie¿¹c¹ wartoœæ licznika ze stosu (bez zdejmowania)
         mov eax, [esp]
         ; Przekazujemy wartoœæ licznika jako argument dla printf
         push eax
         call getaddr
format:
         db "i = %i", 0xA, 0
getaddr:
         ; Wywo³ujemy funkcjê printf z API (indeks 3 w tablicy funkcji przekazanej przez asmloader)
         call [ebx+3*4]
         ; Usuwamy argument printf, pozostawiaj¹c oryginaln¹ wartoœæ licznika na stosie
         adc esp, 4

         ; Dekrementujemy licznik bezpoœrednio na stosie
         dec dword [esp]
         cmp dword [esp], 0
         jnz petla

         ; Usuwamy licznik (ju¿ równy 0) ze stosu
         add esp, 4
         ; Zakoñczenie programu przy u¿yciu exit(0)
         push 0
         call [ebx+0*4]