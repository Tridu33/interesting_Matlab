%	By Philip Torr 2002
%	copyright Microsoft Corp.
%makes a super quick fit (Torr trick of the trade...)
%example given two points we can determine a quick fit to a line as


% det [i  j  k ]
%     [x  y  m3]
%     [x' y' m3]
%     
%     where the coefficients of i,j,k are the coefficients of the line

%this result generalizes to any dimension allowing for quick fitting of minimal sets without SVD.

%for Matlab there is no gain over SVD, but there might be for C++


function result = torr_quick_fit(M)


nc = length(M);
normM = norm(M);

% if (nr ~= nc-1)
%     error('wrong matrix size in torr_quick_fit');
% end

for i = 1:nc
    A = M(:, [1:i-1 i+1:nc])/normM;
    result(i) = (-1)^(i+1) * det(A);
end


result = result'/norm(result);
    
    
    
