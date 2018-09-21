function y = crypto(x)
% CRYPTO Cryptography example.
% y = crypto(x) converts an ASCII text string into another, coded string.
% The function is its own inverse, so crypto(crypto(x)) gives x back.
% See also: ENCRYPT.

% Use a two-character Hill cipher with arithmetic modulo 97, a prime.
p = 97;

% Choose two characters above ASCII 128 to expand set from 95 to 97.
c1 = char(169);
c2 = char(174);
x(x==c1) = 127;
x(x==c2) = 128;

% Convert to integers mod p.
x = mod(real(x-32),p);

% Reshape into a matrix with 2 rows and floor(length(x)/2) columns.
n = 2*floor(length(x)/2);
X = reshape(x(1:n),2,n/2);

% Encode with matrix multiplication modulo p.
A = [71 2; 2 26];
Y = mod(A*X,p);

% Reshape into a single row.
y = reshape(Y,1,n);

% If length(x) is odd, encode the last character. 
if length(x) > n
   y(n+1) = mod((p-1)*x(n+1),p);
end

% Convert to ASCII characters.
y = char(y+32);
y(y==127) = c1;
y(y==128) = c2;
