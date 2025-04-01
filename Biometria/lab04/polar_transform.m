function [polar_tab, szum_tab] = polar_transform(obraz, x_tecz, y_tecz, r_tecz,...
x_zre, y_zre, r_zre, radpixels, angulardiv)
% normalizacja - wykonuje normalizacje rejonu t�cz�wki przez rozwini�cie 
% do wsp�rz�dnych biegunowych
%   Imput:
% obraz - pole z t�cz�wk�
% x_tecz - wsp�rz�dna x okr�gu okre�laj�cego granic� t�cz�wki
% y_tecz - wsp�rz�dna y okr�gu okre�laj�cego granic� t�cz�wki
% r_tecz - promie� okr�gu otaczaj�cego t�cz�wk�
% x_zre - wsp�rz�dna x okr�gu okre�laj�cego granic� �renicy
% y_zre - wsp�rz�dna x okr�gu okre�laj�cego granic� �renicy
% r_zre - promie� okr�gu otaczaj�cego �renic�
% radpixels - promieniowy rozk�ad, okre�laj�cy pionowy wymiar 
%                         znormalizowanej reprezentacji
% angulardiv - k�towy rozk�ad, okre�laj�cy poziomy wymiar
%                         znormalizowanej reprezentacji
%
%   Output:
% polar_tab
% szum_tab

radiuspixels = radpixels + 2;
angledivisions = angulardiv-1;

theta = 0:2*pi/angledivisions:2*pi;

x_tecz = double(x_tecz);
y_tecz = double(y_tecz);
r_tecz = double(r_tecz);

x_zre = double(x_zre);
y_zre = double(y_zre);
r_zre = double(r_zre);

% obliczanie przesuni�cia �rodka �renicy od �rodka t�cz�wki
ox = x_zre - x_tecz;
oy = y_zre - y_tecz;

if ox <= 0
    sgn = -1;
elseif ox > 0
    sgn = 1;
end

if ox==0 && oy > 0
    
    sgn = 1;
    
end

theta = double(theta);

a = ones(1,angledivisions+1)* (ox^2 + oy^2);

% ox = 0
if ox == 0
    phi = pi/2;
else
    phi = atan(oy/ox);
end

b = sgn.*cos(pi - phi - theta);

% obliczenie promienia wok� t�cz�wki jako funkcji k�ta
r = (sqrt(a).*b) + ( sqrt( a.*(b.^2) - (a - (r_tecz^2))));

r = r - r_zre;

rmat = ones(1,radiuspixels)'*r;

rmat = rmat.* (ones(angledivisions+1,1)*[0:1/(radiuspixels-1):1])';
rmat = rmat + r_zre;

% wykluczenie warto�ci granicy mi�dzy t�cz�wk� i �renic�, 
% mi�dzy t�cz�wk� i tward�wk�, gdy� wprowadzaj� zak��cenia 
rmat  = rmat(2:(radiuspixels-1), :);

% obliczanie kartezja�skich wsp�rz�dnych ka�dego punktu danych wok�
% ko�owego regionu t�cz�wki
xcosmat = ones(radiuspixels-2,1)*cos(theta);
xsinmat = ones(radiuspixels-2,1)*sin(theta);

xo = rmat.*xcosmat;    
yo = rmat.*xsinmat;

xo = x_zre+xo;
yo = y_zre-yo;

% wyliczanie warto�ci intensywno�ci do znormalizowanej reprezentacji przez
% interpolacj�
[x,y] = meshgrid(1:size(obraz,2),1:size(obraz,1));  
polar_tab = interp2(x,y,obraz,xo,yo);

% tworzenie tablicy zak��ce� z lokalizacj� warto�ci NaN
szum_tab = zeros(size(polar_tab));
wspolrzedne = find(isnan(polar_tab));
szum_tab(wspolrzedne) = 1;
polar_tab = double(polar_tab)./255;

% Usuwanie NaN przed wykonaniem transformacji biegunowej
wspolrzedne = find(isnan(polar_tab));
polar_tab2 = polar_tab;
polar_tab2(wspolrzedne) = 0.5;
avg = sum(sum(polar_tab2)) / (size(polar_tab,1)*size(polar_tab,2));
polar_tab(wspolrzedne) = avg;