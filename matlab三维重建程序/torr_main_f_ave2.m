%	By Philip Torr 2002
%	copyright Microsoft Corp.
%main()
%profile on
m3 = 256;
sse2t = 0;
best_sse = 10000000000;
best_method = 5;
best_method_array = zeros(4,1);
method = 3;

randn('state',0)
rand('state',0)
    
for(i = 1:1)
    
        %generate a load of stuffs
    torr_genf;
        
        nX1 = [nx1,ny1, ones(length(x1),1) * m3];
        nX2 = [nx2,ny2, ones(length(x2),1) * m3];
   
%mine
%f_torr = estf(nx1,ny1,nx2,ny2, no_matches,m3);

[nF , nf]= fm_linear(nX1, nX2, eye(3), method);

%ne1 = torr_errf2(nf,x1,y1,x2,y2, no_matches, m3);
ne1 = torr_errf_nl_2(nf,nx1,ny1,nx2,ny2, no_matches, m3);


C = eye(3);
C(3,3) = m3;
nF2 = C * nF * C;

 n1  = [x1 y1];
 n2= [x2 y2];
 nowarn = 0;
 
 e = fm_error_hs(nF2, n1, n2, nowarn);

sne1 = sort(ne1);
sse_n = norm(sne1(20:no_matches-20))
end

%profile off









%        e = fm_error_hs(F, n1, n2, nowarn);