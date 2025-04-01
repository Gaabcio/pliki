% Program demonstracyjny wykorzystujący wersję kołowej transformaty Hougha
% w zadaniu wyodrębniania pola tęczówki
%=======================================================================
clear all, close all, clc
oko = imread('oko2.jpg'); % lub 'oko1.jpg'
oko = mat2gray(oko);
imshow(oko);

% Parametry wykrywania tęczówki (twardówka - tęczówka)
Rmin = 70; % Minimalny promień w pikselach
Rmax = 150; % Maksymalny promień w pikselach
[srodki_j, promienie_j] = imfindcircles(oko, [Rmin Rmax], 'ObjectPolarity', 'dark', ...
    'Sensitivity', 0.9); % Wysoka czułość na jasne obiekty

% Parametry wykrywania źrenicy (źrenica - tęczówka)
Rmin = 20; % Minimalny promień w pikselach
Rmax = 50; % Maksymalny promień w pikselach
[srodki_c, promienie_c] = imfindcircles(im2bw(oko, 0.12), [Rmin Rmax], 'ObjectPolarity', ...
    'dark', 'Method', 'TwoStage', 'Sensitivity', 0.85); % Metoda dwustopniowa

% Wizualizacja wykrytych okręgów
viscircles(srodki_j, promienie_j, 'Color', 'b'); % Tęczówka
viscircles(srodki_c, promienie_c, 'LineStyle', '--'); % Źrenica
hold on
title('Wykrywanie okręgów w obrazie');
hold off

% Parametry normalizacji
promien_rozdz = 90; % Promień rozwinięcia
kat_zakres = 360; % Zakres kątowy (pełne koło)

% Rozwijanie tęczówki do współrzędnych biegunowych
[polar_tab, szum_tab] = polar_transform(oko, ...
    srodki_c(1), srodki_c(2), promienie_c, ...
    srodki_j(1), srodki_j(2), promienie_j, ...
    promien_rozdz, kat_zakres);

% Wyświetlanie znormalizowanego obrazu
figure
imagesc(polar_tab)
colormap(gray)
