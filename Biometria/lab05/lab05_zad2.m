%% Filtracja obrazu tęczówki przy użyciu 2D FFT
% ============================================
close all; clear all; clc;  % Inicjalizacja - czyszczenie obszaru roboczego

% Wczytanie obrazu tęczówki
I = imread('teczowka_2.png');  % Wczytanie obrazu tęczówki
if size(I,3) == 3
    I = rgb2gray(I);  % Konwersja do skali szarości jeśli obraz jest kolorowy
end
I = im2double(I);  % Konwersja do formatu zmiennoprzecinkowego

% Wyświetlenie oryginalnego obrazu
figure;
subplot(2,3,1);
imshow(I, []);
title('Oryginalny Obraz Tęczówki');

% Obliczenie dwuwymiarowej FFT i przesunięcie widma częstotliwości
F = fft2(I);
F_shifted = fftshift(F);
magF = log(1 + abs(F_shifted));  % Logarytmiczne skalowanie dla lepszej wizualizacji

% Wyświetlenie widma częstotliwości
subplot(2,3,2);
imshow(magF, []);
title('Widmo Częstotliwości (skala log)');

% Projektowanie filtrów
[rows, cols] = size(I);
[u, v] = meshgrid(-floor(cols/2):floor((cols-1)/2), -floor(rows/2):floor((rows-1)/2));
D = sqrt(u.^2 + v.^2);  % Obliczenie odległości od środka

% 1. Filtr dolnoprzepustowy (LPF) - przepuszcza niskie częstotliwości
D_low = 30;  % Częstotliwość odcięcia dla filtru dolnoprzepustowego
H_lpf = double(D <= D_low);

% 2. Filtr górnoprzepustowy (HPF) - przepuszcza wysokie częstotliwości
D_high = 10;  % Częstotliwość odcięcia dla filtru górnoprzepustowego
H_hpf = double(D >= D_high);

% 3. Filtr środkowoprzepustowy (BPF) - przepuszcza tylko wybrany zakres częstotliwości
D_band_low = 10;    % Dolna granica przepustowości
D_band_high = 40;   % Górna granica przepustowości
H_bpf = double(D >= D_band_low & D <= D_band_high);

% Wyświetlenie filtrów
subplot(2,3,4);
imshow(H_lpf, []);
title('Filtr Dolnoprzepustowy');

subplot(2,3,5);
imshow(H_hpf, []);
title('Filtr Górnoprzepustowy');

subplot(2,3,6);
imshow(H_bpf, []);
title('Filtr Środkowoprzepustowy');

% Zastosowanie filtrów i rekonstrukcja obrazów
% 1. Zastosowanie filtru dolnoprzepustowego
F_lpf = F_shifted .* H_lpf;
I_lpf = real(ifft2(ifftshift(F_lpf)));
I_lpf = mat2gray(I_lpf);

% 2. Zastosowanie filtru górnoprzepustowego
F_hpf = F_shifted .* H_hpf;
I_hpf = real(ifft2(ifftshift(F_hpf)));
I_hpf = mat2gray(I_hpf);

% 3. Zastosowanie filtru środkowoprzepustowego
F_bpf = F_shifted .* H_bpf;
I_bpf = real(ifft2(ifftshift(F_bpf)));
I_bpf = mat2gray(I_bpf);

% Wyświetlenie wyników filtracji
figure;
subplot(2,2,1);
imshow(I, []);
title('Oryginalny Obraz');

subplot(2,2,2);
imshow(I_lpf, []);
title('Filtracja Dolnoprzepustowa');

subplot(2,2,3);
imshow(I_hpf, []);
title('Filtracja Górnoprzepustowa');

subplot(2,2,4);
imshow(I_bpf, []);
title('Filtracja Środkowoprzepustowa');

% Analiza morfologii tęczówki w przestrzeni 3D
figure;
subplot(1,3,1);
mesh(I);
title('Morfologia Oryginalnej Tęczówki');
xlabel('X');
ylabel('Y');
zlabel('Intensywność');

subplot(1,3,2);
mesh(I_lpf);
title('Morfologia po Filtracji Dolnoprzepustowej');
xlabel('X');
ylabel('Y');
zlabel('Intensywność');

subplot(1,3,3);
mesh(I_bpf);
title('Morfologia po Filtracji Środkowoprzepustowej');
xlabel('X');
ylabel('Y');
zlabel('Intensywność');

% Dodatkowa analiza - porównanie przekrojów
figure;
centerRow = round(rows/2);
plot(1:cols, I(centerRow,:), 'b', 1:cols, I_lpf(centerRow,:), 'g', 1:cols, I_bpf(centerRow,:), 'r');
title('Porównanie Przekrojów Poziomych');
xlabel('Piksel w poziomie');
ylabel('Intensywność');
legend('Oryginalny', 'Filtr Dolnoprzepustowy', 'Filtr Środkowoprzepustowy');
grid on;