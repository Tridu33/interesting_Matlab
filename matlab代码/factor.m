function f=factor(n)
if n<=1
   f=1;
else
   f=factor(n-1)*n;    %µÝ¹éµ÷ÓÃÇó(n-1)!
end
