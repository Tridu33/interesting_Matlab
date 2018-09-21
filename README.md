# Matlab_Notebook


collect(f)     合并符号表达式的同类项 

horner(f)     将一般的符号表达式转换成嵌套形式的符号表达式 

factor(f)     对符号表达式进行因式分解 

expand(f)     对符号表达式进行展开 

simplify(f)  对符号表达式进行化简，它利用各种类型的代数恒等式，包括求和、

积分、三角函数、指数函数以及 Bessel 函数等来化简符号表达式 

simple(f)  对符号表达式尝试多种不同的算法进行化简，以显示长度最短的符号

表达式简化形式 

[r,how]=simple(f)   返回的 r为符号表达式进行化简后的形式， how为所采用的简化方法

 

 

《麓瑜园》<http://lvcha6255.blog.sohu.com/entry/4192252/>   学生MATLAB毕业动画作品 又多又有趣

知乎 奇淫怪技https://www.zhihu.com/question/45621009

 

 

不算是命令吧，一个脑洞很大的英国老师教的一个小script，轻度调教Matlab，打开程序可以显示你想它显示的内容，并且自动把workspace设置到常用路径，这个脚本后来就被大家愉快地玩坏了。 
 首先写一个script，命名为startup.m 
 fprintf里面就是你想显示的内容啦，你写hello world也好，keep calm and zhao lanxiang 也罢，都有一种调教自家Matlab的快感。 
 cd里是你的常用workspace directory 

－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－

%startup.m

fprintf(1,'Hello! This is your beloved Queen MATLAB! \n');

fprintf(1,'Message form start.m\n\n');

fprintf(1,'I would like to torture you even more today-just kidding:)');

fprintf(1,'Reminder:when you add a new function to a tool box, issue command:\n');

fprintf(1,' rehash toolboxcache\n\n');

cd ('～/Documents/MyMath/project');

－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－

然后！把你存放这个脚本的路径加入Matlab搜索路径里！home－set path－add with subfolder！后生切记！

 

 

 

输入 demo。你会得到更多更有趣的东西(ಡωಡ)hiahiahia

 

 

tic toc很实用不过可能没什么趣＠_＠
 凑合当秒表用吧

 

设置断点。在你想要停止的地方，m窗口的最左边，想停的地方点一下，会出现一个红色圆点。程序执行到那就停止了。再点继续运行又继续计算了

pause   可以暂停程序，输入任意键程序继续运行，如果有问题可以ctrl+c/ctrl+break停止！

 

 

**Matlab****自带的有趣指令(**全在MATLAB打开DEMOS下找到M-File Help: matlab\demos就都有了**)** M-File Help: Default Topics是m文件帮助:默认主题

MATLAB中有许多有意思的实例，具体如下，运行的时候只要将“：”前面的代码复制到MATLAB 命令窗口中就可以了，随之会出现各种各样的演示实例，很有意思哦。
 **◆** **平面与立体绘图**
 graf2d ：XY平面绘图（火柴棒） 
 graf2（d2 ：XYZ立体绘图（切片） 
 hndlgraf ：平面显示线型处理窗口及命令演示 
 hndlaxis ：平面显示处理窗口及命令演示 
 graf3d ：立体显示处理窗口及命令演示 
                                                   **◆** **复杂函数的三维绘图** 
 cplxdemo ：复杂的XYZ立体图形 
    **◆** **等高线绘制**
 quivdemo ：等高线箭头显示 
 **◆** **动画** 
 lorenz ： Lorenz吸引子动画显示 
    **◆** **电影**
 vibes ： L-形薄膜振动 
    **◆ Fourier****变换**
 sshow sunspots ：太阳黑点数据的傅里叶分析 
 fftdemo ：分析噪声序列中两组数据的相关度
 **◆** **数据拟合** 
 sshow fitdemo ：显示非线性数据拟合过程 
 census ：预测世界人口 
 spline2d ：样条拟合 

 **◆** **稀疏矩阵** 
 sshow sparsity ：降阶 
 **◆** **游戏**
 xpbombs ：仿Windows系统自带的扫雷游戏 
 life ：生命发展游戏 
    **◆** **三维效果图** 
 klein1 ：肤色三维效果图 
 tori4 ：四个首尾相接的圆环 
 spharm2 ： 球形和声
 cruller ：类似油饼的东西
 xpklein ： Klein瓶 bottle 
 modes ： L-形薄膜的12中模态 
 logo ：MATLAB的Logo 
 xpquad ：不同比例的巴尔体超四方体
 truss ：二维桁架的12个模模态 
 travel ：旅行商问题动画演示 
 wrldtrv ：在地球仪上演示两地间的飞行线路 
 makevase ：通过点击鼠标来制作花瓶 
 xpsound ：声音样本分析 
 funfuns ：综合了找零点，最小化和单输入函数积分功能 
 sshow e2pi ： e^pi或者pi^e 
 quake ：地震波可视化 
 penny ：便士可视化 
 imageext ：改变图像的映**色 
 earthmap ：地球仪 
    **◆** **优化工具箱** 
 bandem ：香蕉最优化展示 expo-style banana optimization 
 sshow filtdem ：滤波效果演示 filter effect demo 
 sshow filtdem2 ：滤波设计演示 filter design demo 
 cztdemo ： FFT和CZT (两种不同类型的Z-变换算法) 
 phone ：演示电话通声音的时间与频率的关系
 sigdemo1 ：离散信号的时频图，可用鼠标设置 
 sigdemo2 ：连续信号的时频图，可用鼠标设置
 filtdemo ：低通滤波器的交互式设计
 moddemo ：声音信号的调制 
 sosdemo ：数字滤波器的切片图 
 **◆** **神经网络工具箱** 
 neural ：神经网络模块组
 firdemo ：二维FIR滤波器
 nlfdemo ：非线性滤波器 
 dctdemo ：DCT演示 
 mlpdm1 ：利用多层感知器神经网络拟合曲线动画 
 mlpdm2 ：利用多层感知器神经网络进行XOR问题运算 
 **◆** **模糊逻辑工具箱** 
 invkine ：运动逆问题 
 juggler ：跳球戏法
 fcmdemo ： FC***cp ： 类似倒立摆动画 
 slcp1 ：类似倒立摆动画cart and a varying pole 
 slcpp1 ：类似倒立摆动画，有两个摆，一个可以变化 
 sltbu ：卡车支援 
 slbb ：类似于翘翘板 

=============================================

小M，你这么能耐，你麻麻知道吗^@^

 

    lhttp://www.ilovematlab.cn/thread-202632-1-1.htmlmatlab如何保存运行程序时出现的动画

http://blog.csdn.net/zy122121cs/article/details/49761307Matlab中image、imagesc和imshow函数用法解析

\http://jingyan.baidu.com/article/a378c960a47c24b3282830b7.html如何利用matlab做gif格式的动画？

 MATLAB 动画<http://jingyan.baidu.com/article/b2c186c8ebee13c46ef6ffb9.html>

<http://jingyan.baidu.com/article/54b6b9c0915f262d583b4792.html>

<http://jingyan.baidu.com/article/a378c960a47c24b3282830b7.html>

<http://www.ilovematlab.cn/thread-44621-1-1.html>

<http://www.cnblogs.com/bacazy/archive/2012/12/15/2819172.html>

<http://www.cxymxz.com/code/Matlab_Animated_GIF.aspx>

<http://blog.sina.com.cn/s/blog_6e7e94bc0100mg0a.html>

<https://wenku.baidu.com/view/e0232d1eb7360b4c2e3f64dd.html>

<http://blog.sciencenet.cn/blog-412191-598966.html>

<http://jingyan.baidu.com/article/2fb0ba4055cf5800f3ec5f54.html>

MATLAB图形处理

<https://wenku.baidu.com/view/1906afde6f1aff00bed51e1c.html>工具箱

<https://wenku.baidu.com/view/e3f59ec39ec3d5bbfd0a74f0.html>

<http://blog.sina.com.cn/s/blog_877232310100tdwk.html>

 

http://www.cnblogs.com/lyfruit/archive/2013/01/13/2858952.htmlpretty(f)     将符号表达式化简成与高等数学课本上显示符号表达式形式类似 











