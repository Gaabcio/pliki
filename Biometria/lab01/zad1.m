%ZADANIE 1

% Wczytanie obrazu
zdj = imread('win.gif');


imshow(zdj);

% Monochromatycznosc
Mono = rgb2gray(zdj);
imshow(Mono);

% Binaryzacja metodą Otsu
binary = graythresh(Mono);
BW = imbinarize(Mono, binary);
figure,imshow(BW);