%	By Philip Torr 2002
%	copyright Microsoft Corp.
function [a,b] = torr_unit2sphere(rot_axis)

% %convert rot_axis to spherical coords
% sin a sin b
% sin a cos b
% cos a
rot_axis = rot_axis/norm(rot_axis);

%normalize so second coordinate + ve
%rot_axis = rot_axis * sign(rot_axis(2));

a = acos(rot_axis(3));
%b = atan(rot_axis(1)/rot_axis(2));
b = acos(rot_axis(2)/sin(a));

%need to sort the signs out:
% %there are two solutions for a
% a2 = -a;
% b2 = -b;


if abs(rot_axis(1) - sin(a) * sin(b)) < 0.000001
    return
else
    b = -b;
end

