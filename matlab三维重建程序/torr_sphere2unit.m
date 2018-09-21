%	By Philip Torr 2002
%	copyright Microsoft Corp.
function rot_axis = torr_sphere2unit(srot_axis)

% %convert rot_axis to spherical coords
% sin a sin b
% sin a cos b
% cos a

%undo spherical coordinates
rot_axis(1) = sin(srot_axis(1)) * sin(srot_axis(2));
rot_axis(2) = sin(srot_axis(1)) * cos(srot_axis(2));
rot_axis(3) = cos(srot_axis(1));
rot_axis = rot_axis';
