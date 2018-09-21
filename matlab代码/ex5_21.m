subplot(1,2,1);
[X,Y,Z]=peaks(30);
waterfall(X,Y,Z)
xlabel('X-axis'),ylabel('Y-axis'),zlabel('Z-axis');
subplot(1,2,2);
contour3(X,Y,Z,12,'k');     %其中12代表高度的等级数
xlabel('X-axis'),ylabel('Y-axis'),zlabel('Z-axis');
