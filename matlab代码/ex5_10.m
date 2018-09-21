%CREATE THE X and Y SHAPE DATA
x_square=[-3,3,3,-3,-3];
y_square=[-3,-3,3,3,-3];
x_circle=3*cos([0:10:360]*pi/180);
y_circle=3*sin([0:10:360]*pi/180);
x_triangle=3*cos([90,210,330,90]*pi/180);
y_triangle=3*sin([90,210,330,90]*pi/180);
%PLOT THE SQUARE IN THE UPPER LEFT PANE
subplot(2,2,1)
plot(x_square,y_square,'-r');
axis([-4,4,-4,4]);axis('equal');
title('Square');
%PLOT THE CIRCLE IN THE UPPER RIGHT PANE
subplot(2,2,2)
plot(x_circle,y_circle,'--k');
axis([-4,4,-4,4]);axis('equal');
title('Circle');
%PLOT THE TRIANGLE IN THE LOWER LEFT PANE
subplot(2,2,3)
plot(x_triangle,y_triangle,':b');
axis([-4,4,-4,4]);axis('equal');
title('Triangle');
%PLOT THE COMBINATION PLOT IN THE LOWER RIGHT PANE
subplot(2,2,4)
plot(x_square,y_square,'-r');
hold on
plot(x_circle,y_circle,'--k');
plot(x_triangle,y_triangle,':b');
axis([-4,4,-4,4]);axis('equal');
title('Combination Plot');
