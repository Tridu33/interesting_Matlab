function [Q,fcount] = quadtx(F,a,b,tol,varargin)
%QUADTX  Evaluate definite integral numerically.
%   Q = QUADTX(F,A,B) approximates the integral of F(x) from A to B
%   to within a tolerance of 1.e-6.
%
%   Q = QUADTX(F,A,B,tol) uses the given tolerance instead of 1.e-6.
%
%   The first argument, F, is a function handle, an inline-object in
%   MATLAB6, or an anonymous function in MATLAB7, that defines F(x).
%
%   Arguments beyond the first four, Q = QUADTX(F,a,b,tol,p1,p2,...),
%   are passed on to the integrand, F(x,p1,p2,..).
%
%   [Q,fcount] = QUADTX(F,...) also counts the number of evaluations
%   of F(x).
%
%   See also QUAD, QUADL, DBLQUAD, QUADGUI.

% Default tolerance
if nargin < 4 | isempty(tol)
   tol = 1.e-6;
end

% Initialization
c = (a + b)/2;
fa = feval(F,a,varargin{:});
fc = feval(F,c,varargin{:});
fb = feval(F,b,varargin{:});

% Recursive call 
[Q,k] = quadtxstep(F, a, b, tol, fa, fc, fb, varargin{:});
fcount = k + 3;

% ---------------------------------------------------------

function [Q,fcount] = quadtxstep(F,a,b,tol,fa,fc,fb,varargin)

% Recursive subfunction used by quadtx.

h = b - a; 
c = (a + b)/2;
fd = feval(F,(a+c)/2,varargin{:});
fe = feval(F,(c+b)/2,varargin{:});
Q1 = h/6 * (fa + 4*fc + fb);
Q2 = h/12 * (fa + 4*fd + 2*fc + 4*fe + fb);
if abs(Q2 - Q1) <= tol
   Q  = Q2 + (Q2 - Q1)/15;
   fcount = 2;
else
   [Qa,ka] = quadtxstep(F, a, c, tol, fa, fd, fc, varargin{:});
   [Qb,kb] = quadtxstep(F, c, b, tol, fc, fe, fb, varargin{:});
   Q  = Qa + Qb;
   fcount = ka + kb + 2;
end
