[bits 32]

n       equ 3

         ; Umieszczamy pocz�tkow� warto�� licznika bezpo�rednio na stosie
         push dword n

petla:
         ; Pobieramy bie��c� warto�� licznika ze stosu (bez zdejmowania)
         mov eax, [esp]
         ; Przekazujemy warto�� licznika jako argument dla printf
         push eax
         call getaddr
format:
         db "i = %i", 0xA, 0
getaddr:
         ; Wywo�ujemy funkcj� printf z API (indeks 3 w tablicy funkcji przekazanej przez asmloader)
         call [ebx+3*4]
         ; Usuwamy argument printf, pozostawiaj�c oryginaln� warto�� licznika na stosie
         adc esp, 4

         ; Dekrementujemy licznik bezpo�rednio na stosie
         dec dword [esp]
         cmp dword [esp], 0
         jnz petla

         ; Usuwamy licznik (ju� r�wny 0) ze stosu
         add esp, 4
         ; Zako�czenie programu przy u�yciu exit(0)
         push 0
         call [ebx+0*4]