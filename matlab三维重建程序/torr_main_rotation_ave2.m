%	By Philip Torr 2002
%	copyright Microsoft Corp.
%main()
%profile on
m3 = 170;
sse2t = 0;
%method = 5;
% 

state_rand = 400;
 randn('state',state_rand)
 rand('state',state_rand)

    trans = 0;
      true_epipole = torr_get_right_epipole(true_F,m3);
      method
      
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
    
    
    
    if method == 7
        nf = estf(nx1,ny1,nx2,ny2, no_matches,m3);
        nF = reshape(nf,3,3)';
    else
        [nF , nf]= fm_linear(nX1, nX2, eye(3), method);
    end
            %calc noisy epipole
        noisy_epipole = torr_get_right_epipole(nF,m3);
        epipole_distance =  sqrt(norm(true_epipole -noisy_epipole))
    
    
    ne1 = torr_errf2(nf,x1,y1,x2,y2, no_matches, m3);
    
    sne1 = sort(ne1);
    sse_n = norm(sne1(20:no_matches-20))
%    nf'
    
    theta2 = 2 * pi * rand;
    rot2 = [ cos(theta2), sin(theta2); -sin(theta2), cos(theta2)];
    
    theta3 = 2 * pi * rand;
    rot3 = [ cos(theta3), sin(theta3); -sin(theta3), cos(theta3)];
    
    nRxy1 = [nx1 ny1] * rot2 + trans;
    Rxy1 = [x1 y1] * rot2 + trans;
    
    nRxy2 = [nx2 ny2] * rot3 - trans;
    Rxy2 = [x2 y2] * rot3 - trans;
    
    
    nRX1 = [nRxy1(:,1),nRxy1(:,2), ones(length(x1),1) * m3];
    nRX2 = [nRxy2(:,1),nRxy2(:,2), ones(length(x2),1) * m3];
    
    %   
    if method == 7
        nRf = estf(nRxy1(:,1),nRxy1(:,2), nRxy2(:,1),nRxy2(:,2), no_matches,m3);
        nRF = reshape(nf,3,3)';
    else
        [nRF , nRf]= fm_linear(nRX1, nRX2, eye(3), method);
    end
    
    
    Rne1 = torr_errf2(nRf,Rxy1(:,1),Rxy1(:,2), Rxy2(:,1),Rxy2(:,2), no_matches, m3);
    
    sRne1 = sort(Rne1);
    Rsse_n = norm(sRne1(20:no_matches-20))
%    nRf'
    
    
    
    G1 = [rot2' [trans trans]'/m3; 0 0 1];
    G2 = [rot3' [-trans -trans]'/m3; 0 0 1];
    
    nF2 =G2' * nRF * G1
    nf2 = reshape(nF2',9,1);
    nF
    true_F
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