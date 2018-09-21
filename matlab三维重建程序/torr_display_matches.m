%	By Philip Torr 2002
%	copyright Microsoft Corp.

%a function to display the images matches
%matches, figure, display_numbers
function f1 = torr_display_matches(matches,display_numbers,f1)



if nargin < 2
    display_numbers = 0;
end

if nargin < 3
    m1 = max(max(matches));
    m2 = min(min(matches));
    m2 = -m2;
    g = max(m1,m2); 
    f1 = figure
    axis([-g g -g g])	
else
    figure(f1)
    hold on
end

x1 = matches(:,1);
y1 = matches(:,2);
x2 = matches(:,3);
y2 = matches(:,4);

u1 = x2 - x1;
v1 = y2 - y1;



plot (matches(:,1), matches(:,2),'r+');
hold on
plot (matches(:,3), matches(:,4),'r+');
if display_numbers
    mat_index1 = 1:length(matches);
    mat_index1 = mat_index1';
    mat_index = num2str(mat_index1);
    text(matches(:,1), matches(:,2),mat_index)
end

quiver(x1, y1, u1, v1, 0)
hold off
