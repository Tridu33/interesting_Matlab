function c = randcantor(p,n,d,varargin)
%RANDCANTOR  1D, 2D or 3D generalized random Cantor set
%   C = RANDCANTOR(P, N, D) generates a logical D-dimensional array (with
%   D=1, 2, or 3) of size N^D, containing a set of fractally-distributed 1.
%   The size N must be a power of 2. C is obtained by iteratively dividing
%   an initial set filled with 1 into 2^D subsets, multiplying each by 0
%   with probability P (with 0<P<1). The resulting array has a fractal
%   dimension DF = D + log(P)/log(2) < D.
%
%   If the second and third input arguments are not specified, N=256 and
%   D=2 are taken by default (i.e. returns an array of size 256x256).
%
%   C = RANDCANTOR(P,N,D,'show') also displays the set (only for 1D and
%   2D). If no output argument, this option is selected by default.
%
%   Example:
%     c = randcantor(0.7, 1024, 2);
%     boxcount(c);
%
%   F. Moisy
%   Revision: 2.00,  Date: 2006/11/22


% History:
% 2001/02/26: v1.00, first version, boxdiv1.
% 2006/11/22: v2.00, joined boxdiv1,2,3.

error(nargchk(1,4,nargin));

if nargin==1
    n = 256;
    d = 2;
elseif nargin==2
    d = 2;
end
switch d
    case 1, c = boxdiv1(true(1,n),p);
    case 2, c = boxdiv2(true(n,n),p);
    case 3, c = boxdiv3(true(n,n,n),p);
    otherwise, error('Dimension should be 1, 2, or 3.');
end
if nargout==0 || any(strncmpi(varargin,'show',1))
    switch d
        case 1
            imagesc(~c);
            set(gca,'PlotBoxAspectRatio',[40 1 1]);
            set(gca,'TickLength',[0 0]);
            set(gca,'YTick',[]);
            colormap gray
        case 2
            imagesc(~c);
            axis image
            colormap gray
        case 3
            warning('No display of 3D sets. Use the syntax C = BOXDIV(...)');
    end
end;

if nargout==0
    clear c
end

% -----------------------  1D boxdiv ------------------------------ %

function c=boxdiv1(c,p)
siz = length(c);
if siz==1
    c=true;
else
    siz2 = round(siz/2);
    % sub-line left
    c(1:siz2) = c(1:siz2) & (rand<p);
    if c(1)
        c(1:siz2) = boxdiv1(c(1:siz2),p);
    end

    % sub-line right
    c((1+siz2):siz) = c((1+siz2):siz) & (rand<p);
    if c(1+siz2)
        c((1+siz2):siz) = boxdiv1(c((1+siz2):siz),p);
    end
end


% -----------------------  2D boxdiv ------------------------------ %

function c=boxdiv2(c, p)
siz = length(c);
if siz==1
    c=true;
else
    siz2 = round(siz/2);

    % sub-square top-left
    c(1:siz2, 1:siz2) = c(1:siz2, 1:siz2) & (rand<p);
    if c(1,1)
        c(1:siz2,1:siz2) = boxdiv2(c(1:siz2,1:siz2),p);
    end

    % sub-square top-right
    c((1+siz2):siz,1:siz2) = c((1+siz2):siz,1:siz2) & (rand<p);
    if c(1+siz2,1)
        c((1+siz2):siz,1:siz2) = boxdiv2(c((1+siz2):siz,1:siz2),p);
    end

    % sub-square bottom-left
    c(1:siz2,(1+siz2):siz) = c(1:siz2,(1+siz2):siz) & (rand<p);
    if c(1,1+siz2)
        c(1:siz2,(1+siz2):siz) = boxdiv2(c(1:siz2,(1+siz2):siz),p);
    end

    % sub-square bottom-right
    c((1+siz2):siz,(1+siz2):siz) = c((1+siz2):siz,(1+siz2):siz) & (rand<p);
    if c(1+siz2,1+siz2)
        c((1+siz2):siz,(1+siz2):siz) = boxdiv2(c((1+siz2):siz,(1+siz2):siz),p);
    end
end


% -----------------------  3D boxdiv ------------------------------ %

function c=boxdiv3(c,p)
siz = length(c);
if siz==1
    c=true;
else
    siz2 = round(siz/2);

    % sub-cube top-left  front
    c(1:siz2,1:siz2,1:siz2) = c(1:siz2,1:siz2,1:siz2) & (rand<p);
    if c(1,1,1)
        c(1:siz2,1:siz2,1:siz2) = boxdiv3(c(1:siz2,1:siz2,1:siz2),p);
    end

    % sub-cube top-right  front
    c((1+siz2):siz,1:siz2,1:siz2) = c((1+siz2):siz,1:siz2,1:siz2) & (rand<p);
    if c(1+siz2,1,1)
        c((1+siz2):siz,1:siz2,1:siz2) = boxdiv3(c((1+siz2):siz,1:siz2,1:siz2),p);
    end

    % sub-cube bottom-left  front
    c(1:siz2,(1+siz2):siz,1:siz2) = c(1:siz2,(1+siz2):siz,1:siz2) & (rand<p);
    if c(1,1+siz2,1)
        c(1:siz2,(1+siz2):siz,1:siz2) = boxdiv3(c(1:siz2,(1+siz2):siz,1:siz2),p);
    end

    % sub-cube bottom-right  front
    c((1+siz2):siz,(1+siz2):siz,1:siz2) = c((1+siz2):siz,(1+siz2):siz,1:siz2) & (rand<p);
    if c(1+siz2,1+siz2,1)
        c((1+siz2):siz,(1+siz2):siz,1:siz2) = boxdiv3(c((1+siz2):siz,(1+siz2):siz,1:siz2),p);
    end

    % sub-cube top-left  bottom
    c(1:siz2,1:siz2,(1+siz2):siz) = c(1:siz2,1:siz2,(1+siz2):siz) & (rand<p);
    if c(1,1,1+siz2)
        c(1:siz2,1:siz2,(1+siz2):siz) = boxdiv3(c(1:siz2,1:siz2,(1+siz2):siz),p);
    end

    % sub-cube top-right  bottom
    c((1+siz2):siz,1:siz2,(1+siz2):siz) = c((1+siz2):siz,1:siz2,(1+siz2):siz) & (rand<p);
    if c(1+siz2,1,1+siz2)
        c((1+siz2):siz,1:siz2,(1+siz2):siz) = boxdiv3(c((1+siz2):siz,1:siz2,(1+siz2):siz),p);
    end

    % sub-cube bottom-left  bottom
    c(1:siz2,(1+siz2):siz,(1+siz2):siz) = c(1:siz2,(1+siz2):siz,(1+siz2):siz) & (rand<p);
    if c(1,1+siz2,1+siz2)
        c(1:siz2,(1+siz2):siz,(1+siz2):siz) = boxdiv3(c(1:siz2,(1+siz2):siz,(1+siz2):siz),p);
    end

    % sub-cube bottom-right  bottom
    c((1+siz2):siz,(1+siz2):siz,(1+siz2):siz) = c((1+siz2):siz,(1+siz2):siz,(1+siz2):siz) & (rand<p);
    if c(1+siz2,1+siz2,1+siz2)
        c((1+siz2):siz,(1+siz2):siz,(1+siz2):siz) = boxdiv3(c((1+siz2):siz,(1+siz2):siz,(1+siz2):siz),p);
    end
end
