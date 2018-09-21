function [L,lambda] = membranetx(k,m,n,np)
%MEMBRANETX  Textbook version of MEMBRANE, eigenfunctions of L-membrane.
%
%   L = MEMBRANETX(k) is the k-th eigenfunction of the L-shaped membrane.
%   [L,lambda] = MEMBRANETX(k) also returns the k-th eigenvalue.
%
%   L = MEMBRANETX(k,m,n,np) sets some mesh and accuracy parameters:
%
%     k = index of eigenfunction, default k = 1.
%     m = number of points on one edge of one square.
%         The output L is 2*m+1-by-2*m+1.  The default m = 30.
%     n = number of terms in sum, default n = min(m,20).
%     np = number of terms in partial sum, default np = n.
%     With np = n, the eigenfunction is zero on the boundary.
%     With np < n, such as np = 2, the boundary is not tied down.
%
%   L = ROT90(MEMBRANETX(1,15,9,2),-1) is the MathWorks logo.

% Default parameters

if nargin < 1, k = 1; end
if nargin < 2, m = 30; end
if nargin < 3, n = min(m,20); end
if nargin < 4, np = n; end

% Compute eigenvalue and symmetry class.
% sym = 1, symmetric about center line
% sym = 2, antisymmetric about center line
% sym >= 3, eigenvalue of the square, reflected into other squares

[lambda,sym] = membraneval(k,m,n);
if m == 1, L = lambda(k); return, end

% The null vector from the SVD of the boundary matrix gives coefficients.

[sigma,c,alfa] = membranesvd(lambda,sym,m,n);

% Evaluate the eigenfunction on a square grid.

L = membranefun(lambda,sym,c,alfa,m,n,np);

% ------------------------------

function [lambda,sym] = membraneval(k,m,n);
% MEMBRANEVAL
% [lambda,sym] = membraneval(k,m,n) is the k-th eigenvalue of
% the L shaped membrane, and its symmetry class.
% m = number of points on one edge of one square.
% n = number of terms in sum.

persistent lambdas syms

if isempty(lambdas) & exist('membrane.mat')
   % Load precomputed eigenvalues
   load membrane.mat
end

if length(lambdas) < k
   % Compute eigenvalues beyond those already computed.
   % Algorithm:
   % Use direct search to get near local minima of membranesvd(lambda).
   % Then use "fmintx" to home in on the minimizers.
   % The step size delta controls the direct search.
   % Increasing delta decreases computer time, but might miss some eigenvalues. 
   % kmax = number of eigenvalues.
   % delta = search increment.
   % tol = tolerance for fmintx
   kmax = k;
   delta = .01;
   tol = 1.e-12;
   k = length(lambdas);
   if k == 0
      lambdas(1) = fmintx(@membranesvd,9.6,9.7,tol,1,m,n);
      syms(1) = 1;
      k = 1;
      fprintf(1,'%4.0d %18.12f %4.0d\n',k,lambdas(k),syms(k))
   end
   xstart = delta*floor(lambdas(k)/delta);
   x = [0 0 xstart];
   f = zeros(3,3);

   % Look for x so that f(x) < both f(x-delta) and f(x+delta).
   while k < kmax
      x(1:2) = x(2:3);
      x(3) =  x(3) + delta;
      for s = 1:3    % Symmetry class.
         f(s,1:2) = f(s,2:3);
         f(s,3) = membranesvd(x(3),s,m,n);
         if f(s,2) < f(s,1) & f(s,2) < f(s,3);
            lam = fmintx(@membranesvd,x(1),x(3),tol,s,m,n);
            if s < 3
               mult = 1;
            else
               % Multiple eigenvalues are integer multiples of pi^2
               p = round(lam/pi^2);
               lam = p*pi^2;
               [i,j] = ndgrid(1:sqrt(p));
               mult = sum(p == i(:).^2+j(:).^2);
            end
            for mu = 1:mult
               k = k+1;
               lambdas(k,1) = lam;
               syms(k,1) = s+mu-1;
               fprintf(1,'%4.0d %18.12f %4.0d\n',k,lambdas(k),syms(k))
               pause(0)
            end
         end
      end
   end
end

[lambdas,p] = sort(lambdas);
syms = syms(p);
% save membrane lambdas syms
lambda = lambdas(k);
sym = syms(k);

% ------------------------------

function [sigma,c,alfa] = membranesvd(lambda,sym,m,n)
% MEMBRANESVD
% Evaluate fundamental solutions on boundary of L-shaped region.
% sigma = membranesvd(lambda,s,m,n) is the smallest singular value of the
% matrix obtained by evaluating n fundamental solutions with symmetry class
% s at 3*m+1 points on the boundary of the L.  If lambda is chosen to give
% a local minima of this function, the resulting null vector, c, provides
% coeffients for a linear combination over the entire region that nearly
% vanishes on the boundary.
%
% Input:
%   lambda = eigenvalue parameter, vary this to minimize the resulting sigma.
%   sym = symmetry class.
%   m = number of points on edge of one square.
%   n = number of fundamental solutions.
%
% Output:
%   sigma = smallest singular value.
%   c = null vector = coefficients.
%   alfa = 1-by-n vector of Bessel function orders for given symmetry.

% Bessel function orders.
% sym = 1, alfa = (2/3) * [1 5 7 11 13 ... ], (odd, not divisible by 3)
% sym = 2, alfa = (2/3) * [2 4 8 10 14 ... ], (even, not divisible by 3)
% sym >= 3, alfa = [2 4 6 8 10 ... ] = even integers

switch sym
   case {1,2}
      j = (sym:2:3*n);
      j(mod(j,3)==0) = [];
      alfa = (2/3)*j;
   otherwise
      alfa = 2*(1:n);
end

% Use polar coordinates to describe three-eighths of the boundary.

x = [ones(m,1); (m:-1:-m)'/m];
y = [(0:m-1)'/m; ones(2*m+1,1)];
theta = atan2(y,x);
r = sqrt(x.^2 + y.^2);

% Evaluate the fundamental solutions on the boundary.
% A is a (3*m+1)-by-n matrix.

A = besselj(alfa,sqrt(lambda)*r).*sin(theta*alfa);

% Scale to make columns comparable.

scale = diag(sparse(1./sqrt(sum(A.*A))));
A = A*scale;

% Compute SVD and obtain coefficients from null vector(s).

[U,S,V] = svd(A,0);
if sym > 3, n = n-(sym-3); end    % Multiple eigenvalue
sigma = S(n,n);
c = scale*V(:,n);

% ------------------------------

function L = membranefun(lambda,sym,c,alfa,m,n,np)
% MEMBRANEFUN  Evaluate the eigenfunction on a square grid.
% L = membranefun(lambda,sym,c,alfa,m,n,np)
% Used by MEMBRANETX.

[x,y] = meshgrid((-m:m)/m,(m:-1:0)'/m);
r = sqrt(x.*x + y.*y);
theta = atan2(y,x);
theta(m+1,m+1) = 0;
S = zeros(m+1,2*m+1);
for j = 1:np
   S = S + c(j)*besselj(alfa(j),sqrt(lambda)*r).*sin(alfa(j)*theta);
end
S = S/S(min(find(abs(S(:)) == max(abs(S(:))))));
L = zeros(2*m+1,2*m+1);
switch sym
   case 1
      L(1:m+1,:) = triu(S);
      L = L + L' - diag(diag(L));
   case 2
      L(1:m+1,:) = triu(S);
      L = L - L';
   otherwise
      L(1:m,1:m) = S(1:m,1:m);
      L(m+2:2*m+1,1:m) = -flipud(L(1:m,1:m));
      L(1:m,m+2:2*m+1) = -fliplr(L(1:m,1:m));
end
