function y = ffttx(x)
%FFTTX  Textbook Fast Finite Fourier Transform.
%    FFTTX(X) computes the same finite Fourier transform as FFT(X).
%    The code uses a recursive divide and conquer algorithm for
%    even order and matrix-vector multiplication for odd order.
%    If length(X) is m*p where m is odd and p is a power of 2, the
%    computational complexity of this approach is O(m^2)*O(p*log2(p)).

x = x(:);
n = length(x);
omega = exp(-2*pi*i/n);

if rem(n,2) == 0
   % Recursive divide and conquer
   k = (0:n/2-1)';
   w = omega .^ k;
   u = ffttx(x(1:2:n-1));
   v = w.*ffttx(x(2:2:n));
   y = [u+v; u-v];
else
   % The Fourier matrix.
   j = 0:n-1;
   k = j';
   F = omega .^ (k*j);
   y = F*x;
end
