function r = randmcg(p,q)
%RANDMCG   Multiplicative congruential uniform random number generator.
%  Based on the parameters used by MATLAB version 4.
%  The statement
%     r = randmcg
%  generates a single uniformly distributed random number.
%  The statement
%     r = randmcg(m,n)
%  generates an m-by-n random matrix.
%  The statement
%     clear randmcg
%  will cause the generator to reinitialize itself.
%  The function can not accept any other starting seed.
%
%  See also RANDGUI, RANDSSP.

persistent m a c x
if isempty(x)
   m  = 2^31-1;
   a = 7^5;
   c = 0;
   x = 1;
end

if nargin < 1, p = 1; end
if nargin < 2, q = p; end
r = zeros(p,q);
for k = 1:p*q
   x = rem(a*x + c, m);
   r(k) = x/m;
end
