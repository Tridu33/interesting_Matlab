function stegano(p,q)
% STEGANO  Investigate steganography in the default image.
% The MATLAB "image" function employs "steganography", hiding 
% images in the low order bits of the data for other images.

persistent imageh cdata bits legend m n 
if nargin == 0 | isempty(cdata)
   shg
   clf
   axes('pos',[.25 .25 .5 .5])
   image
   imageh = get(gca,'child');
   cdata = get(imageh,'cdata')/32;
   axis image
   axis ij
   axis off
   for p = 1:52
      bits(p) = uicontrol('style','push','pos',[100+7*p,50,6,15], ...
      'userdata',p,'callback','stegano(get(gco,''userdata''))');
   end
   uicontrol('style','push','pos',[230,30,20,15],'string','<', ...
      'fontweight','bold','callback','stegano(''<'')')
   uicontrol('style','push','pos',[265,30,20,15],'string','-', ...
      'fontweight','bold','callback','stegano(''-'')')
   uicontrol('style','push','pos',[300,30,20,15],'string','+', ...
      'fontweight','bold','callback','stegano(''+'')')
   uicontrol('style','push','pos',[335,30,20,15],'string','>', ...
      'fontweight','bold','callback','stegano(''>'')')
   legend = uicontrol('style','text','pos',[275,70,30,15],'fontweight','bold');
   uicontrol('style','push','pos',[430,30,40,15],'string','close', ...
      'callback','close(gcf)')
   m = 1;
   n = 5;
end
if nargin == 1
   if p == '<'
      m = m-1; n = n-1;
   elseif p == '-'
      n = n-1;
   elseif p == '+'
      n = n+1;
   elseif p == '>'
      n = n+1; m = m+1;
   elseif p <= (m+n)/2
      d = n-m; m = p; n = m+d;
   else
      d = n-m; n = p; m = n-d;
   end
end
if nargin == 2
   m = p; n = q;
end
m = max(min(m,53),1);
n = max(min(n,52),0);
set(bits([1:m-1 n+1:52]),'background','white')
set(bits(m:n),'background','black')
if n < m, s = ''; elseif n == m, s = int2str(m);
   else, s = [int2str(m) ':' int2str(n)]; end
set(legend,'string',s);
d = n-m+1;
e = min(d,8);
set(imageh,'cdata',mod(floor(2^n*cdata),2^d)/2^(d-e)+1)
colormap(gray(2^e))
