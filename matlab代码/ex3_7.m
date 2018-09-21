A=[1,2,3;4,5,6]; B=[7,8,9;10,11,12];
try
   C=A*B;
catch
   C=A.*B;
end
C
lasterr                %显示出错原因
