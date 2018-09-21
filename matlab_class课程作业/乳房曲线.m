[X, Y] = meshgrid(0.01:0.01:1, 0.01:0.01:1); 
Zfun =@(x,y)12.5*x.*log10(x).*y.*(y-1)+exp(-((25 ... 
*x - 25/exp(1)).^2+(25*y-25/2).^2).^3)./25; 
Z = Zfun(X,Y); 
figure; 
surf(Y,Z,X,'FaceColor',[1 0.75 0.65],'linestyle','none'); 
hold on 
surf(Y+0.98,Z,X,'FaceColor',[1 0.75 0.65],'linestyle','none'); 
axis equal; 
view([116 30]); 
camlight; 
lighting phong; % 设置光照和光照模式