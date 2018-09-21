%	By Philip Torr 2002
%	copyright Microsoft Corp.
%% to test the Harris corner detector 
%torr_cor_script.m

%clear all
%profile on
figure
i1 = imread('j1.bmp','bmp');
%imshow(i1)
if length(size(i1)) == 3
    g1 = rgb2gray(i1);
else
    g1 = i1;
end
%imshow(g1);
d1 = double(g1);

ncorners = 500
width = 4
sigma = 1
subpixel = 0

[ccr1]  = torr_charris(d1, ncorners, width, sigma, subpixel);


%imshow(c1);
%figure;
imshow(g1);
%display corners
hold on
%		plot(c_col, c_row, '+');
		plot(ccr1(:,1), ccr1(:,2), 'g+');
%		plot(ccr2(:,1), ccr2(:,2), 'r+');
hold off


%figure;
%imshow(c1);


%i2 = imread('msr2.bmp','bmp');
%g2 = rgb2gray(i2);
%d2 = double(g2);
%[c2,ccr2, c_patches2] = iharris(d2,500);

%matches12 = corn_matcher(c_patches1, c_patches2, ccr1, ccr2);

%[x,y] = showcorners(c,20);
%hold on;
%plot(x,y,'sw');
%x
%y

