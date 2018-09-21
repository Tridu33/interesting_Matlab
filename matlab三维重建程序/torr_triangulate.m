%	By Philip Torr 2002
%	copyright Microsoft Corp.
%this function calculates the set of 3D points given matches and two projection matrices
%for this method to work best the matches must be corrected to lie on the epipolar lines

%P-i ith row of the P matrix then
%constraints are of the form  x p_3^t - p_1 & y p_3^t - p_2

function X = torr_triangulate(matches, m3, P1, P2)

%first establish the 4 x 4 matrix J such that J^X = 0
[nr no_matches] = size(matches);

x1 = matches(:,1)/m3;
y1 = matches(:,2)/m3;
x2 = matches(:,3)/m3;
y2 = matches(:,4)/m3;

for i = 1:nr

    J(1,1) = P1(3,1) * x1(i) - P1(1,1);
    J(1,2) = P1(3,2) * x1(i) - P1(1,2);
    J(1,3) = P1(3,3) * x1(i) - P1(1,3);
    J(1,4) = P1(3,4) * x1(i) - P1(1,4);
    
    J(2,1) = P1(3,1) * y1(i) - P1(2,1);
    J(2,2) = P1(3,2) * y1(i) - P1(2,2);
    J(2,3) = P1(3,3) * y1(i) - P1(2,3);
    J(2,4) = P1(3,4) * y1(i) - P1(2,4);
    
    J(3,1) = P2(3,1) * x2(i) - P2(1,1);
    J(3,2) = P2(3,2) * x2(i) - P2(1,2);
    J(3,3) = P2(3,3) * x2(i) - P2(1,3);
    J(3,4) = P2(3,4) * x2(i) - P2(1,4);
    
    J(4,1) = P2(3,1) * y2(i) - P2(2,1);
    J(4,2) = P2(3,2) * y2(i) - P2(2,2);
    J(4,3) = P2(3,3) * y2(i) - P2(2,3);
    J(4,4) = P2(3,4) * y2(i) - P2(2,4);
    
    X(:,i) = torr_ls(J);
end

%at the moment this is unnormalized so that chierality can be determined