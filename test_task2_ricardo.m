% Test task2 - Ricardo

input = im2double(imread('train-images\train_images\20151115_172901.tiff'));
ROI = getROI(input, 3);
figure(1), imshow(ROI)

gray = rgb2gray(ROI);
%med = medfilt2(gray);
figure(2), imshow(gray);

%From now on we are using only the red channel to segment cells.
redChannel = ROI(:,:,1);
greenChannel = ROI(:,:,2);
blueChannel = ROI(:,:,3);
figure(3)
subplot(3,1,1), imshow(redChannel);
subplot(3,1,2), imshow(greenChannel);
subplot(3,1,3), imshow(blueChannel);

thresh = multithresh(redChannel,3);
seg_otsu = imquantize(redChannel, thresh);
rgb_otsu = label2rgb(seg_otsu);
figure(4), imshow(rgb_otsu);

figure(5)
subplot(1,3,1), imshow(rgb_otsu(:,:,1)); % This one might be useful.
subplot(1,3,2), imshow(rgb_otsu(:,:,2));
subplot(1,3,3), imshow(rgb_otsu(:,:,3)); % This one is the most useful.

useful = rgb_otsu(:,:,3);
useful2 = imfill(useful, 'holes');
[useful3grad, useful3dir] = imgradient(useful2,'prewitt');
useful3grad = useful3grad./max(useful3grad);
bw = imbinarize(useful3grad);

% Falta tratar o useful para o imfindcircles encontrar alguma coisa
figure(6)
imshow(bw);
[centersD, radiiD] = imfindcircles (bw, [11 70], 'ObjectPolarity', 'bright');
[centersD2, radiiD2] = imfindcircles (bw, [25 60], 'ObjectPolarity', 'bright');
viscircles(centersD, radiiD, 'Color', 'b');
viscircles(centersD2, radiiD2, 'Color', 'b');