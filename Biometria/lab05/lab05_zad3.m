% Frequency fingerprint filtering
%===================================================
% Step 1: Load fingerprint image
close all; clear; clc;
I = imread('finger1.jpg'); % Use grayscale fingerprint
if size(I,3) == 3
I = rgb2gray(I);
end
I = im2double(I);
% Display original
figure; imshow(I); title('Original Fingerprint');
% Step 2: Compute 2D FFT and shift zero freq to center
F = fft2(I);
F_shifted = fftshift(F);
magnitude = log(1 + abs(F_shifted));
% Display frequency spectrum
figure; imshow(magnitude, []); title('Frequency Spectrum (log scale)');
% Step 3: Create bandpass filter mask
[rows, cols] = size(I);
[u, v] = meshgrid(-floor(cols/2):floor((cols-1)/2), -floor(rows/2):floor((rows-1)/2));
D = sqrt(u.^2 + v.^2);
% Define cutoff frequencies
D_low = 10; % Suppress low frequencies (lighting, background)
D_high = 60; % Suppress high freq noise
% Ideal bandpass filter
H = double(D > D_low & D < D_high);
% Optional: visualize filter
figure; imshow(H, []); title('Bandpass Filter Mask');
% Step 4: Apply filter in frequency domain
F_filtered = F_shifted .* H;
% Step 5: Inverse FFT to get enhanced image
I_filtered = real(ifft2(ifftshift(F_filtered)));
% Normalize for display
I_filtered = mat2gray(I_filtered);
% Show enhanced result
figure;
subplot(1,2,1); imshow(I); title('Original');
subplot(1,2,2); imshow(I_filtered); title('Enhanced via Fourier Filtering');