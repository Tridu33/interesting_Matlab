%非常漂亮的日历，网上下载的，忘了出处了一个不错的Matlab的gui界面设计实例[转]

function CalendarTable;
% calendar 日历
% Example:
%    CalendarTable;

S=datestr(now);
[y,m,d]=datevec(S);
% d is day
% m is month
% y is year
DD={'Sun','Mon','Tue','Wed','Thu','Fri','Sat'};
close all
figure;
for k=1:7;
   uicontrol(gcf,'style','text',...
       'unit','normalized','position',[0.02+k*0.1,0.55,0.08,0.06],...
       'BackgroundColor',0.6*[1,1,1],'ForegroundColor','b',...
       'String',DD(k),'fontsize',16,'fontname','times new roman');
end
h=1;
ss='b';
qq=eomday(y,m);
for k=1:qq;
   n=datenum(y,m,k);
   [da,w] = weekday(n);
   if k==d;
       ss='r';
   end
   uicontrol(gcf,'style','push',...
       'unit','normalized','position',[0.02+da*0.1,0.55-h*0.08,0.08,0.06],...
       'BackgroundColor',0.6*[1,1,1],'ForegroundColor',ss,...
       'String',num2str(k));
   ss='b';
   if da==7;
       h=h+1;
   end
end
uicontrol(gcf,'style','push',...
   'unit','normalized','position',[0.6,0.66,0.12,0.08],...
   'BackgroundColor',0.6*[1,1,1],'ForegroundColor',ss,...
   'String','clock','fontsize',18,'fontname','times new roman');
Tq=uicontrol(gcf,'style','push',...
   'unit','normalized','position',[0.74,0.66,0.17,0.08],...
   'BackgroundColor',0.6*[1,1,1],'ForegroundColor',[0.1,0.9,0.9],...
   'fontsize',18,'fontname','times new roman');
sq='The calendar';
uicontrol(gcf,'style','push',...
   'unit','normalized','position',[0.14,0.86,0.37,0.08],...
   'BackgroundColor',0.6*[1,1,1],'ForegroundColor',[0.1,0.9,0.9],...
   'fontsize',18,'fontname','times new roman','string',sq);
try
   while 1
       set(Tq,'String',datestr(now,13));
       pause(1);
   end
end