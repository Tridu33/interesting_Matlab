%	By Philip Torr 2002
%	copyright Microsoft Corp.
% 
% %designed for the good of the world by Philip Torr 
% copyright Philip Torr and Microsoft Corp 2002
% orthogonal regression see
% @article{Torr97c,
%         author="Torr, P. H. S.  and Murray, D. W. ",
%         title="The Development and Comparison of Robust Methods for Estimating the Fundamental Matrix",
%         journal="IJCV",
%         volume = 24,
%         number = 3,
%         pages = {271--300},
%         year=1997
% }
% 

function [vec, error] = torr_ls(D)

try
[U, S, V] = svd(D);

catch
    disp('what happeend?');
end

V;

vec = V(:,length(V));

error = S(length(V),length(V));

%disp('performing least squares')

