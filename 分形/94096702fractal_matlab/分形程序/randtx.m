function U = randtx(arg1,arg2)
% RANDTX  Text book version of RAND
% Uniformly distributed random numbers
% This M-file exactly reproduces the numerical
% behavior of the builtin RAND function.
% Usage:
%    randtx                  1-by-1
%    randtx(n)               n-by-n
%    randtx(m,n)             m-by-n
%    s = randtx('state')     Get state
%    randtx('state',j)       Set state determined by j
%    randtx('state',s)       Restore state
% See also RAND

persistent z b i j ulp

if isempty(z)

   % Initialize the state.

   j = 2^31;
   z = randsetup(32,j);
   b = 0;
   i = 0;
   ulp = pow2(1,-53);
end

if nargin > 0 & isequal(arg1,'state')
   if nargin == 1

      % Get the state.

      U = [z; b; pow2(i,-52); pow2(j,-52)];

   elseif length(arg2) == 35

      % Restore the state.

      z = U(1:32);
      b = U(33);
      i = pow2(U(34),52);
      j = pow2(U(35),52);

   else

      % Set the state determined by j.

      j = arg2;
      if j == 0, j = 2^31; end
      z = randsetup(32,j);
      b = 0;
      i = 0;

   end
   return
end

% Determine size of output.

if nargin == 0
   m = 1; n = 1;
elseif nargin == 1
   m = arg1; n = arg1;
else
   m = arg1; n = arg2;
end

% The MATLAB uniform random number generator.

U = zeros(m,n);
for k = 1:m*n
   x = z(mod(i+20,32)+1) - z(mod(i+5,32)+1) - b;
   if x < 0
      x = x + 1;
      b = ulp;
   else
      b = 0;
   end
   z(i+1) = x;
   i = i+1;
   if i == 32, i = 0; end
   [x,j] = randbits(x,j);
   U(k) = x;
end

% ----------------------------------------------------

function z = randsetup(n,j)
% RANDSETUP Generate n floats in [0,1] bit by bit.
% z = RANDSETUP(n,j)
% Seed is j.

   z = zeros(n,1);
   for k = 1:n
      x = 0;
      for d = 1:53
         j = randint(j);
         x = 2*x + bitand(bitshift(j,-19),1);
      end
      z(k) = pow2(x,-53);
   end

% ----------------------------------------------------

function j = randint(j)
% RANDINT  Shift register random integer generator.
% The statement
%    j = randint(j)
% generates another random integer, 0 <= j <= 2^32-1

   j = bitxor(j,bitshift(j,13,32));
   j = bitxor(j,bitshift(j,-17,32));
   j = bitxor(j,bitshift(j,5,32));

% ----------------------------------------------------

function [x,jhi] = randbits(x,jlo)
% RANDBITS  XOR random integer with floating fraction
%    [x,j] = randbits(x,j)

   jhi = randint(jlo);
   mask = bitxor(bitshift(jhi,32,52),jlo);
   [f,e] = log2(x);
   x = pow2(bitxor(pow2(f,53),mask),e-53);
