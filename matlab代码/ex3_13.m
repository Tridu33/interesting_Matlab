for m=1:500
s=0;
for k=1:m/2
if rem(m,k)==0
s=s+k;
end
end
if m==s
    disp(m);
end
end
