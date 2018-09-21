clear all;clc;close all;
img = imread('Ö¤¼þpicture.jpg');
% my picture is named lenna.bmp while yours may be not
I = rgb2gray(img);
% Attention: we use the axis off to get rid of the axis.
figure(1),image(I); %equals to imagesc(I,[1 64]);you can try it.
colorbar,title('show by image in figure1');axis off;
figure(2),imagesc(I);
%equals to imagesc(I,[min(I(:)) max(I(:))]);you can try it.
colorbar,title('show by imagesc in figure2');axis off;
%colormap(gray) %use this statement you can get a gray image.
figure(3),imshow(I),colorbar,title('show by imshow in figure3');