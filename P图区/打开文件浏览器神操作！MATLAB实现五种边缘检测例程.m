%MATLAB实现五种边缘检测https://blog.csdn.net/weixin_40202230/article/details/78323404
%常用的边缘检测算法有拉普拉斯边缘检测算法、Robert边缘检测算子、Sobel边缘检测算子、Prewitt边缘检测算子、Canny边缘检测算子。

[filename,pathname]=uigetfile({'*.jpg';'*bmp';'*gif'},'选择原图片');%神操作！！！！
I = imread([pathname,filename]);
I=rgb2gray(I);

%五种边缘检测
figure('Name','进行五种边缘检测');
subplot(2,3,1);
imshow(I);
title('原图');

BW1=edge(I,'Roberts',0.16);
subplot(2,3,2);
imshow(BW1);
title('Robert算子边缘检测')
 
BW2=edge(I,'Sobel',0.16);
subplot(2,3,3);
imshow(BW2);
title('Sobel算子边缘检测')
 
BW3=edge(I,'Prewitt',0.06);
subplot(2,3,4);
imshow(BW3);
title('Prewitt算子边缘检测');
 
BW4=edge(I,'LOG',0.012);
subplot(2,3,5);
imshow(BW4);
title('LOG算子边缘检测')
 
BW5=edge(I,'Canny',0.35);
subplot(2,3,6);
imshow(BW5);

title('Canny算子边缘检测')







