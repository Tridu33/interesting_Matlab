function A = golub(n)
%GOLUB  Badly conditioned integer test matrices.
%   GOLUB(n) is the product of two random integer n-by-n matrices,
%   one of them unit lower triangular and one unit upper triangular.
%   LU factorization without pivoting fails to reveal that such
%   matrices are badly conditioned.
%   See also LUGUI.

s = 10;
L = tril(round(s*randn(n)),-1)+eye(n);
U = triu(round(s*randn(n)),1)+eye(n);
A = L*U;
