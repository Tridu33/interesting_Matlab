%	By Philip Torr 2002
%	copyright Microsoft Corp.
%this is code to remove outliers via chieral constraint


function inlier_index = torr_robust_chieral(X,P1,P2)

%next reproject and compare with the images
%the chieral constraint is sign(det M) * sign (third homog coord of reprojected image) * sign (fourth homog coord X)
% to make sure we dont get any outliers we average the inequalities over all the points, ones with a bad sign
% can later be removed as outleirs.
%we want chieral for both cameras to be positive

ax1 = P1 * X;

bx1 = P2 * X;

chieral = (sign(ax1(3,:) ) .* sign (X(4,:))) +  (sign(bx1(3,:) ) .* sign (X(4,:)));

inlier_index = find(chieral == 2);

