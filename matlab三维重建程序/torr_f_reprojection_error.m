%	By Philip Torr 2002
%	copyright Microsoft Corp.
 
   %used for non-linear estimation of reprojection error, of a match constrained by F
   function sq_err =  torr_f_reprojection_error(est_point, nx1,ny1,nx2,ny2,f, m3)
   
   cx1 = est_point(1);
   cy1 = est_point(2);
   cy2 = est_point(3);
   cx2 =  -(f(4) * cx1* cy2 +   f(5) * cy1* cy2+   f(6) * m3* cy2 + f(7) * cx1* m3+   f(8) * cy1* m3+   f(9) * m3* m3);
   cx2 = cx2 / (  f(1) * cx1 +   f(2)* cy1  + f(3) * m3 );
   
   sq_err = (nx1 - cx1)^2 + (nx2 - cx2)^2 + (ny1 - cy1)^2 + (ny2 - cy2)^2;