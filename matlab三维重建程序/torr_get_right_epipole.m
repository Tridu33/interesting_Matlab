%	By Philip Torr 2002
%	copyright Microsoft Corp.
    % returns epipole such that Fmat1 * epipole = 0


function  epipole = torr_get_right_epipole(Fmat1,m3)

    [v,d] = eig(Fmat1);
    
    dd = [d(1,1)^2, d(2,2)^2, d(3,3)^2];
    [Y Index] = min(dd);
    
    
    epipole = v(:,Index);
    epipole = epipole * (m3/epipole(3));
    %Fmat1 * epipole
    