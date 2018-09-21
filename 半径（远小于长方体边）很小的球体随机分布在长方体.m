v=[0 0 0;0 50 0;30 50 0;30 0 0;0 0 40;0 50 40;30 50 40;30 0 40];

%you may change 30 40 50 with your w, l , h

f= [1 2 3 4;2 6 7 3;4 3 7 8;1 5 8 4;1 2 6 5;5 6 7 8];

patch('Faces',f,'Vertices',v,'FaceColor','w');

x=2 + (30-2).*rand(1,20);

y=2 + (50-2).*rand(1,20);

z=2 + (40-2).*rand(1,20);

a=0:pi/100:2*pi;

b=-pi:pi/100:pi;

[a,b]=meshgrid(a,b);

for i=1:20

    x1=x(i)+2*sin(b).*cos(a);

    y1=y(i)+2*sin(b).*sin(a);

    z1=z(i)+2*cos(b);

    hold on

mesh(x1,y1,z1);

end

view(30,30)

axis equal

alpha(0.5)