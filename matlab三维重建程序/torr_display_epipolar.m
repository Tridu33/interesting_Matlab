%	By Philip Torr 2002
%	copyright Microsoft Corp.
% so we display an epipolar line from image 1 into image 2
%%%%%%%


function torr_display_epipolar(f,ax_handle2,ax_handle3,m3)

% (x2 y2 m3) F (x1 y1 m3)'
%  (image 2) F ( image 1)'

%while 1
    
    %this takes one image and draws the corresponding epipolar line.
    Fmat = [[f(1) f(2) f(3)]; [f(4) f(5) f(6)];[f(7) f(8) f(9)]];
    
    
    
    [U,S,V] = svd(Fmat);
    S(3,3) = 0;
    F2 = U*S*V';
    
    [v,d] = eig(F2);
    ee = v(:,1);
    %Fmat * ee
    
    

    axes(ax_handle2);
    hold on
    [Xcur,Ycur] = GINPUT;
    n_plots = length(Xcur);
    
    plot(Xcur,Ycur, 'w+','LineWidth',2);
%  plot(matches12(i,1), matches12(i,2), 'b+','LineWidth',2);
    xxx1 = [Xcur,Ycur, ones(n_plots,1) * m3];
    
    % (x2 y2 m3) F (x1 y1 m3)'
%  (image 2) F ( image 1)'

    el2 = F2 * xxx1';
    %is this the wrogn way round>
    el2 = el2';

    
    axes(ax_handle3);
   
    %define two points x1 = 0, x2 = 
    % note x 1 + y 2 + m3 3 = 0
    % y = (-m3 3 - x 1 ) / 2
    
    
    x1 = ones(n_plots,1) * -20000;
%    y1 = - (el2(:,3) * m3) ./el2(:,2);
    y1 = (- (el2(:,3) * m3) - (x1(:) .* el2(:,1))) ./el2(:,2);
    
    x2 = ones(n_plots,1) * 20000;
    y2 = (- (el2(:,3) * m3) - (x2(:) .* el2(:,1))) ./el2(:,2);
    
    
    
    hold on
    a = [x1,x2]';
    b = [ y1,y2 ]';
%    plot(x1,y1, 'g+');
    line(a,b,'Color','r');
    
    hold off
    
    %end