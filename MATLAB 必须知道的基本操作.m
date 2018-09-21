clc;
clear;
%https://blog.csdn.net/sinat_34820292/article/details/77624198 
%MATLAB必须知道的知识

A = [1 2 3 4;5 6 7 8;9 10 11 12];
A(:,2:3)
A(2:end,:)
A([1 3 5; 7 9 10])
A(A>4)
A(find(mod(A,2)==0))
A(:)
reshape(A,4,3)%reshape是按列读取，然后按列摆放
B=[A A]; 
%  A 所有的脚本文件（不带function关键字的m文件）和控制台共有一个作用域，这个变量域一般称之为workspace工作区。
% B 每个函数具有单独的作用域，(有时看到网上的函数文件开头用clear清除数据觉得很外行)
% 注意：不是B是局部变量，A是全局变量的关系，因为函数并没办法直接使用工作区的变量
% 
% rand,mod,round,floor,ceil,mode,plot,solve,dsolve,eval,subs,disp,fprintf,zeros,ones,magic,sort,sortrows,max,min,isempty等
% 
% clear,save,load,clc,tic,toc,close等

%{
对象（结构体），元胞数组等数据类型

A.title=’标题’
A.xlabel=’时间’
A.ylabel=’天气’
A.A = A

c{1} = 1
c{2} = [1 2]
c{3} = 1==1
c{4} = ‘aaa’
%}
% 
% plot,ezplot,title, xlabel, ylabel, axis， hold, grid, subplot, 还可以系统学一下matlab gui, 可以做很多有意思的东西，建模不实用,matlab的gui还支持latex公式语法
%{
数据导入
xlsread
importdata
fopen
ls
xlswrite
load
save
char
%}


% 常用工具箱
% 
% cftool
% wavemenu
% plottools
% guide


网上搜索想要的函数

% 百度搜索你想用matlab实现的功能如：matlab 怎么处理时间
% doc
% help
%{
我的任务总结成五字“需算CDJ”，称为五行，
需：需求分析，财务软件也，属火
算：算法也，数学建模也，属土
C：C#，属木
D：DELPHI，属水
J：JAVA，属金
其中我最少思考的是“算”，又分出五行
金：《数据结构》PDF还要不要复习记忆，是否无用
木：《遗传算法》和《算法艺术》PDF要不要深入研究
水：数学建模的论坛太少了解
火：切割原料问题和背包问题等几个应用数学实例值得研究下
土：MATLAB和不少经济统计软件未会用，甚至包括EXCEL的单变量求解等功能 
%}



