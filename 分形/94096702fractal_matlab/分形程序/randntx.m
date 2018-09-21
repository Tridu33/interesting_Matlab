function R = randntx(varargin)
% RANDNTX  Text book version of RANDN
% Normally distributed random numbers
% This M-file reproduces the numerical behavior of
% the builtin RANDN function to within roundoff error.
% Usage:
%    randntx                 1-by-1
%    randtnx(n)              n-by-n
%    randntx(m,n)            m-by-n
%    s = randtx('state')     Get state
%    randtx('state',j)       Set state determined by j.
%    randtx('state',s)       Restore state
% See also RANDN

% Reference: "A fast, easily implemented method for sampling
% from decreasing or symmetric unimodal density functions",
% George Marsaglia and W. T. Tsang, SIAM J. Sci. Stat. Comput.,
% Vol. 5, No. 2, June 1984, pp. 349-359.

persistent z
if isempty(z)

   % Initialize the ziggurat and the state.

   z = randnsetup;
   randuni(0);
end

if nargin > 0 && isequal(varargin{1},'state')

   % Get or set the state.

   if nargin == 1
      R = randuni('state');
   else
      randuni(varargin{2});
   end
   return
end

% Determine the size of the output.

if nargin == 0
   m = 1; n = 1;
elseif nargin == 1
   m = varargin{1}; n = varargin{1};
else
   m = varargin{1}; n = varargin{2};
end

% Ziggurat normal random number generator.

R = zeros(m,n);
for k = 1:m*n
   [u,j] = randuni;
   rk = u*z(j+1);
   if abs(rk) < z(j)
      R(k) = rk;
   else
      R(k) = randntips(rk,j,z);
   end
end


% ----------------------------------------------------

function [u,j] = randuni(state)
% RANDUNI  Uniform random number generator used by RANDN.
% Should be initialized with
%    randuni(0) 
% Then
%    [u,j] = randuni
% generates a single random real number, -1 < u < 1,
% and an optional random integer, 1 <= j <= 64.
% The internal state is a vector s of two integers that
% can be retrieved or restored with
%    s = randuni('state')
%    randuni(s)
%    randuni(j)

   persistent icng jsr
   if nargin > 0

      % Get or set the state

      if ischar(state)
         u = [icng; jsr];
      elseif length(state) == 1
         icng = 362436069;
         jsr = state;
         if jsr == 0, jsr = 521288629; end
      else
         icng = state(1);
         jsr = state(2);
      end
      return
   end

   % The algorithm combines multiplicative congruential and
   % shift register generators.

   icng = mod(69069*icng + 1234567,2^32);
   jsr = bitxor(jsr,bitshift(jsr,13,32));
   jsr = bitxor(jsr,bitshift(jsr,-17,32));
   jsr = bitxor(jsr,bitshift(jsr,5,32));
   m = mod(icng+jsr,2^32);
   if m >= 2^31, m = m - 2^32; end
   u = pow2(m,-31);
   j = mod(m,64)+1;


% ----------------------------------------------------

function z = randnsetup
% RANDNSETUP(n)  Generate ziggurat used by RANDN.

   n = 64;
   c = sqrt(pi/2)/n;
   xn = fzerotx(@Fp, [1,5], 3*c);
   z = zeros(n+1,1);
   z(n-2:n+1) = xn;
   for k = n-3:-1:1
      z(k) = sqrt(-2*log(exp(-z(k+1).^2/2) + c/z(k+1)));
   end
   z(n-2:n+1) = z(n-2:n+1)-1.e-7;
   z = roundp(z,7);

% ----------------------------------------------------

function y = Fp(x,q)
% Used by RANDNSETUP
   y = x.*exp(-x.^2/2)-q;


% ----------------------------------------------------

function rk = randntips(r,j,z)
% RANDNTIPS  Detailed calculations in the zigguart tips.

   persistent a b c c1 c2 pc xn
   if isempty(xn)

      % One time parameter computation

      % f = @(x) exp(-x.^2/2);
      n = length(z)-1;
      x0 = z(1);
      b = roundp(sqrt(sqrt(pi/2)*x0*(1-sum(z(1:n)./z(2:n+1))/n)/(1-f(x0))),7);
      a = roundp(x0/(b*(1-f(x0))),5);
      c = roundp(1+a*f(-x0),5);
      c1 = 0.5+n*z(n-2)*(f(0.5*(z(n-2)+z(n-3)))-f(z(n-2)))/sqrt(pi/2);
      c1 = roundp(c1-.0000057,7);
      c2 = roundp(2-x0/b,6);
      pc = roundp(sqrt(pi/2)/n,8);
      xn = roundp(z(n+1),6);
   end

   x = (abs(r)-z(j))/(z(j+1)-z(j));
   y = (1 + randuni)/2;
   s = x + y;
   if s > c2
      rk = sign(r)*(b-b*x);
      return
   end

   if s <= c1
      rk = r;
      return
   end

   x = b - b*x;
   if y > c-a*exp(-x^2/2)
      rk = sign(r)*x;
      return
   end

   if exp(-z(j+1)^2/2)+y*pc/z(j+1) <= exp(-r^2/2)
      rk = r;
      return
   end

   while 1
      x = log(0.5 + 0.5*randuni)/xn;
      x2 = -2.*log(0.5 + 0.5*randuni);
      if x2 > x^2
         rk = sign(r)*(xn - x);
         return
      end
   end


% ----------------------------------------------------

function y = f(x)
% Used by RANDNTIPS
   y = exp(-x.^2/2);


% ----------------------------------------------------

function x = roundp(x,p)
% Duplicate the precision of builtin source code constants.
% roundp(x,p) rounds x to accuracy of 10^(-p).
s = 10^p;
x = round(s*x)/s;


