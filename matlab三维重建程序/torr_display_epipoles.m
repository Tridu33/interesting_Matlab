%	By Philip Torr 2002
%	copyright Microsoft Corp.
% so we display an epipolar line in an image 


function torr_display_epipoles(Fmat1,matches, m3)

x1 = matches(:,1);
y1 = matches(:,2);
u1 = matches(:,3) - x1;
v1 = matches(:,4) - y1;


if nargin < 7
    m3 = 256
end

% (x2 y2 m3) F (x1 y1 m3)'
%  (image 2) F ( image 1)'

f1 = figure
m1 = max(max(matches));
m2 = min(min(matches));
m2 = -m2;
g = max(m1,m2);

axis([-g g -g g])	
hold on

    plot (matches(:,1), matches(:,2),'r+')
    plot (matches(:,3), matches(:,4),'r+')

quiver(x1, y1, u1, v1, 0)   

hold off

f2 = figure
m1 = max(max(matches));
m2 = min(min(matches));
m2 = -m2;
g = max(m1,m2);

axis([-g g -g g])	
hold on

    plot (matches(:,1), matches(:,2),'r+')
    plot (matches(:,3), matches(:,4),'r+')

quiver(x1, y1, u1, v1, 0)   

hold off

button = 1;

while ~isempty(button)
    
    %this takes one image and draws the corresponding epipolar line.
    %     Fmat = [[f(1) f(2) f(3)]; [f(4) f(5) f(6)];[f(7) f(8) f(9)]]
    %     
    
    
    figure(f1);
    %     
    %     [U,S,V] = svd(Fmat);
    %     S(3,3) = 0;
    %     F2 = U*S*V';
    
    %     [v,d] = eig(Fmat1);
    %     epipole = v(:,3);
    %     epipole = epipole * (m3/epipole(3);
    %     %Fmat * ee
    %     
    
    
    hold on
    [Xcur,Ycur,button] = GINPUT(1);
    plot(Xcur,Ycur, 'g+');
    
    xxx1 = [Xcur,Ycur, 256.0];
    
    % (x2 y2 m3) F (x1 y1 m3)'
    %  (image 2) F ( image 1)'
    
    el2 = Fmat1 * xxx1';
    
    
    figure(f2)
    
    %define two points x1 = 0, x2 = 
    % note x 1 + y 2 + m3 3 = 0
    % y = (-m3 3 - x 1 ) / 2
    
    nr = 512;
    nc = 512;
    
    x1 = -100000;
    %    y1 = - el2(3) * 256/el2(2);
    y1 =( -x1 * el2(1) - el2(3) * 256)/el2(2);
    
    x2 = nr;
    y2 = (- el2(3) * 256 - x2 * el2(1))/el2(2);
    
    
    
    hold on
    a = [x1,x2];
        
    figure(f1);
    b = [ y1,y2 ];
%    plot(x1,y1, 'g+');
    plot(Xcur,Ycur, 'gs');
        
    figure(f2);
    line(a,b,'Color','r');
    
  
    
end

% 
% function g =  display_mat(matches, x1,y1, u1, v1)
%    
%    m1 = max(max(matches));
%    m2 = min(min(matches));
%    m2 = -m2;
%    g = max(m1,m2);
%    
%    axis([-g g -g g])	
% 	hold on
%  
% 	for(i = 1:length(x1))   
%    	plot (matches(i,1), matches(i,2),'r+')
%    	plot (matches(i,3), matches(i,4),'r+')
%    end
% 
% 	quiver(x1, y1, u1, v1, 0)   
% 
% 	hold off