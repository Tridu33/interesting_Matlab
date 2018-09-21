%	By Philip Torr 2002
%	copyright Microsoft Corp.
%main()
%profile on
m3 = 256;
sse2t = 0;
%method = 5;
% 


if new_random == 0
state_rand = 400;
 randn('state',state_rand)
 rand('state',state_rand)
end

    trans = 0;
      true_epipole = torr_get_right_epipole(true_F,m3);
   
      
for(i = 1:1)
    
    %generate a load of stuffs
    torr_genf;
    
    nX1 = [nx1,ny1, ones(length(x1),1) * m3];
    nX2 = [nx2,ny2, ones(length(x2),1) * m3];
    
    %mine
    %f_torr = estf(nx1,ny1,nx2,ny2, no_matches,m3);
    
    %the F matrix is defined like:
    % (nx2, ny2, m3) f(1 2 3) nx1 
    %                 (4 5 6) ny1  
    %                 (7 8 9) m3
    
    %first try linear method
    method = 3
    
        [nF , nf]= fm_linear(nX1, nX2, eye(3), method);
            %calc noisy epipole
        noisy_epipole = torr_get_right_epipole(nF,m3)
        epipole_distance =  sqrt(norm(true_epipole -noisy_epipole))
    
    
    ne1 = torr_errf2(nf,x1,y1,x2,y2, no_matches, m3);
    
    sne1 = sort(ne1);
%    sse_n = norm(sne1(20:no_matches-20))
    sse_n = norm(sne1)
%    nf'
    
    %   
    method = 5
    
        [nF2 , nf2]= fm_linear(nX1, nX2, eye(3), method);
            %calc noisy epipole
        noisy_epipole2 = torr_get_right_epipole(nF2,m3)
            epipole_distance2 =  sqrt(norm(true_epipole -noisy_epipole2))

    ne2 = torr_errf2(nf2,x1,y1,x2,y2, no_matches, m3);
    
    sne2 = sort(ne2);
%    sse_n2 = norm(sne2(20:no_matches-20))
    sse_n2 = norm(sne2)
%    nRf'
    
    
    
end


if draw_epipole
torr_display_epipoles(nF,nF2,perfect_matches, x1,y1, u1, v1)
end
%profile off
% 
% 
% some crap
% 
% >> XX2 = [x2(1), y2(1), m3]
% 
% XX2 =
% 
%   101.4245 -119.2097  256.0000
% 
% >> XX1 = [x1(1), y1(1), m3]
% 
% XX1 =
% 
%    49.3714 -140.5000  256.0000
% 
% >> 
% 
% 
% 
% 


%        e = fm_error_hs(F, n1, n2, nowarn);

if sse_n2 < sse_n
    disp('Bookstein + Sampson betta')
else
    disp('old betta')
end