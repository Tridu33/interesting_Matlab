%*************************************************
%S函数timesn.m，其输出是输入的n倍
%*************************************************
function [sys,x0,str,ts]=timesn(t,x,u,flag,n)
switch flag,
case 0                            %初始化
[sys,x0,str,ts]=mdlInitializeSizes;
case 3                            %计算输出量
sys=mdlOutputs(t,x,u,n);
case {1,2,4,9}                     %未使用的flag 值
sys=[];
otherwise                         %出错处理
error(['Unhandle flag=',num2str(flag)]);
end
%*************************************************
%mdlInitializeSizes：当flag为0 时进行整个系统的初始化
%*************************************************
function [sys,x0,str,ts]=mdlInitializeSizes(T)
%调用函数simsizes以创建结构体sizes
sizes=simsizes;
%用初始化信息填充结构体sizes
sizes.NumContStates=0;        %无连续状态
sizes.NumDiscStates=0;        %无离散状态
sizes.NumOutputs=1;          %有一个输出量
sizes.NumInputs=1;            %有一个输入信号
sizes.DirFeedthrough=1;        %输出量中含有输入量
sizes.NumSampleTimes=1;      %单个采样周期
%根据上面的设置设定系统初始化参数
sys=simsizes(sizes);
%给其他返回参数赋值。
x0=[0;0];                    %设置初始状态为零状态
str=[];                       %将str变量设置为空字符串
ts=[-1,0];                     %假定继承输入信号的采样周期
%初始化子程序结束
%*************************************************
%mdlOutputs：当flag值为3时，计算输出量
%*************************************************
function sys=mdlOutput(t,x,u,n)
sys=n*u;
%输出量计算子程序结束。
