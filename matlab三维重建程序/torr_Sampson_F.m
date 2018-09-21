%	By Philip Torr 2002
%	copyright Microsoft Corp.
function f_out = torr_Sampson_F(x1,y1,x2,y2, no_matches,m3, D_orig, f)

   grad_i = torr_grad_f(f,x1,y1,x2,y2, no_matches, m3);

   %remove singularities
   grad_i = max(grad_i,0.01);
    %Sampson
    w_ne = sqrt(1 ./grad_i);
    Weights = repmat(w_ne,1,9);
    D = Weights .* D_orig;
    
     f_out = torr_ls(D);
