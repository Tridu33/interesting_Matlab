function r = randssp(p,q)
%RANDSSP   Multiplicative congruential uniform random number generator.
%  Based on the parameters used by IBM's Scientific Subroutine Package.
%  The statement
%     r = randssp
%  generates a single uniformly distributed random number.
%  The statement
%     r = randssp(m,n)
%  generates an m-by-n random matrix.
%  The statement
%     clear randssp
%  will cause the generator to reinitialize itself.
%  The function can not accept any other starting seed.
%
%  This function uses the "bad" generator parameters that IBM
%  used in several libraries in the 1960's.  There is a strong
%  serial correlation between three consecutive values.
%
%  See also RANDGUI, RANDMCG.

persistent m a c x
if isempty(x)
   m = 2^31;
   a = 2^16+3;
   c = 0;
   x = 123456789;
end

if nargin < 1, p = 1; end
if nargin < 2, q = p; end
r = zeros(p,q);
for k = 1:p*q
   x = rem(a*x + c, m);
   r(k) = x/m;
end
