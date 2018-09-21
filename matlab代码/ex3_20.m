m=input('m='); 
p=1:m; p(1)=0;
for i=2:sqrt(m)
   for j=2*i:i:m
      p(j)=0;
   end
end
n=find(p~=0);
p(n)
