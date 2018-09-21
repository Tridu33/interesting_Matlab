function dec=trdec(n,b)
ch1='0123456789ABCDEF';    %十六进制的16个符号
k=1;
while n~=0                  %不断除某进制基数取余直到商为0
   p(k)=rem(n,b);
   n=fix(n/b);
   k=k+1;
end
k=k-1;
strdec='';
while k>=1                   %形成某进制数的字符串
   kb=p(k);
   strdec=strcat(strdec,ch1(kb+1:kb+1));
   k=k-1;
end
dec=strdec;
