c=input('ÇëÊäÈëÒ»¸ö×Ö·û','s');
if c>='A' & c<='Z'
   disp(setstr(abs(c)+abs('a')-abs('A')));
elseif c>='a'& c<='z'
    disp(setstr(abs(c)- abs('a')+abs('A')));
elseif c>='0'& c<='9'
    disp(abs(c)-abs('0'));
else
    disp(c);
end
