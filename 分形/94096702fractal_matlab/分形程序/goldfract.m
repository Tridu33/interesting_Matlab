function goldfract(n)
%GOLDFRACT   Golden ratio continued fraction.
%  GOLDFRACT(n) displays n terms.

p = '1';
for k = 1:n
   p = ['1+1/(' p ')'];
end
p

p = 1;
q = 1;
for k = 1:n
   s = p;
   p = p + q;
   q = s;
end
p = sprintf('%d/%d',p,q)

format long
p = eval(p)

format short
err = (1+sqrt(5))/2 - p
