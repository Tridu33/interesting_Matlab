%	By Philip Torr 2002
%	copyright Microsoft Corp.
function f1 = torr_display_structure(X, P1, P2,display_numbers,f1)


if nargin < 4
    display_numbers = 0;
end

if nargin < 5
    f1 = figure
else
    figure(f1)
end


[M,N] = size(X);

if M==4 %then normalize if homogeneous...
    X(1,:) = X(1,:) ./  X(4,:);
    X(2,:) = X(2,:) ./  X(4,:);
    X(3,:) = X(3,:) ./  X(4,:);
    X(4,:) = X(4,:) ./  X(4,:);
end
    
%next we want (for display) to remove points at infinity as they will be difficult to display
%this is done by calculating the centroid of the points and removing ones that are too far away
%relative to the camera baseline
baseline = norm([P2(1,4) P2(2,4) P2(3,4)]);
nearby_index = find(X(3,:) < 40 *  baseline);

plot3(X(1,nearby_index),X(2,nearby_index),X(3,nearby_index),'rs');

% if display_numbers
%     mat_index1 = 1:N;
%     mat_index1 = mat_index1';
%     mat_index = num2str(mat_index1);
%     text(X(1,:),X(2,:),X(3,:),mat_index)
% end
% 
if display_numbers
    mat_index1 = nearby_index;
    mat_index1 = mat_index1';
    mat_index = num2str(mat_index1);
    text(X(1,nearby_index),X(2,nearby_index),X(3,nearby_index),mat_index)
end


hold on
plot3(0,0,0,'gs');
plot3(P2(1,4),P2(2,4),P2(3,4),'gs');
hold off

