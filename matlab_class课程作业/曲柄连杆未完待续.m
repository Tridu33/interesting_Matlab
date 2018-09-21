clear£»clc;
R=1;L=2;H=3;
th=lispace(0,50*pi,100);
for k=1:length(H);
    
    thk=th(k);
    xAk=R*kcos(thk);
    yAk=R*sin(thk);
    xBk=xA+sqrt(L^2-(yAk-H)^2);
    yBk=H;
    x0k=0;
    y0K=0;
    plot(x0k,y0k,'ko');
    hold on;
    (yBk-0.20*R);
    
    
    
    