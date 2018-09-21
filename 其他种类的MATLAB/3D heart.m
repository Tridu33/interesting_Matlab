

[x,y,z]=meshgrid(linspace(-3,3,120)); 

f=(x.^2+(9*y.^2)./4+z.^2-1).^3-((9*y.^2).*(z.^3))./80-(x.^2).*(z.^3); 

p=patch(isosurface(x,y,z,f,0)); 

set(p,'FaceColor','r') 

grid on 

daspect([1 1 1]) 

view(3) 

camlight('right') 

camlight('left') 

camlight('headlight') 

lighting phong 

xlabel('X') 

ylabel('Y') 

zlabel('Z') 

title('3D Heart')

 