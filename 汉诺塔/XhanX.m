function XhanX(n,a,c,t)
%调用格式XhanX(n,a,c,t)
%n为铁块个数，开始都叠在a号杆上，
%要把他们移到c号杆上去，a、c=1,2,3；
%t为时间(帧数)大于0，建议小于30，如果n大于5，t小于15，n大于8，t小于3
%如果t取0则为游戏模式！游戏模式！游戏模式！
%by 桀作 2013.7
global var A cd N h h1 v T X
%A由每个铁块的结构体组成的数组
%cd（i,:）第i根杆子上的铁块序号的数组
%var（i）第i根杆子上的铁块数
%h为铁块的总高
%h1每块的高
%v（i）第i跟杆子的中心位置
%N=n；
%T为时间,帧数。如果T取0，则为游戏模式
%X为字符串
try
var(a)=n;var(c)=0;var(6-a-c)=0;
h=100;h1=100/n;d=1;v(1)=2+n;v(2)=(2+n)*2;v(3)=(2+n)*3;cd(a,:)=1:n;N=n;T=t;
for i=1:n
A(i).xingzhuang1=[v(a)-(n+2-i)/2,v(a)+(n+2-i)/2,v(a)+(n+2-i)/2,v(a)-(n+2-i)/2];
A(i).xingzhuang2=[0,0,h1,h1];
A(i).gaodu=i;
end
figure;
if T==0 
    X=['请将',num2str(a),'上的所有铁块移到',num2str(c),'杆子上去。'];T=6;g();Xhanc(c); 
else
    X=['自动模式'];g();pause(1);Xhan(n,a,c);
end
 clear global
catch
    clear global
end




function Xhanc(c)
%游戏模式
try
global N var cd A
while 1
while 1
k=waitforbuttonpress;
p1=get(gca, 'currentpoint');
q1=ceil((p1(1,1)-N/2-1)/(N+2));
if q1<=3&q1>=1&var(q1)~=0
    A(cd(q1,var(q1))).gaodu=var(q1)+1;
    g();
    break;
end
end
while 1
k=waitforbuttonpress;
p2=get(gca, 'currentpoint');
q2=ceil((p2(1,1)-N/2-1)/(N+2));
if q2<=3 & q2>=1
    break;
end
end
if q1==q2
    A(cd(q1,var(q1))).gaodu=var(q1);
    g();
    continue;
end
if var(q2)>0 & cd(q1,var(q1))<cd(q2,var(q2))
 A(cd(q1,var(q1))).gaodu=var(q1);
 g();
 continue;
end
f(q1,q2);
if var(c)==N
    xlabel('成功通关！！！','fontsize',18,'color','r');
    return;
end
end
catch
    clear global
end



function Xhan(n,a,c)
%核心算法，将n个从a移到c上去
if n==1
f(a,c);
else b=6-a-c;
Xhan(n-1,a,b)
f(a,c);
Xhan(n-1,b,c)
end

function f(a,c)
%将a杆上最上方的铁块移到c杆最上方
try
global var cd A v N T
high=ceil(1.5*N)+1;p=ceil(T/2);q=ceil(T);
m=(high-A(cd(a,var(a))).gaodu)/q;
xx=(v(c)-v(a))/p;
var(c)=var(c)+1;n=(high-var(c))/q;
cd(c,var(c))=cd(a,var(a));
for i=1:q
A(cd(a,var(a))).gaodu=A(cd(a,var(a))).gaodu+m;
g();
end
for i=1:p
A(cd(a,var(a))).xingzhuang1=A(cd(a,var(a))).xingzhuang1+xx;
g();
end
for i=1:q;
A(cd(a,var(a))).gaodu=A(cd(a,var(a))).gaodu-n;
g()
end
cd(a,var(a))=0;
var(a)=var(a)-1;
catch
   clear global;
end
function g()  
%画出目前的图形
global T v h h1 N A X
clf
axis([-0.1,4*(N+2),0,2*h])
set(gca,'YColor',[1 1 1],'YTick',[],'XColor',[1 1 1],'XTick',[]);
title('汉诺塔','fontsize',20);
xlabel(X,'fontsize',18,'color','r');
hold on;
plot([0,4*(N+2)],[0,0],'-y','linewidth',10)
for i=1:3
fill([v(i)-0.5,v(i)+0.5,v(i)+0.5,v(i)-0.5],[0,0,1.5*h,1.5*h],'m');
end
for i=1:N
fill(A(i).xingzhuang1,A(i).xingzhuang2+(A(i).gaodu-1)*h1,'c');
end
plot([0,4*(N+2)],[0,0],'-y','linewidth',5)
pause(0.001);
    