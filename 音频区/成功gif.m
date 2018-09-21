%%http://blog.csdn.net/flyingworm_eley/article/details/6644977
%%
clear all
clc
x=0:pi/50:2*pi;
y=sin(x);
plot(x,y)
h=line(0,0,'color','r','marker','.','markersize',40);
axesValue=axis;
A(1:length(x))=struct('cdata',[],'colormap',[]);
for jj=1:length(x)
    set(h,'xdata',x(jj),'ydata',y(jj));
    axis(axesValue);
    drawnow
    f=getframe;
    f=frame2im(f);
    [X,map]=rgb2ind(f,256);
    if mod(jj,10)==1
        if jj==1
            imwrite(X,map,'ex_imwrite.gif');
        else
            imwrite(X,map,'ex_imwrite.gif','WriteMode','Append');
        end
    end
end