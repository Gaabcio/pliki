%% Fourier Series Decomposition
% ============================================
close all; clear all; clc;  % Inicjalizacja – zamknięcie okien, czyszczenie pamięci

% Parametry bazowe
roz = 5;                   % Liczba harmonicznych
a = -180:1:180;            % Zakres kątów w stopniach
t = a * pi / 180;          % Konwersja do radianów
Tmax = t(end) - t(1);      % Długość okresu
krok = t(2) - t(1);        % Wielkość kroku

% Generowanie funkcji wejściowej – tworzenie sygnału do analizy
% Można wybrać jedną z poniższych funkcji testowych:
y = sin(t) + 0.1*sin(20*t);              % Sygnał złożony z sinusów
% y = (t > 0)*2 - 1;                     % Funkcja skok jednostkowy
% y = t;                                 % Funkcja liniowa
% y = sin(t)+0.2*cos(5*t)+0.1*sin(10*t); % Złożony sygnał harmoniczny

% Wyświetlenie oryginalnego sygnału
figure;
plot(t, y, 'g', 'LineWidth', 1.5);
title('Sygnał Oryginalny');
xlabel('t [rad]');
ylabel('Amplituda');
grid on;

%% Rozkład na harmoniczne – obliczanie współczynników Fouriera
% ============================================
Ao = (1/Tmax) * sum(y .* krok);  % Składowa stała (DC)
A = zeros(roz, 1);               % Inicjalizacja tablicy współczynników cosinusowych
B = zeros(roz, 1);               % Inicjalizacja tablicy współczynników sinusowych

% Obliczanie współczynników dla każdej harmonicznej
for j = 1:roz
    ac = 0; bs = 0;
    for i = 1:length(t)
        ac = ac + krok * (2/Tmax) * y(i) * cos(j * 2*pi/Tmax * t(i));
        bs = bs + krok * (2/Tmax) * y(i) * sin(j * 2*pi/Tmax * t(i));
    end
    A(j) = ac;  % Współczynnik cosinusowy dla j-tej harmonicznej
    B(j) = bs;  % Współczynnik sinusowy dla j-tej harmonicznej
end

%% Sumowanie składowych – rekonstrukcja funkcji
% ============================================
Skc = zeros(roz, length(t));  % Inicjalizacja tablicy dla składowych cosinusowych
Sks = zeros(roz, length(t));  % Inicjalizacja tablicy dla składowych sinusowych

% Obliczanie składowych harmonicznych
for i = 1:roz
    Skc(i,:) = A(i) * cos(i * 2*pi/Tmax * t);  % Składowa cosinusowa
    Sks(i,:) = B(i) * sin(i * 2*pi/Tmax * t);  % Składowa sinusowa
end

% Inicjalizacja zrekonstruowanego sygnału ze składową stałą
W = zeros(1, length(t)) + Ao / 2;

%% Wizualizacja wyników - Sumowanie i prezentacja graficzna
figure;
hold on;
for i = 1:roz
    W = W + Skc(i,:) + Sks(i,:);  % Dodawanie kolejnych harmonicznych
    plot(t, Sks(i,:), 'b', t, Skc(i,:), 'g', t, W, 'r');
end
title('Składowe Harmoniczne i Rekonstrukcja Sygnału');
xlabel('t [rad]');
ylabel('Amplituda');
grid on;
legend('Składowa sinusowa', 'Składowa cosinusowa', 'Sygnał zrekonstruowany');
hold off;

% Wykres końcowego zrekonstruowanego sygnału
figure;
plot(t, y, 'g', 'LineWidth', 1.5);
hold on;
plot(t, W, 'r--', 'LineWidth', 1.5);
title('Porównanie: Sygnał Oryginalny vs. Zrekonstruowany');
xlabel('t [rad]');
ylabel('Amplituda');
legend('Oryginalny', 'Zrekonstruowany');
grid on;
hold off;

% Wyświetlenie współczynników
figure;
subplot(2,1,1);
% Wykres współczynników cosinusowych
stem(1:roz, A, 'g', 'filled');
title('Współczynniki Cosinusowe A_n');
xlabel('Harmoniczna n');
ylabel('Amplituda');
grid on;

subplot(2,1,2);
% Wykres współczynników sinusowych
stem(1:roz, B, 'r', 'filled');
title('Współczynniki Sinusowe B_n');
xlabel('Harmoniczna n');
ylabel('Amplituda');
grid on;


%% Optional: Magnitude Spectrum
figure;
% stem(1:roz, sqrt(A.^2 + B.^2), 'k', 'filled');
plot(1:roz, sqrt(A.^2 + B.^2), 'r')
title('Widmo aplitudowe |C_n|');
xlabel('Harmonic n');