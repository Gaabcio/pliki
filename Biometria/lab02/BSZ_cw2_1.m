
% Wykrywanie krawêdzi ró¿nymi kernelami
%===========================================================

[X, map]= imread('LENA_old.bmp');
% [X, map]= imread('camerman.bmp');
imshow(X,map);
x= X;%(:,:,1);    %Pobieramy jasnoœæ z jednego z kana³ów np. R
[nr, nc]= size(x);
roz_k= 3;
il_kerneli= 8;
kernel= zeros(roz_k, roz_k,il_kerneli);
% wykrywanie krawêdzi na kierunku: |
kernel(:,:,4)=[1  0 -1
               1  0 -1
               1  0 -1];
% wykrywanie krawêdzi na kierunku: -
kernel(:,:,2)=[1  1  1
               0  0  0
              -1 -1 -1];
% wykrywanie krawêdzi na kierunku: \
kernel(:,:,6)=[0 -1 -1
               1  0 -1
               1  1 0];
% wykrywanie krawêdzi na kierunku:  /
kernel(:,:,1)=[1  1  0
               1  0 -1
               0 -1 -1];

% wykrywanie krawêdzi odbicie zwerciadlane
kernel(:,:,5)=[-1  0  1
               -1  0  1
               -1  0  1];
           
kernel(:,:,7)=[-1 -1 -1
                0  0  0
                1  1  1];

kernel(:,:,3)= [0  1  1
               -1  0  1
               -1 -1  0];

kernel(:,:,8)=[-1 -1  0
               -1  0  1
                0  1  1];           
wynik= zeros(nr, nc, il_kerneli);
 
for i=2:1:nr-1 %przyjmujemy margines do rozmiaru struktury kernela
    for j=2:1:nc-1
        for k= 1:1:il_kerneli
           molekula= x(i-1:i+1, j-1:j+1);   
           wynik(i,j, k)= sum(sum(double(molekula).*kernel(:,:,k)));
        end
    end
end
figure(1)

for k= 1:il_kerneli+1 %wyœwietlania mapy krawêdziowej
    
    if k < 5 
        subplot(3,3,k), imagesc(wynik(:,:,k)), colormap(gray), axis off;
    else
        if k==5 
            subplot(3,3,k), imshow(X,map);
        else 
            subplot(3,3,k), imagesc(wynik(:,:,k-1)), colormap(gray), axis off;
        end
    end
end
   
figure(2)
for k= 1:il_kerneli+1
    
    if k < 5 
        subplot(3,3,k), imagesc(double(X(:,:,1))+0.3*wynik(:,:,k)), colormap(gray), axis off;
    else
        if k==5 
            subplot(3,3,k), imshow(X,map);
        else 
            subplot(3,3,k), imagesc(double(X(:,:,1))+0.1*wynik(:,:,k-1)), colormap(gray), axis off;
        end
    end
end