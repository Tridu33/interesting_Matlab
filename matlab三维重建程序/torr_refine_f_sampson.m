%	By Philip Torr 2002
%	copyright Microsoft Corp.

function f = torr_refine_f_sampson(x1,y1,x2,y2, no_matches,m3,new_f,D_orig)

err_f = torr_errf2(new_f,x1,y1,x2,y2,no_matches, m3);
sse_f = norm(err_f);
new_ssef = sse_f *0.998;
iter = 0;
%keep going whilst still 0.1% change
%while (sse_f - new_ssef )/sse_f >0.001

if nargin < 9
    max_iter = 5;
end
f = new_f;
for i = 1:max_iter
%  %   sse_f = new_ssef
%     f = new_f;
%     iter = iter + 1;
%     new_f = torr_Sampson_F(x1,y1,x2,y2, no_matches,m3, D_orig, f);
% %    new_err_f = torr_errf2(f,x1,y1,x2,y2,no_matches, m3);
%  %   new_ssef = norm(new_err_f)

f = new_f;
new_f = torr_Sampson_F(x1,y1,x2,y2, no_matches,m3, D_orig, f);
% if ( norm(new_f-f) < 0.0000001) 
%     i = max_iter
% end
    
    
end

f = f/norm(f);