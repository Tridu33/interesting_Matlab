%	By Philip Torr 2002
%	copyright Microsoft Corp.
function f = torr_estf_bookstein(x1,y1,x2,y2, no_matches,m3)

   D(:,1) = x1(:).* x2(:);
   D(:,2) = y1(:).* x2(:);
   D(:,3) = m3* x2(:);
   
   D(:,4) = x1(:).* y2(:);
   D(:,5) = y1(:).* y2(:);
   D(:,6) = m3* y2(:);
   
   D(:,7) = x1(:).* m3;
   D(:,8) = y1(:).* m3;
   D(:,9) = m3* m3;
   
   
    D_orig  = D;        
    temp = D(:,3);
    D(:,3) = D(:,5);
    D(:,5) = temp;
    M = D' * D;
    M11 = M(1:4,1:4);
    M12 = M(1:4,5:9); %4 x 5
    M22 = M(5:9,5:9);
    M112 = M11 - M12 * inv(M22) * M12';
    f11 = torr_ls(M112);
    f12 = - f11' * M12 * inv(M22);
    f = [f11(1), f11(2), f12(1),f11(4), f11(3), f12(2),f12(3), f12(4), f12(5)]';