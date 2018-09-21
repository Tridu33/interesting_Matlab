function f=ffib(n)
%用于求Fibonacci数列的函数文件
     %f=ffib(n)
%2004年9月30日编
if n>2
   f=ffib(n-1)+ffib(n-2);
else
   f=1;
end
