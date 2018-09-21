function feb
%費根鮑姆現象探討
temp=0;
%準凝聚點數目
n=1;
%畫圖時a的值
avalue=1;
%凝聚點數目
npoint=2;
%凝聚點矩陣
y=[;];
%對比已所有凝聚點也未匹配,是新的凝聚點
newpoint=0;
%記錄凝聚點，並畫圖
p=[;];
%x0起始值
x=0.1;
%入起始值，這裏用a表示
a=1.0;
format short


for a=1:0.01:4
%起始遞歸足夠數量次數    
for loopc=1:20000
    x=a*x*(1-x);
end
%假設己經到達凝聚狀態
y(n,1)=x;
y(n,2)=1;
%在多次遞歸後,把再重覆出現的數記下
for loopc=20001:60000
    x=a*x*(1-x);
%比較資料,是否為新的準凝聚點
    for nn=1:n
%遇到精度問題,現在假設x,y(現在的點和已有的凝聚點相比)的值相差很少,即當作相等
        temp=abs(x-double(y(nn,1)));
        if double(temp)<0.00001
            x=double(y(nn,1));
        end
        if (x==double(y(nn,1)))
            %準凝聚點再次出現,出現次數+1
            y(nn,2)=y(nn,2)+1;
            newpoint=0;
            break;
        else
            %新準凝聚點
           [y_sizex,y_sizey]=size(y);
           newpoint=newpoint+1;
           if newpoint==y_sizex
                y(n+1,1)=x;
                y(n+1,2)=1;
                %新設定值
                n=n+1;newpoint=0;
                break;
           end
       end
    end
end
%-------------------------------------------------
for nn=1:n
        %出現超過10次設為凝聚點
    if y(nn,2)>10
        %交給記錄矩陣
        p(avalue,1)=a;
        p(avalue,npoint)=y(nn,1);
        npoint=npoint+1;
        plot(a,y(nn,1),'.');
        hold on
    end
end

avalue=avalue+1;
n=1;
%凝聚點數目
npoint=2;
%凝聚點矩陣
y=[;];
%對比已有凝聚點也未匹配,是新的凝聚點
newpoint=0;
%x0起始值
x=0.1;
end
%--------------------------------------------------
%結果輸出x最後凝聚點,y為凝聚點及出現次數,p為a值對應的凝聚點
%x
%y
%p











