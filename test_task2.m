close all; clear all;
% Obter ROI
input = im2double(imread('train-images\train_images\20151115_172901.tiff'));
[ROI, topLine, leftColumn] = getROI(input, 3);
figure, imshow(ROI)
%%
% Passar para cinza e suaviza��o
gray = rgb2gray(ROI);
med = medfilt2(gray);
figure, imshow(med)
%%
% suavizar linhas ligeiramente
SE = strel('disk', 10);
open = imclose(med, SE);
figure, imshow(open)
figure, imhist(open)
%% 
sub = imsubtract(open, med);
sub = imadjust(sub);
figure, imshow(sub)
%%
% Obter gradiente
[Gmag, Gdir] = imgradient(sub, 'sobel');
figure, imshow(Gmag)
%% 
fill = imfill(Gmag, 'holes');
figure, imshow(fill)
%%
bw = imbinarize(fill);
figure, imshow(bw)
%%
[centers, radii] = imfindcircles (bw, [11 50]); 
viscircles(centers, radii);