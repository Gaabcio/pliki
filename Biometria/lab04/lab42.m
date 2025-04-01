% Krok 1: Wczytanie obrazu i konwersja do skali szarości
clear all; close all; clc;
oko = imread('oko2.jpg'); % Wczytanie obrazu oka
if size(oko, 3) == 3
    oko = rgb2gray(oko); % Konwersja do skali szarości, jeśli obraz jest kolorowy
end
figure; imshow(oko); title('Oryginalny obraz oka');

% Krok 2: Wykrywanie krawędzi przy użyciu operatora Canny'ego
edges = edge(oko, 'Canny', [0.01 0.1]); % Dostosowanie progów [min max]
figure; imshow(edges); title('Krawędzie wykryte operatorem Canny''ego');

% Krok 3: Wykrywanie okręgów metodą Hougha
% Parametry detekcji tęczówki (twardówka - tęczówka)
Rmin_iris = 70; % Minimalny promień (piksele)
Rmax_iris = 150; % Maksymalny promień (piksele)
[srodki_iris, promienie_iris] = imfindcircles(oko, [Rmin_iris Rmax_iris], ...
    'ObjectPolarity', 'bright', 'Sensitivity', 0.95);

% Parametry detekcji źrenicy (źrenica - tęczówka)
Rmin_pupil = 20; % Minimalny promień (piksele)
Rmax_pupil = 50; % Maksymalny promień (piksele)
[srodki_pupil, promienie_pupil] = imfindcircles(oko, [Rmin_pupil Rmax_pupil], ...
    'ObjectPolarity', 'dark', 'Sensitivity', 0.85);

% Wizualizacja wykrytych okręgów
figure; imshow(oko); title('Wykryte okręgi');
viscircles(srodki_iris, promienie_iris, 'Color', 'b'); % Tęczówka
viscircles(srodki_pupil, promienie_pupil, 'LineStyle', '--', 'Color', 'r'); % Źrenica

% Krok 4: Transformacja tęczówki do współrzędnych biegunowych
% Parametry transformacji
promien_rozdz = 90; % Promień podziału
kat_zakres = 360; % Zakres kątowy (pełne koło)
if ~isempty(srodki_iris) && ~isempty(srodki_pupil)
    [polar_tab, szum_tab] = polar_transform(oko, ...
        srodki_pupil(1, 1), srodki_pupil(1, 2), promienie_pupil(1), ...
        srodki_iris(1, 1), srodki_iris(1, 2), promienie_iris(1), ...
        promien_rozdz, kat_zakres);

    % Wizualizacja transformacji biegunowej
    figure; imagesc(polar_tab); colormap(gray); title('Irys w układzie biegunowym');
else
    disp('Nie wykryto okręgów. Spróbuj dostosować parametry.');
end

% Krok 5: Wizualizacja wyników
disp('Algorytm zakończył działanie.');
