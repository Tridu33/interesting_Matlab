%	By Philip Torr 2002
%	copyright Microsoft Corp.
%torr_matcher_script
%% to test the Harris corner detector and matcher

clear all
n_corners = 500;

    i1 = imread('j1.bmp','bmp');
    i2 = imread('j2.bmp','bmp');

    g1 = rgb2gray(i1);
    g2 = rgb2gray(i2);



d1 = double(g1);
d2 = double(g2);


disp('detecting corners');
[ccr1] = torr_charris(d1,n_corners);
[ccr2] = torr_charris(d2,n_corners);



%imshow(c1);
%figure;
%imshow(g1);
%display corners
%hold on
%		plot(c_col, c_row, '+');
%		plot(ccr1(:,1), ccr1(:,2), 'g+');
%		plot(ccr2(:,1), ccr2(:,2), 'r+');
%hold off


%imshow(c1);
f1 = figure;
imshow(g2);
title('Second Image')
%display corners
hold on
%		plot(c_col, c_row, '+');
		plot(ccr1(:,1), ccr1(:,2), 'g+');
		plot(ccr2(:,1), ccr2(:,2), 'r+');
hold off
%[matches12,A12] = corn_matcher(c_patches1, c_patches2, ccr1, ccr2);
max_disparity = 20;
half_size = 2;

disp('detecting matches')
[matches12,minc12,mat12] = torr_corn_matcher(d1, d2, ccr1, ccr2,max_disparity,half_size);

max_corn_d = 0; %maximum corner motion
n_matches = length(matches12);

med_minc = median(minc12);


disp('the maximum corner disparity is used for edge matching')
max_corn_d


display_numbers = 0;
torr_display_matches(matches12,display_numbers,f1);





% 
% 
% 
% 
% 
% %displaying stuff
% 
% 
% figure
% %take minimum of matches; minc provides match scores
% imshow(g1);
% title('First Image: plus matches')
% hold on
% plot(ccr1(:,1), ccr1(:,2), 'bs')
% plot(ccr2(:,1), ccr2(:,2), 'rs')
% 
% for i = 1:length(mat12)
%     if mat12(i) ~= 0
%         a = [ccr1(i,1),ccr2(mat12(i),1)];  %x1 x2
%         b = [ccr1(i,2),ccr2(mat12(i),2)];	%y1 y2
%         %x1 y1
%         %x2 y2
%         line(a,b);
%     end
% end
% hold off
% 
% %matches = mat12;
% 
% 
% hold off
% save corners