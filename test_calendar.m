

function test_calendar(year,month)

% 输入年份，月份，打印这个月的月历
run = 0;
ping = 0;
fprintf('\n%s %s %s %s %s %s %s\n',...
    '日','一','二','三','四','五','六');
% 计算从第一年到前一年的闰年和平年的个数
for i =1:year-1
    if (mod(i,4)==0 & mod(i,100)~=0) | mod(i,400)==0
        run = run+1;
    else
        ping = ping+1;
    end
end
% 计算从第一年到当年前一个月的天数
sum = 366*run+365*ping;
for i = 1:month-1
    sum = sum+monthday(year,i);
end
% 获得这个月的天数
n = monthday(year,month);
temp = zeros(n,1);
sum = sum+1;
% 计算这个月第一天是星期几
wkd = mod(sum,7);
for i = 1:n
    temp(wkd+i) = i;
end
l = 1;
m = 1;
% 打印日历
for i = 1:length(temp)
    if temp(i) ==0
        temp2(l,m) = ' ';
        fprintf('   ');
        m = m+1;
    else
        temp2(l,m) = temp(i);
        if temp(i) >= 10
            fprintf('%d ',temp(i));
        else
            fprintf('%d  ',temp(i));
        end
        m = m+1;
    end
    if mod(i,7)==0
        fprintf('\n');
        m = 1;
        l = l+1;
    end
end
fprintf('\n');

% 闰年和平年每月的天数

function out = monthday(year,i)
if mod(year,4)==0 & mod(year,100)~=0 | mod(year,400)==0
    data = [31 29 31 30 31 30 31 31 30 31 30 31];
else
    data = [31 28 31 30 31 30 31 31 30 31 30 31];
end
out = data(i);

 %举例：输入：>> test_calendar(2008,12)返回：
%日 一 二 三 四 五 六
  % 1  2  3  4  5  6 
%7  8  9  10 11 12 13
%14 15 16 17 18 19 20
%21 22 23 24 25 26 27
%28 29 30 31


