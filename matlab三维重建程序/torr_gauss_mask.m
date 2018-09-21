%	By Philip Torr 2002
%	copyright Microsoft Corp.
% %
% % HISTORY
%   2001 Philip Torr (philtorr@microsoft.com, phst@robots.ac.uk) at Microsoft
%   Created.
% 
%  Copyright © Microsoft Corp. 2002
%
%
%	Returns a W x W matrix with a unit amplitude Gaussian function of
%	standard deviation SIGMA.  The Gaussian is centered within the matrix.
%
function gmask = gauss_mask(w, sigma)

	ww = 2*w + 1;

	[x,y] = meshgrid(-w:w, -w:w);

	gmask = 1/(2*pi) * exp( -(x.^2 + y.^2)/2/sigma^2);

	gmask = gmask / sum(sum(gmask));
