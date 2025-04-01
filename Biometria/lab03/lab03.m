% Zadanie 1 - Ścienianie obrazu i morfologiczne operacje filtracji

% 1. Załaduj obraz testowy

[x, map] = imread('finger.bmp');

% 2. Szablony (kernels) dla algorytmu ścieniania

north = [0 0 0; 1 1 0; 0 1 1];
south = [0 0 1; 0 1 1; 0 0 0];
west = [1 0 0; 1 0 0; 1 1 0];
east = [0 1 0; 0 1 1; 0 0 1];

% 3. Funkcja do konwersji liczby dziesiętnej na 8-bitową reprezentację binarną

function bin = intbin8(num)
    bin = bitget(num, 8:-1:1);
end

% 4. Przygotowanie parametrów do filtracji morfologicznej

s = [192 80 12 5 3 65 48 20];
m = [206 87 236 117 59 93 179 213];
S = []; M = [];
for i = 1:8
    S(:,i) = intbin8(s(i));
    M(:,i) = intbin8(m(i));
end

% 5. Załaduj obraz testowy do weryfikacji

[f, map] = imread('ZG.bmp');

% Modyfikacja parametrów filtracji

s = [192 2 12 5 3 65 48 20];
m = [206 58 236 117 59 93 179 213];
S = []; M = [];
for i = 1:8
    S(:,i) = intbin8(s(i));
    M(:,i) = intbin8(m(i));
end

% 6. Wyświetl wyniki filtracji

% 7. Algorytm realizujący szkieletyzację (Chin-Wan-Stover-Iverson)

VAR = 2; % Wybór metody Chin-Wan-Stover-Iverson
s1 = [192, 80, 12, 5, 3, 65, 48, 20];
s2 = [81, 69, 21, 84, 80, 65, 5, 20];
s3 = [1, 64];
m1 = [206, 87, 236, 117, 59, 93, 179, 213];
m2 = [95, 125, 245, 215, 87, 93, 117, 213];
m3 = [17, 68];
% Zmienna do przechowywania szablonów
S1 = []; S2 = []; S3 = [];
M1 = []; M2 = []; M3 = [];
for i = 1:8
    S1(:,i) = intbin8(s1(i));
    S2(:,i) = intbin8(s2(i));
    M1(:,i) = intbin8(m1(i));
    M2(:,i) = intbin8(m2(i));
end
for i = 1:2
    S3(:,i) = intbin8(s3(i));
    M3(:,i) = intbin8(m3(i));
end
% 8. Przeprowadzenie iteracji dla szkieletyzacji
g = f; % negatyw
h = g; % początkowy stan obrazu
W = 0; % zmiana piksela
W4 = 0; % licznik podcykli
l_iteracji = 0; % liczba iteracji
while W4 < 5
    disp(sprintf('Iteracja= %i,', l_iteracji + 1))
    W = 0;
    % Pętla przechodząca po obrazie
    for i = 2:size(g,1)-1
        for j = 2:size(g,2)-1
            if g(i,j) > 0
                molekula = [g(i,j+1); g(i-1,j+1); g(i-1,j); g(i-1,j-1); g(i,j-1); g(i+1,j-1); g(i+1,j); g(i+1,j+1)];
                
                % Wybór metody
                if VAR == 1 % metoda Arcelli
                    for z = 1:2
                        if (molekula .* M1(:,z)) == S1(:,z)
                            h(i,j) = 0; W = 1; break;
                        end
                    end
                else % metoda Chin-Wan-Stover-Iverson
                    if (molekula .* M2(:,8)) == S2(:,8)
                        h(i,j) = 0; W = 1;
                    else
                        if (((molekula .* M3(:,1)) == S3(:,1) & (g(i,j+2) == 0)) | ...
                           ((molekula .* M3(:,2)) == S3(:,2) & (g(i+2,j) == 0)))
                        else
                            for z = 1:7
                                if (molekula .* M2(:,z)) == S2(:,z)
                                    h(i,j) = 0; W = 1; break;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    % Zmiana obrazu
    l_iteracji = l_iteracji + 1;
    g = h;
    
    % Kontrola liczby cykli
    if W == 0
        W4 = W4 + 1;
    else
        W4 = 0;
    end
    if VAR == 1 && W4 == 4
        break;
    end
    % Zmiana numeru indeksu szablonu
    c = 1 + 2 * rem(l_iteracji, 4);
    g = h;
end
% 9. Wyświetlenie wyników
figure;
subplot(1,2,1); imagesc(f); colormap(gray); title('Original Image');
subplot(1,2,2); imagesc(h); colormap(gray); title('Skeletonized Image');
toc; % Zmierzenie czasu wykonania algorytmu





%Algorytm realizujący thining obrazów binarnych
%====================================================================
% VAR=1-metoda Arcelli-Cordella-Levialdi,
% VAR=2-metoda Chin-Wan-Stover-Iverson,
% S1 szablon dla metody I, M1- maska bitów dowolnych,
% S2/S3 szablon dla metody II, M2/M3- maska bitów dowolnych,

VAR= 2; %Wariant metody

s1= [192, 80, 12, 5, 3, 65, 48, 20];
s2= [81, 69, 21, 84, 80, 65, 5, 20];
s3= [1, 64];

m1= [206, 87, 236, 117, 59, 93, 179, 213];
m2= [95, 125, 245, 215, 87, 93, 117, 213];
m3= [17, 68];

[f,map]=imread('finger.jpg');

%Zamiana na postac binarna
S1=[]; S2=[]; S3=[];
M1=[]; M2=[]; M3=[];

for i=1:8
    S1(:,i)= intbin8(s1(i));
    S2(:,i)= intbin8(s2(i));
    M1(:,i)= intbin8(m1(i));
    M2(:,i)= intbin8(m2(i));
end

for i=1:2
    S3(:,i)= intbin8(s3(i));
    M3(:,i)= intbin8(m3(i));
end

[nr, nc]= size(f);
g=f;    %negatyw (f~=1);

%h=zeros(nr,nc); % Pojemnik na obraz przejsciowy

start= tic();
c=1;    %Indeks do szablonu north, south, west, east
W= 0;   %Zmodyfikowal chociaz jeden piksel 1 jesli nie 0
W4=0;   %Licznik podcykli wdg ktorego przetwarzany jest obraz w okreslonym kierunku
l_iteracji=0    %Liczba wykonanych iteracji na obrazie do zbiegniecia
z=0;
h=g;

while W4<5
    disp(sprintf('Iteracja= %i,',l_iteracji+1))
    W=0;
    %**************************************************************
    for i=2:nr-1
        %************************************************************
        for j=2:nc-1
            %disp(sprintf('z=%i, Iteracja=%i, Wiersz= %i, Kolumna= %i, W4= %i, W=
%i,',c,l_iteracji,i,j,W4,W))
            if g(i,j)>0
                molekula= [g(i,j+1); g(i-1,j+1); g(i-1,j); g(i-1,j-1); g(i,j-1); g(i+1,j-1); g(i+1,j);
g(i+1,j+1)];
                if VAR==1 % metoda Arcelli
                    for z=c:c+1 %Przykladaj poszczegolne szablony
                        if (double(molekula).*M1(:,z))==S1(:,z)
                            h(i,j)=0; W=1; break;
                        end
                    end
                    %==============================================
                else    %VAR==2 metoda Chin-Wan-Stover-Iverson
                    if (double(molekula).*M2(:,8))==S2(:,8)
                        h(i,j)=0; W=1; %zmienil piksel
                    else
                        if (((((double(molekula)).*M3(:,1))==S3(:,1)) & (g(i,j+2)==0)) | ...
                                (((double(molekula)).*M3(:,2))==S3(:,2)) & (g(i+2,j)==0))
                            %nic nie rób
                        else
                            for z=1:7
                                if (double(molekula).*M2(:,z))==S2(:,z)
                                    h(i,j)=0; W=1; %zmieni piksel
                                    break;
                                end
                            end
                        end
                    end
                    %=====================================================
                end
            end     %End od if g(i,j)>0
        end     %Koniec pierwszego for
        %************************************************************
    end     %Koniec drugiego for
    %**************************************************************
    %*************************************************************
    l_iteracji= l_iteracji+1;
    g=h;

    %Jesli metoda pierwsza to kontroluj numer cyklu
    if W==0
        W4=W4+1;
    else
        W4=0;
    end

    if (VAR==1)&(W4==4)
        break;
    end
    c=1+2*rem(l_iteracji,4); %Zmienia numer indeksu w tablicy filtrow
    g= h;
    %*************************************************************
end     %Koniec While
%**************************************************************
toc(start)
figure;
imagesc((uint8(f)+2*uint8(g))/max(max(uint8(f)+uint8(g))));
colormap(jet);