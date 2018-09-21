%	By Philip Torr 2002
%	copyright Microsoft Corp.
%this function allows for self calibration, it implements the Sturm method given in CVPR 2001

%following the steps of Sturm, first provide an f and CC
%CC is an estimate of the self calibration parameters other than the focal length

% 
% CC = [aspect_ratio * est_foc, 0 , pp_x;
%     0,  est_foc , pp_y;
%     0, 0, 1/f_est]
% 
% where est_foc is the estimate of the focal length
% 
% G ~ C' F C

%to get to the focal length we solve
% G ~ diag (1,1,f) E diag (1,1,f)



%how far is the focal length from our initial estimate : 1/CC(3,3)   ?

% well note the focal length we have calculated here is relative to our initial guess
%therefore the true focal length is  1/CC(3,3) * focal_length
% is we are a factor 5 out then we should start to worry

function [focal_length, E, CC_out] = torr_self_calib_f(F,CC)


temp_foc = CC(3,3);
CC(3,3) = 1;

if nargin < 2
    G = F / norm(F);
    CC = diag(ones(3,1),0);
else
    %step 3 
    G = CC' * F * CC;
    G = G / norm(G);
end

[U,S,V] = svd(G);

if abs(S(3,3)) > 0.001
    error('F must be rank 2 to self calibrate');
end

%next construct the quadratic equation of Sturm
% c1 f^4 + c2 f^2 + c3 = 0

a = S(1,1)^2;
b = S(2,2)^2;


c1 = a * (1 - U(3,1)^2) * (1 - V(3,1)^2) - b * (1 - U(3,2)^2) * (1 - V(3,2)^2);
c2 = a *( U(3,1)^2 + V(3,1)^2 - 2 * U(3,1)^2 * V(3,1)^2) - b * (U(3,2)^2 + V(3,2)^2 - 2 * U(3,2)^2 * V(3,2)^2);
c3 = a * U(3,1)^2 * V(3,1)^2 - b * U(3,2)^2 * V(3,2)^2;


temp = sqrt(c2^2 - 4 * c1 * c3);


%first need to check, have the equations degenerated to a linear, i.e is c1 small
if (c1^2/(c2^2 + c3^2)) < 0.001 %then linear
    foc1 = -(U(3,2) * V(3,1) * (S(1,1) * U(3,1) * V(3,1) + S(2,2) * U(3,2) * V(3,2))) ...
        /(S(1,1) * U(3,1) * U(3,2) * (1 - V(3,1)^2) +  (S(2,2) * V(3,1) * V(3,2) * (1 - U(3,2)^2) ));
    foc2 = -(V(3,2) * U(3,1) * (S(1,1) * U(3,1) * V(3,1) + S(2,2) * U(3,2) * V(3,2))  ) ...
        /(S(1,1) * V(3,1) * V(3,2) * (1 - U(3,1)^2) +  (S(2,2) * U(3,1) * U(3,2) * (1 - V(3,2)^2) ));
else
    foc1 = sqrt((-c2 + temp)/(2 * c1));
    foc2 = sqrt((-c2 - temp)/(2 * c1));
end


%we now have two solutions we need to eliminate one. To do this we resort to the linear equations,
%simply multiply the two linear equations together and take the minimum absolute value.


alg1 = abs( ...
    foc1^2 *  (S(1,1) * U(3,1) * U(3,2) * (1 - V(3,1)^2) +  (S(2,2) * V(3,1) * V(3,2) * (1 - U(3,2)^2) ))...
    + U(3,2) * V(3,1) * (S(1,1) * U(3,1) * V(3,1) + S(2,2) * U(3,2) * V(3,2))  );

alg2 = abs( ...
    foc1^2 *  (S(1,1) * V(3,1) * V(3,2) * (1 - U(3,1)^2) +  (S(2,2) * U(3,1) * U(3,2) * (1 - V(3,2)^2) ))...
    + V(3,2) * U(3,1) * (S(1,1) * U(3,1) * V(3,1) + S(2,2) * U(3,2) * V(3,2))  );


alg_foc1 = alg1 * alg2;



alg1 = abs( ...
    foc1^2 *  (S(1,1) * U(3,1) * U(3,2) * (1 - V(3,1)^2) +  (S(2,2) * V(3,1) * V(3,2) * (1 - U(3,2)^2) ))...
    + U(3,2) * V(3,1) * (S(1,1) * U(3,1) * V(3,1) + S(2,2) * U(3,2) * V(3,2))  );

alg2 = abs( ...
    foc2^2 *  (S(1,1) * V(3,1) * V(3,2) * (1 - U(3,1)^2) +  (S(2,2) * U(3,1) * U(3,2) * (1 - V(3,2)^2) ))...
    + V(3,2) * U(3,1) * (S(1,1) * U(3,1) * V(3,1) + S(2,2) * U(3,2) * V(3,2))  );




alg_foc2 = alg1 * alg2;

if ~isreal(foc1)
    focal_length = foc2;
else
    if ~isreal(foc2)
        focal_length = foc1;
    end
end




if isreal(foc1) & isreal(foc2)
    
    if (alg_foc1 < alg_foc2)
        focal_length = foc1;
    else
        focal_length = foc2;
    end
end


%how far is the focal length from our initial estimate : 1/CC(3,3)   ?

% well note the focal length we have calculated here is relative to our initial guess
%therefore the true focal length is  1/CC(3,3) * focal_length
% is we are a factor of 5 out then we should start to worry
if (~isreal(foc1) & ~isreal(foc2)) | (abs(focal_length ) > 5)| (abs(focal_length) < 0.2)
    focal_length
    focal_length = 1;
    disp('either bad F or needs a stronger calibration method');
    disp('ooo vicar big fat focal length setting it to original guess');
end
    

Cf = [1 0 0; 0 1 0; 0 0 1/focal_length];
CC = (Cf * CC);

%now we need to get to the essential matrix which is C^t F C = E

E = CC' * F * CC;

%now remove estimate of the focal length effect
focal_length = 1/CC(3,3);
focal_length
CC_out = CC;

 
[U,S,V] = svd(E);
%note that there is a one p[arameter family of SVD's for E

if abs(S(3,3)) > 0.00001
    error('E must be rank 2 to self calibrate');
end

% if abs(S(1,1) - S(2,2)) > 0.00001
%     S
% %    error('E must have two equal singular values');
% end

%this a problem not pointed out in the Sturm paper, the essential matrix produced might have funny singular values
%fix the bugga to have equal singular values:

S(3,3) = 0;
S(1,1) = S(2,2);
E = U*S*V';
