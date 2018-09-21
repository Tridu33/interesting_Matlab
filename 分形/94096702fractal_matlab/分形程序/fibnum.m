function f = fibnum(n)
%FIBNUM  Fibonacci number.
%   FIBNUM(n) generates the n-th Fibonacci number.
if n <= 1
   f = 1;
else
   f = fibnum(n-1) + fibnum(n-2);
end
