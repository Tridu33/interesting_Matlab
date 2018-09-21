% %
% % HISTORY
%   2001 Philip Torr (philtorr@microsoft.com, phst@robots.ac.uk) at Microsoft
%   Created.
% 
%  Copyright © Microsoft Corp. 2002
%
%
% REF:	"A combined corner and edge detector", C.G. Harris and M.J. Stephens
%	Proc. Fourth Alvey Vision Conf., Manchester, pp 147-151, 1988.
%
%%to do: we might want to make this so it can either take a threshold or a fixed number of corners...
% 
% c_coord is the n x 2 x,y position of the corners
% im is the image as a matrix
% width is the width of the smoothing function
% sigma is the smoothing sigma
% subpixel = 1 for subpixel results (not implemented yet)

%%%%%bugs fixed Jan 2003
    
function [c_coord] = torr_charris(im, ncorners, width, sigma, subpixel)


if (nargin < 2)
    error('not enough input in  charris');
elseif (nargin ==2)
    width = 3; %default
    sigma = 1;
end

if (nargin < 5)
    subpixel = 0;
end

mask = [-1 0 1; -1 0 1; -1 0 1] / 3;

% compute horizontal and vertical gradients
%%note because of the way Matlab does this Ix and Iy will be 2 rows and columns smaller than im
Ix = conv2(im, mask, 'valid');
Iy = conv2(im, mask', 'valid');

% compute squares amd product
Ixy = Ix .* Iy;
Ix2 = Ix.^2;
Iy2 = Iy.^2;
Ixy2 = Ixy .^2;

% smooth them
gmask = torr_gauss_mask(width, sigma);

%gim = conv2(im, gmask, 'valid');
%%note because of the way Matlab does this Ix and Iy will be width*2 rows and columns smaller than Ix2,
% for a total of (1 + width)*2 smaller than im.
GIx2 = conv2(Ix2, gmask, 'valid');
GIy2 = conv2(Iy2, gmask, 'valid');
GIxy2 = conv2(Ixy2, gmask, 'valid');

% computer cornerness
% c = (GIx2 + GIy2) ./ (GIx2 .* GIy2 - GIxy2 + 1.0);
  
 %%%one problem is that this could be negative for certain images.
c = (GIx2 + GIy2) - 0.04 * (GIx2 .* GIy2 - GIxy2.^2);
%figure
%imagesc(c);
%figure
%c is smaller than before got border of 2 taken off all round
%size(c)

%compute max value around each pixel
%cmin = imorph(c, ones(3,3), 'min');
%assuming that the values in c are all positive,
%this returns the max value at that pixel if it is a local maximum,
%otherwise we return an arbitrary negative value
cmax = torr_max3x3(double(c));

%
% if pixel equals max, it is a local max, find index, 
ci3 = find(c == cmax);
cs3 = c(ci3);

[cs2,ci2] = sort(cs3); %ci2 2 is an index into ci3 which is an index into c


%put strongest ncorners corners in a list cs together with indices ci

l = length(cs2)
lb = max(1,l-ncorners+1);

cs = cs2(lb:l);
ci2s = ci2(lb:l);

ci = ci3(ci2s);

corn_thresh = cs(1);

disp(corn_thresh);


%row and column of each corner

[nrows, ncols] = size(c);

%plus four for border
%   c_row = rem(ci,nrows) +4;
%   c_col = ( ci - c_row )/nrows + 1 +4;
border = 1 + width;
c_row = rem(ci,nrows) + border;
c_col = ( ci - c_row  +2)/nrows + 1 + border;

%   %to convert to x,y we need to convert from rows to y
c_coord = [c_col c_row];


%see Nister's thesis page 19.
if subpixel
    disp('subpixel not done yet')
end















%display corners....
%hold on

%		plot(c_col, c_row, '+');
%		plot(c_coord(:,1), c_coord(:,2), '+');
% hold off
%index runs
% 1 4 
% 2 5\
% 3 6 

%ci = ci + 4 * nrows + 4;
%ci = (nrows + 4) * 4 + 4 + ci;
%c_patches = [gim(ci - nrows) gim(ci - nrows-1) gim(ci - nrows+1) gim(ci-1) gim(ci) gim(ci+1) gim(ci+nrows) gim(ci+nrows+1) gim(ci+nrows-1)];


%   hold on
%   	imagesc(im);
%		plot(c_col, c_row, 'sw')
%  hold off


%  	size(im)
% 		size(cp)

%		imr =   im2col(im, [5,5])';
%		im_corr = imr(ci);
%  	im(c_row(:)-1, c_col(:)-1) 
%		each row is a 3x3 matrix
%    	c_patches = [ im(c_row-1, c_col-1) im(c_row-1, c_col) im(c_row-1, c_col+1) ...
%          im(c_row, c_col-1) im(c_row, c_col) im(c_row, c_col+1) ...
%          im(c_row+1, c_col-1) im(c_row+1, c_col) im(c_row+1, c_col+1) ];

%c_patches = [im(ci-1) im(ci) im(ci+1)];

%c_patches = [im(ci)];

