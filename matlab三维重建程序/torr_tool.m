%	By Philip Torr 2002
%	copyright Microsoft Corp.
% 
% %designed for the good of the world by Philip Torr based on ideas contained in 
% copyright Philip Torr and Microsoft Corp 2002
% 
% @inproceedings{Torr93b,
%         author = "Torr, P. H. S.  and Murray, D. W.",
%         title  = "Outlier Detection and Motion Segmentation",
%         booktitle = "Sensor Fusion VI",
%         editor = "Schenker, P. S.",
%         publisher = "SPIE volume 2059",
%         note = "Boston",
% 	pages = {432-443},
%         year = 1993 }
% 
%     
% @phdthesis{Torr:thesis,
%         author="Torr, P. H. S.",
%         title="Outlier Detection and Motion Segmentation",
%         school=" Dept. of  Engineering Science, University of Oxford",
%         year=1995}
% 
% @inproceedings{Beardsley96a,
%          author="Beardsley, P. and Torr, P. H. S. and Zisserman, A.",
%          title="{3D} Model Aquisition from Extended Image Sequences",
%          booktitle=eccv4.2,
%         editor = "Buxton, B. and Cipolla R.",
%        publisher = "Springer--Verlag",
%          pages={683--695},
%          year=1996}
% 
% 
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
% 
% 
% 
% @article{Torr99c,
%         author = "Torr, P. H. S.   and Zisserman, A",
%         title ="MLESAC: A New Robust Estimator with Application to Estimating Image Geometry ",
%         journal = "CVIU",
%         Volume = {78},
%         number = 1,
%         pages = {138-156},
%         year = 2000}
% 
% %MAPSAC is the Bayesian version of MLESAC, and it is easier to pronounce!
% it is described in:
% 
% @article{Torr02d,
%         author = "Torr, P. H. S.",
%         title ="Bayesian Model Estimation and  Selection for Epipolar Geometry and
% Generic Manifold Fitting",
%         journal = "IJCV",
%         Volume = {?},
%         number = ?,
%         pages = {?},
%         url = "http://research.microsoft.com/~philtorr/",
%         year = 2002}
% 



function varargout = torr_tool(varargin)
% TORR_TOOL Application M-file for torr_tool.fig
%    FIG = TORR_TOOL launch torr_tool GUI.
%    TORR_TOOL('callback_name', ...) invoke the named callback.

% Last Modified by GUIDE v2.0 21-May-2002 17:58:20




if nargin == 0  % LAUNCH GUI
    
    fig = openfig(mfilename,'reuse');
    
    % Use system color scheme for figure:
    set(fig,'Color',get(0,'defaultUicontrolBackgroundColor'));
    
    % Generate a structure of handles to pass to callbacks, and store it. 
    handles = guihandles(fig);
    
    
    %phils atuff added, initialization
    %corner parameters
    handles.n_corners = 2000; %max no of corners permitted/requested
    
    handles.n_corners1 = 0; %the actual number detected
    handles.n_corners2 = 0; 
    
    handles.corner_sigma = 1.0;
    handles.corner_width = 3;
    
    
    %matchin parameters
    handles.max_disparity = 50;
    handles.match_half_size = 3;
    
    
    %F parameters:
    handles.no_samp = 500; % no of samples in the mapsac algorithm
    handles.f_threshold = 6.0; % f_threshold in the mapsac algorithm
    
    %calibration matrix 
    handles.focal_length = 3; %first guess
    handles.aspect_ratio = 1;
    handles.ppx =  0;
    handles.ppy =  0;
    %work out calibration matrix
    C = [handles.aspect_ratio 0 handles.ppx; 0 1 handles.ppy; 0 0 1/handles.focal_length];
    handles.C = C;
  
    
    
    %informational variables
    handles.n_matches = 0; %how many matches have we detected.
    
    
    %general parameters
    %debugt mode
    handles.debug = 1;
    handles.m3 = 256; %third homogeous pixel coordinate, chosen as 256 to help conditioning, see my thesis
    handles.pathname = ['C:\matlabR12\bin\'];
    
    if ~handles.debug
        helpdlg('Phil asks: "how ya diddling", first load some images')
    end
    
    
    set(handles.save_image1_button, 'Enable', 'off');
    set(handles.save_image2_button, 'Enable', 'off');
    set(handles.Save_Images_menu, 'Enable', 'off');
    
    
    %for corners
    set(handles.detect_corner_button, 'Enable', 'off');
    set(handles.save_corner_button, 'Enable', 'off');
    set(handles.load_corner_button, 'Enable', 'on');
    set(handles.corn_param_button, 'Enable', 'off');
    
    %for correlation matches
    set(handles.match_button, 'Enable', 'off');
    set(handles.match_param_button, 'Enable', 'on');
    set(handles.manual_match_button, 'Enable', 'on');
    set(handles.save_match_button, 'Enable', 'off');    
    set(handles.load_match_button, 'Enable', 'off');
    
    %for F and correlation matches
    set(handles.mapsac_button, 'Enable', 'off');
    set(handles.mapsac_parameters_button, 'Enable', 'on');
    set(handles.save_F_button, 'Enable', 'off');
    set(handles.display_epipolar_button, 'Enable', 'off');
    set(handles.display_epipolar_button2, 'Enable', 'off');
    set(handles.ImproveF_button, 'Enable', 'off');
    
    %for SFM
    set(handles.sfm_button, 'Enable', 'off');
    
 
    
    guidata(fig, handles);
    
    if nargout > 0
        varargout{1} = fig;
    end
    
elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK
    
    try
        [varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
    catch
        disp(lasterr);
    end
    
end


%| ABOUT CALLBACKS:
%| GUIDE automatically appends subfunction prototypes to this file, and 
%| sets objects' callback properties to call them through the FEVAL 
%| switchyard above. This comment describes that mechanism.
%|
%| Each callback subfunction declaration has the following form:
%| <SUBFUNCTION_NAME>(H, EVENTDATA, HANDLES, VARARGIN)
%|
%| The subfunction name is composed using the object's Tag and the 
%| callback type separated by '_', e.g. 'slider2_Callback',
%| 'figure1_CloseRequestFcn', 'axis1_ButtondownFcn'.
%|
%| H is the callback object's handle (obtained using GCBO).
%|
%| EVENTDATA is empty, but reserved for future use.
%|
%| HANDLES is a structure containing handles of components in GUI using
%| tags as fieldnames, e.g. handles.figure1, handles.slider2. This
%| structure is created at GUI startup using GUIHANDLES and stored in
%| the figure's application data using GUIDATA. A copy of the structure
%| is passed to each callback.  You can store additional information in
%| this structure at GUI startup, and you can change the structure
%| during callbacks.  Call guidata(h, handles) after changing your
%| copy to replace the stored original so that subsequent callbacks see
%| the updates. Type "help guihandles" and "help guidata" for more
%| information.
%|
%| VARARGIN contains any extra arguments you have passed to the
%| callback. Specify the extra arguments by editing the callback
%| property in the inspector. By default, GUIDE sets the property to:
%| <MFILENAME>('<SUBFUNCTION_NAME>', gcbo, [], guidata(gcbo))
%| Add any extra arguments after the last argument, before the final
%| closing parenthesis.


% --------------------------------------------------------------------

%%get rid f current stuff and do it again!
function varargout = start_again_button_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.start_again_button.
clear_button_Callback(h, eventdata, handles, varargin)
initialize(handles)



% --------------------------------------------------------------------
function varargout = frame1_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.frame1.
disp('frame1 Callback not implemented yet. O great one')


%---------------------------------------------------------------------\\\

function menu_OpenImage_Callback(h,eventdata,handles,varargin)
disp('loading some images your highness')

load_image_button_Callback(h, eventdata, handles, varargin)

%---------------------------------------------------------------------\\\

function menu_SaveImages_Callback(h,eventdata,handles,varargin)

save_image1_button_Callback(h, eventdata, handles, varargin)
save_image_button2_Callback(h, eventdata, handles, varargin)

%---------------------------------------------------------------------\\\

function menu_display_corners_Callback(h,eventdata,handles,varargin)
clear_button_Callback(h, eventdata, handles, varargin);
display_corners_in_figure(handles);

%---------------------------------------------------------------------\\\

function menu_display_c_matches_Callback(h,eventdata,handles,varargin)
clear_button_Callback(h, eventdata, handles, varargin);
display_matches(h, eventdata, handles, varargin);

%---------------------------------------------------------------------\\\
function menu_display_i_matches_Callback(h,eventdata,handles,varargin)
clear_button_Callback(h, eventdata, handles, varargin);
display_inliers(h, eventdata, handles, varargin);

%---------------------------------------------------------------------\\\
function menu_display_io_matches_Callback(h,eventdata,handles,varargin)
clear_button_Callback(h, eventdata, handles, varargin);
display_matches(h, eventdata, handles, varargin);
display_inliers(h, eventdata, handles, varargin);
%---------------------------------------------------------------------\\\

% --------------------------------------------------------------------
function display_corners_in_figure(handles)

% extracting the handle of the axes in which to display the image
ax_handle2 = handles.axes2;
ax_handle3 = handles.axes3; 
ccr1 = handles.ccr1;
ccr2 = handles.ccr2;

axes(ax_handle2);
hold on
axes(ax_handle3);
hold on
%		plot(c_col, c_row, '+');
plot(ccr1(:,1), ccr1(:,2), 'g+','Parent', ax_handle2);
plot(ccr2(:,1), ccr2(:,2), 'r+','Parent', ax_handle3);


axes(ax_handle2);        
hold off
axes(ax_handle3);        
hold off



% --------------------------------------------------------------------
function varargout = detect_corner_button_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton3.
disp('Calculating corners.')

[ccr1] = torr_charris(handles.d1,handles.n_corners,handles.corner_width,handles.corner_sigma);
[ccr2] = torr_charris(handles.d2,handles.n_corners,handles.corner_width,handles.corner_sigma);


%normalize so that the centre of the image is the origin...
ccr1(:,1) = ccr1(:,1) - handles.image_centrex;
ccr1(:,2) = ccr1(:,2) - handles.image_centrey;
ccr2(:,1) = ccr2(:,1) - handles.image_centrex;
ccr2(:,2) = ccr2(:,2) - handles.image_centrey;

handles.ccr1 = ccr1;
handles.ccr2 = ccr2;
handles.n_corners1 = length(ccr1);
handles.n_corners2 = length(ccr2);

display_corners_in_figure(handles)

set(handles.save_corner_button, 'Enable', 'on');
set(handles.match_button, 'Enable', 'on');
set(handles.match_param_button, 'Enable', 'on');
% set(handles.manual_match_button, 'Enable', 'on');



guidata(handles.figure1, handles);
% --------------------------------------------------------------------


%here is phil's code to get a file, it uses the warning dialog
%it has not been properly tested
function [filename, pathname] = uigetfile_name(filer,message)

[filename, pathname] = uigetfile(filer,message)
if isequal(filename,0)|isequal(pathname,0)
    %recurse
    [filename, pathname] = uigetfile_name(filer,message);
else
    disp(['File ', pathname, filename, ' found'])
end



% --------------------------------------------------------------------
function [filename, pathname] = uiputfile_name(filer,message)

[filename, pathname] = uiputfile(filer,message)
if isequal(filename,0)|isequal(pathname,0)
    [filename, pathname] = uiputfile_name(filer,message);
else
    disp(['File ', pathname, filename, ' has been saved'])
end




% --------------------------------------------------------------------
function varargout = load_demo_image_button_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton5.
% [filename, pathname] = uigetfile_name('*.bmp;*.jpg;*.gif','Pick an input image')
%     [i1,map1] = imread([pathname filename]);
%     
%     [filename, pathname] = uigetfile_name('*.bmp;*.jpg;*.gif','Pick a second input image')
%     [i2,map2] = imread([pathname filename]);

pathname1 = ['.\'];
pathname2 = ['.\'];
filename1=['j1.bmp'];
filename2=['j2.bmp'];


load_2images(h, eventdata, handles, varargin, filename1, pathname1,filename2, pathname2);

%---------------------------------------------------------------------\\\


function varargout = load_2images(h, eventdata, handles, varargin, ...
    filename1, pathname1,filename2, pathname2)


if pathname1 == pathname2
    handles.pathname = pathname1;
else
    errordlg(['The two images should be in the same directory:' pathname1 pathname2],'not fatal');
    handles.pathname = pathname1;
end




[i1,map1] = imread([pathname1 filename1]);
[i2,map2] = imread([pathname2 filename2]);


iii =  size(size(i1));
if iii(2) == 3
    g1 = rgb2gray(i1);
    disp('converting to rgb');
else
    g1 = i1;
end


iii =  size(size(i2));
if iii(2) == 3
    g2 = rgb2gray(i2);
else
    g2 = i2;
end


%if we successfully load:
set(handles.detect_corner_button, 'Enable', 'on');
set(handles.load_corner_button, 'Enable', 'on');
set(handles.corn_param_button, 'Enable', 'on');

set(handles.save_image1_button, 'Enable', 'on');        
set(handles.save_image2_button, 'Enable', 'on');

set(handles.Save_Images_menu, 'Enable', 'on');

set(handles.manual_match_button, 'Enable', 'on');
set(handles.load_match_button, 'Enable', 'on');




d1 = double(g1);
d2 = double(g2);

% extracting the handle of the axes in which to display the image
ax_handle2 = handles.axes2; 
axes(ax_handle2);

set(get(ax_handle2, 'Title'), 'Visible', 'off');
set(get(ax_handle2, 'Title'),'String', 'fff');

[m,n] = size(d1);
[m1,n1] = size(d2);
if (m ~= m1) | (n ~= n1)
    error('images must be the same size')
end

axis equal;
colormap(map1);
image(i1, 'Parent', ax_handle2,'XData',-n/2,'YData',-m/2);
%  imshow(i1, 'Parent', ax_handle2);

ax_handle3 = handles.axes3; 
axes(ax_handle3);
colormap(map1);
image(i2, 'Parent', ax_handle3,'XData',-n/2,'YData',-m/2);

handles.image_centrex = n/2;
handles.image_centrey = m/2;


handles.i1 = i1;
handles.i2 = i2;
handles.d1 = d1;
handles.d2 = d2;
handles.pathname = pathname1;

% saving the GUI data
guidata(handles.figure1, handles);
%---------------------------------------------------------------------\\\


% --------------------------------------------------------------------
function varargout = load_image_button_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton5.
[filename1, pathname1] = uigetfile_name('*.bmp;*.jpg;*.gif','Pick an input image')

[filename2, pathname2] = uigetfile_name('*.bmp;*.jpg;*.gif','Pick a second input image')

load_2images(h, eventdata, handles, varargin, filename1, pathname1,filename2, pathname2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --------------------------------------------------------------------
function varargout = clear_button_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton6.


% extracting the handle of the axes in which to display the image
ax_handle2 = handles.axes2; 
axes(ax_handle2);

set(get(ax_handle2, 'Title'), 'Visible', 'off');
set(get(ax_handle2, 'Title'),'String', 'fff');

hold off
image(handles.i1, 'Parent', ax_handle2,'XData',-handles.image_centrex,'YData',-handles.image_centrey);
%  imshow(i1, 'Parent', ax_handle2);



ax_handle3 = handles.axes3; 
axes(ax_handle3);
hold off
image(handles.i2, 'Parent', ax_handle3,'XData',-handles.image_centrex,'YData',-handles.image_centrey);




% --------------------------------------------------------------------
function varargout = close_button_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.close_button.
pos_size = get(handles.figure1,'Position');
user_response = modaldlg([pos_size(1)+pos_size(3)/5 pos_size(2)+pos_size(4)/5]);
switch user_response
case {'no','cancel'}
    % take no action
case 'yes'
    % Prepare to close GUI application window
    %                  .
    %                  .
    %                  .
    delete(handles.figure1)
end



% --------------------------------------------------------------------
function varargout = help_button_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.help_button.
HelpPath = which('stereo.htm');
web(HelpPath); 


% --------------------------------------------------------------------
function varargout = corn_param_button_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.corn_param_button.

pos_size = get(handles.figure1,'Position');
dlg_pos = [pos_size(1)+pos_size(3)/5 pos_size(2)+pos_size(4)/5];
corn_param = torr_c_menu(handles, dlg_pos);

handles.n_corners = corn_param(1);
handles.corner_sigma = corn_param(2);
handles.corner_width = corn_param(3);
corn_param
% saving the GUI data
guidata(handles.figure1, handles);
%---------------------------------------------------------------------\\\

function save_corners_to_file(n_corners1, n_corners2, ccr1, ccr2, FID)


fprintf(FID,'%1.0f \n',n_corners1);
fprintf(FID,'%1.0f \n',n_corners2);

fprintf(FID,'%1.1f %1.1f \n',ccr1');
fprintf(FID,'%1.1f %1.1f \n',ccr2');


% --------------------------------------------------------------------
function varargout = save_corner_button_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.save_corner_button.
[fname,pname] = uiputfile_name('*.cor','Put Corner File');
ccr1 = handles.ccr1;
ccr2 = handles.ccr2;

%save([pname fname], 'n_corners', 'ccr1', 'ccr2', '-ASCII')
FID = fopen([pname fname],'w');

n_corners1 = handles.n_corners1;
n_corners2 = handles.n_corners2;

save_corners_to_file(n_corners1, n_corners2, ccr1, ccr2, FID)

fclose(FID);

% --------------------------------------------------------------------

function [n_corners1, n_corners2, ccr1, ccr2] = load_corners_from_file(FID)

n_corners1 = fscanf(FID,'%f',1);
n_corners2 = fscanf(FID,'%f',1);
ccr1  = fscanf(FID,'%f %f',[2 n_corners1]);
ccr2  = fscanf(FID,'%f %f',[2 n_corners2]);

% --------------------------------------------------------------------


function varargout = load_corner_button_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.load_corner_button.
[fname,pname] = uigetfile_name('*.cor','Load Corner File');

if isempty(fname)
    return
end

FID = fopen([pname fname]);

[n_corners1, n_corners2, ccr1, ccr2] = load_corners_from_file(FID);
handles.n_corners1 = n_corners1;
handles.n_corners2 = n_corners2;
handles.ccr1 = ccr1';
handles.ccr2 = ccr2';



fclose(FID);
set(handles.save_corner_button, 'Enable', 'on');
set(handles.match_button, 'Enable', 'on');
set(handles.match_param_button, 'Enable', 'on');

%once we have done the matches we can no longer redo corners otherwise things might be inconsistent
set(handles.detect_corner_button, 'Enable', 'off');
% saving the GUI data
guidata(handles.figure1, handles);

clear_button_Callback(h, eventdata, handles, varargin);
display_corners_in_figure(handles)
%---------------------------------------------------------------------\\\



% --------------------------------------------------------------------
function varargout = match_button_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.match_button.


%shift the x,y coordinates so we can access the image directly
ccr1(:,1) = handles.ccr1(:,1) + handles.image_centrex;
ccr1(:,2) = handles.ccr1(:,2) + handles.image_centrey;
ccr2(:,1) = handles.ccr2(:,1) + handles.image_centrex;
ccr2(:,2) = handles.ccr2(:,2) + handles.image_centrey;

matches12 = torr_corn_matcher(handles.d1, handles.d2, ccr1, ccr2, handles.max_disparity,handles.match_half_size);

disp('Number of matches:')
length(matches12)

matches12(:,1) = matches12(:,1) - handles.image_centrex;
matches12(:,2) = matches12(:,2) - handles.image_centrey;
matches12(:,3) = matches12(:,3) - handles.image_centrex;
matches12(:,4) = matches12(:,4) - handles.image_centrey;


handles.matches12 = matches12;
handles.n_matches = length(matches12);


set(handles.save_match_button, 'Enable', 'on');    

set(handles.mapsac_button, 'Enable', 'on');
set(handles.mapsac_parameters_button, 'Enable', 'on');

%once we have done the matches we can no longer redo corners otherwise things might be inconsistent
set(handles.detect_corner_button, 'Enable', 'off');


guidata(handles.figure1, handles);
display_matches(h, eventdata, handles, varargin);
% --------------------------------------------------------------------
function varargout = display_matches(h, eventdata, handles, varargin)
% extracting the handle of the axes in which to display the image
ax_handle2 = handles.axes2;
ax_handle3 = handles.axes3; 

ccr1 = handles.ccr1;
ccr2 = handles.ccr2;
matches= handles.matches12;
axes(ax_handle2);
hold on
axes(ax_handle3);
hold on



x1 = matches(:,1);
y1 = matches(:,2);
x2 = matches(:,3);
y2 = matches(:,4);

u1 = x2 - x1;
v1 = y2 - y1;



plot (matches(:,1), matches(:,2),'r+');
hold on
plot (matches(:,3), matches(:,4),'r+');

display_numbers = 0;
if display_numbers
    mat_index1 = 1:length(matches);
    mat_index1 = mat_index1';
    mat_index = num2str(mat_index1);
    text(matches(:,1), matches(:,2),mat_index)
end

quiver(x1, y1, u1, v1, 0)
hold off

% 
% plot(ccr1(:,1), ccr1(:,2), 'r.')
% plot(ccr2(:,1), ccr2(:,2), 'c.')
% 
% for i = 1:length(mat12)
%     if mat12(i) ~= 0
%         a = [ccr1(i,1),ccr2(mat12(i),1)];  %x1 x2
%         b = [ccr1(i,2),ccr2(mat12(i),2)];	%y1 y2
%         %x1 y1
%         %x2 y2
%         line(a,b);
%     end
% end

axes(ax_handle2);        
hold off
axes(ax_handle3);        
hold off

% --------------------------------------------------------------------
function varargout = match_param_button_Callback(h, eventdata, handles, varargin)


pos_size = get(handles.figure1,'Position');
dlg_pos = [pos_size(1)+pos_size(3)/5 pos_size(2)+pos_size(4)/5];
match_param = torr_m_menu(handles, dlg_pos);

handles.max_disparity = match_param(1);
handles.match_half_size = match_param(2);
% saving the GUI data
guidata(handles.figure1, handles);
%---------------------------------------------------------------------
% --------------------------------------------------------------------
function varargout = save_image1_button_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.save_image1_button.
ax_handle2 = handles.axes2;
%ax_handle3 = handles.axes3; 
% hf1 = figure;
% %plot(sin(1:10));
%hf2 = figure;
%ha = findobj('Parent',hf1);
% ax_handle2 = handles.axes2;
% new_axes = axes(ax_handle2);
% set(new_axes, 'Parent', hf1);
% 
% [fname,pname] = uiputfile('*.fig');
% saveas(ax_handle2,[pname fname ]);
%hgsave(ax_handle2,[pname fname ]);

new_fig = figure;
new_axes = copyobj(ax_handle2,new_fig)
%set(new_axes,'Position',[.5 .5 .8 .8],'DataAspectRatioMode','auto','PlotBoxAspectRatioMode','auto');

%get(new_axes)
axis_position = get(new_axes,'Position');
set(new_axes,'Position',[10 7  axis_position(3) axis_position(4) ]);
%keyboard

% fff = handles.figure1;
% saveas(fff,'bigfig.bmp');

% --------------------------------------------------------------------
function varargout = save_image2_button_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.save_image2_button.
ax_handle3 = handles.axes3;

% [fname,pname] = uiputfile('*.fig');
% saveas(ax_handle3,[pname fname ]);
%hgsave(ax_handle3,[pname fname ]);

new_fig = figure;
new_axes = copyobj(ax_handle3,new_fig)
%set(new_axes,'Position',[.5 .5 .8 .8],'DataAspectRatioMode','auto','PlotBoxAspectRatioMode','auto');

%get(new_axes)
axis_position = get(new_axes,'Position');
set(new_axes,'Position',[10 7  axis_position(3) axis_position(4) ]);
%keyboard


% --------------------------------------------------------------------
function varargout = manual_match_button_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.manual_match_button.


set(handles.save_match_button, 'Enable', 'on');    
set(handles.load_match_button, 'Enable', 'on');

matches12 = torr_add_manual_matches(handles.axes2,handles.axes3);

handles.matches12 = matches12;
handles.n_matches = length(matches12);

%also store corners
ccr1(:,1) = matches12(:,1);
ccr1(:,2) = matches12(:,2);
ccr2(:,1) = matches12(:,3);
ccr2(:,2) = matches12(:,4);
handles.ccr1 = ccr1;
handles.ccr2 = ccr2;

%once we have done the matches we can no longer redo corners otherwise things might be inconsistent
set(handles.detect_corner_button, 'Enable', 'off');


guidata(handles.figure1, handles);
display_matches(h, eventdata, handles, varargin);

if handles.n_matches > 7;
    set(handles.mapsac_button, 'Enable', 'on');
    set(handles.mapsac_parameters_button, 'Enable', 'on');
    set(handles.ImproveF_button, 'Enable', 'on');
end



% --------------------------------------------------------------------
function varargout = save_match_button_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.save_corner_button.
[fname,pname] = uiputfile_name('*.matches','Put Match File');

n_matches = handles.n_matches;
matches12 = handles.matches12;

%save([pname fname], 'n_corners', 'ccr1', 'ccr2', '-ASCII')
FID = fopen([pname fname],'w');
fprintf(FID,'%1.0f \n',n_matches);
fprintf(FID,'%1.1f %1.1f %1.1f %1.1f  \n',matches12');

%now store original corners for good measure:
n_corners = handles.n_corners;
ccr1 = handles.ccr1;
ccr2 = handles.ccr2;
n_corners1 = handles.n_corners1;
n_corners2 = handles.n_corners2;
save_corners_to_file(n_corners1, n_corners2, ccr1, ccr2, FID);
fclose(FID);


% --------------------------------------------------------------------
function varargout = load_match_button_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.load_match_button.
% Stub for Callback of the uicontrol handles.load_corner_button.
[fname,pname] = uigetfile_name('*.matches','Load Match File');

if isempty(fname)
    return
end

FID = fopen([pname fname]);
n_matches = fscanf(FID,'%f',1)
handles.n_matches = n_matches;
matches12  = fscanf(FID,'%f %f %f %f',[4 n_matches]);

[n_corners1, n_corners2, ccr1, ccr2] = load_corners_from_file(FID);
handles.n_corners1 = n_corners1;
handles.n_corners2 = n_corners2;
handles.ccr1 = ccr1';
handles.ccr2 = ccr2';

fclose(FID);

handles.matches12 = matches12';

set(handles.save_corner_button, 'Enable', 'on');
set(handles.save_match_button, 'Enable', 'on');
set(handles.match_button, 'Enable', 'on');
set(handles.match_param_button, 'Enable', 'on');

% Stub for Callback of the uicontrol handles.pushbutton28.
set(handles.mapsac_button, 'Enable', 'on');
set(handles.mapsac_parameters_button, 'Enable', 'on');



% saving the GUI data
guidata(handles.figure1, handles);
clear_button_Callback(h, eventdata, handles, varargin)
display_matches(h, eventdata, handles, varargin)



% --------------------------------------------------------------------
function varargout = display_inliers(h, eventdata, handles, varargin)
% extracting the handle of the axes in which to display the image
ax_handle2 = handles.axes2;
ax_handle3 = handles.axes3; 

ccr1 = handles.ccr1;
ccr2 = handles.ccr2;
axes(ax_handle2);
hold on
axes(ax_handle3);
hold on


matches12 = handles.inlier_matches;
plot(matches12(:,3),matches12(:,4),'c.');

for i = 1:length(matches12)
    a = [matches12(i,1),matches12(i,3)];  %x1 x2
    b = [matches12(i,2),matches12(i,4)];	%y1 y2
    line(a,b,'Color','g');
end

axes(ax_handle2);
hold on

plot(matches12(:,3),matches12(:,4),'c.');

%can i fix this to make this faster??
for i = 1:length(matches12)
    a = [matches12(i,1),matches12(i,3)];  %x1 x2
    b = [matches12(i,2),matches12(i,4)];	%y1 y2
    line(a,b,'Color','g');
end

axes(ax_handle2);        
hold off
axes(ax_handle3);        
hold off

%MAPSAC is the Bayesian version of MLESAC, and it is easier to pronounce!
% --------------------------------------------------------------------
function varargout = mapsac_button_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.mapsac_button.


%run mapsac to get f
f_optim_parameters = [handles.no_samp, handles.f_threshold];
[f,f_sq_errors, n_inliers,inlier_index] = torr_estimateF(handles.matches12, handles.m3, f_optim_parameters, 'mapsac');
disp('goodness of fit before non linear:')
norm(f_sq_errors)


handles.f = f;
handles.inlier_matches = handles.matches12(inlier_index,:);
handles.n_inliers  = n_inliers;

%first estimate F
[f_nl,f_sq_errors] = torr_estimateF(handles.inlier_matches, handles.m3, [], 'non_linear',1,f);
handles.f = f_nl;
disp('goodness of fit after non linear:')
norm(f_sq_errors)

%finally display inliers
clear_button_Callback(h, eventdata, handles, varargin);
display_inliers(h, eventdata, handles, varargin);

%we can now save the result
set(handles.save_F_button, 'Enable', 'on');
set(handles.detect_corner_button, 'Enable', 'off');
set(handles.match_button, 'Enable', 'off');
set(handles.display_epipolar_button, 'Enable', 'on');
set(handles.display_epipolar_button2, 'Enable', 'on');
%set(handles.mapsac_plane_button, 'Enable', 'on');

set(handles.ImproveF_button, 'Enable', 'on');
set(handles.sfm_button, 'Enable', 'on');


% saving the GUI data
guidata(handles.figure1, handles);

% --------------------------------------------------------------------
function varargout = mapsac_parameters_button_Callback(h, eventdata, handles, varargin)

pos_size = get(handles.figure1,'Position');
dlg_pos = [pos_size(1)+pos_size(3)/5 pos_size(2)+pos_size(4)/5];
f_param = torr_f_menu(handles, dlg_pos);

handles.no_samp = f_param(1);
handles.f_threshold = f_param(2);
% saving the GUI data
guidata(handles.figure1, handles);
%--------------------------------------------------------------


%here we save all the stuff in corner file, match file and add some extras....
% --------------------------------------------------------------------
function varargout = save_F_button_Callback(h, eventdata, handles, varargin)
[fname,pname] = uiputfile_name('*.Fmatches','Put F & inlying matches');


f = handles.f;
inlier_matches = handles.inlier_matches;
n_inliers = handles.n_inliers;

n_matches = handles.n_matches;
matches12 = handles.matches12;
f = handles.f;
f

FID = fopen([pname fname],'w');

%save F stuff
fprintf(FID,'%1.0f \n',n_inliers);
fprintf(FID,'%12.8f \n', f);
fprintf(FID,'%1.1f %1.1f %1.1f %1.1f  \n',inlier_matches');


%save correlation matches
fprintf(FID,'%1.0f \n',n_matches);
fprintf(FID,'%1.1f %1.1f %1.1f %1.1f  \n',matches12');

%now store original corners for good measure:
n_corners = handles.n_corners;
ccr1 = handles.ccr1;
ccr2 = handles.ccr2;
n_corners1 = handles.n_corners1;
n_corners2 = handles.n_corners2;
save_corners_to_file(n_corners1, n_corners2, ccr1, ccr2, FID);
fclose(FID);


% --------------------------------------------------------------------
function varargout = load_F_button_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton28.


[fname,pname] = uigetfile_name('*.fmatches','Load Match File');
if isempty(fname)
    return
end


%set(handles.mapsac_plane_button, 'Enable', 'on');
set(handles.mapsac_button, 'Enable', 'on');
set(handles.mapsac_parameters_button, 'Enable', 'on');
set(handles.save_F_button, 'Enable', 'on');

set(handles.ImproveF_button, 'Enable', 'on');

set(handles.sfm_button, 'Enable', 'on');


FID = fopen([pname fname]);


%save F stuff
n_inliers = fscanf(FID,'%f',1);
f = fscanf(FID,'%f',[1 9]);
inlier_matches = fscanf(FID,'%f %f %f %f',[4 n_inliers]);

disp('fundamental matrix')
handles.f = f
handles.inlier_matches = inlier_matches';
handles.n_inliers  = n_inliers;



n_matches = fscanf(FID,'%f',1);
handles.n_matches = n_matches;
matches12  = fscanf(FID,'%f %f %f %f',[4 n_matches]);

[n_corners1, n_corners2, ccr1, ccr2] = load_corners_from_file(FID);
handles.n_corners1 = n_corners1;
handles.n_corners2 = n_corners2;
handles.ccr1 = ccr1';
handles.ccr2 = ccr2';



fclose(FID);


handles.matches12 = matches12';

set(handles.save_corner_button, 'Enable', 'on');
set(handles.save_match_button, 'Enable', 'on');
set(handles.match_button, 'Enable', 'on');
set(handles.match_param_button, 'Enable', 'on');
set(handles.detect_corner_button, 'Enable', 'off');
set(handles.match_button, 'Enable', 'off');
set(handles.display_epipolar_button, 'Enable', 'on');
set(handles.display_epipolar_button2, 'Enable', 'on');


% Stub for Callback of the uicontrol handles.pushbutton28.
set(handles.mapsac_button, 'Enable', 'on');
set(handles.mapsac_parameters_button, 'Enable', 'on');
%we can now save the result
set(handles.save_F_button, 'Enable', 'on');



% saving the GUI data
guidata(handles.figure1, handles);
clear_button_Callback(h, eventdata, handles, varargin)
%display_matches(h, eventdata, handles, varargin)

%finally display inliers
display_inliers(h, eventdata, handles, varargin);
%%%----------------------------------------------------------------------------------
%%%%this is not 100% checked....
function varargout = display_epipolar_button_Callback(h, eventdata, handles, varargin)

torr_display_epipolar(handles.f,handles.axes2,handles.axes3,handles.m3);


%%%----------------------------------------------------------------------------------

function varargout = display_epipolar_button2_Callback(h, eventdata, handles, varargin)
f = handles.f;

%need to use the transpose of F for image 2--1 
f = [f(1) f(4) f(7) f(2) f(5) f(8) f(3) f(6) f(9)];
torr_display_epipolar(f,handles.axes3,handles.axes2,handles.m3);


%%%----------------------------------------------------------------------------------



% --------------------------------------------------------------------
function varargout = mapsac_plane_button_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.mapsac_plane_button.
% Stub for Callback of the uicontrol handles.mapsac_button.


%run mapsac to get f
[f,f_sq_errors, n_inliers,inlier_index] = torr_mapsac_H(handles.matches12(:,1),handles.matches12(:,2),handles.matches12(:,3),handles.matches12(:,4), ...
    handles.n_matches, handles.m3, handles.no_samp, handles.f_threshold)

handles.f = f;
handles.inlier_matches = handles.matches12(inlier_index,:);
handles.n_inliers  = n_inliers;

%finally display inliers
clear_button_Callback(h, eventdata, handles, varargin);
display_inliers(h, eventdata, handles, varargin);

%we can now save the result
set(handles.save_F_button, 'Enable', 'on');
set(handles.detect_corner_button, 'Enable', 'off');
set(handles.match_button, 'Enable', 'off');
set(handles.display_epipolar_button, 'Enable', 'on');
set(handles.display_epipolar_button2, 'Enable', 'on');


% saving the GUI data
guidata(handles.figure1, handles);




% --------------------------------------------------------------------
function varargout = ImproveF_button_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.ImproveF_button.

%this function simply operates on the set of matches with no robustness
%to be used with manual input etc...
handles.m3 = 256;

%first estimate F
f = torr_estimateF(handles.matches12, handles.m3, [], 'lin+non_lin');
handles.f = f;


%we can now save the result
set(handles.save_F_button, 'Enable', 'on');
set(handles.detect_corner_button, 'Enable', 'off');
set(handles.match_button, 'Enable', 'off');
set(handles.display_epipolar_button, 'Enable', 'on');
set(handles.display_epipolar_button2, 'Enable', 'on');
%set(handles.mapsac_plane_button, 'Enable', 'on');

set(handles.ImproveF_button, 'Enable', 'on');
set(handles.sfm_button, 'Enable', 'on');

% saving the GUI data
guidata(handles.figure1, handles);


% --------------------------------------------------------------------


% --------------------------------------------------------------------
function varargout = sfm_button_Callback(h, eventdata, handles, varargin)
%this function estalishes the frame, self calibrates and estimates X


f = handles.f;
nF = [[f(1) f(2) f(3)]; [f(4) f(5) f(6)];[f(7) f(8) f(9)]];

nx1 = handles.inlier_matches(:,1);
ny1 = handles.inlier_matches(:,2);
nx2 = handles.inlier_matches(:,3);
ny2 = handles.inlier_matches(:,4);
no_matches = length(nx1);
m3 = handles.m3;

%next self calibrate for focal length
[focal_length, nE,C] = torr_self_calib_f(nF,handles.C);

%
disp('initial estimate of focal length')
focal_length

%now we have an Essential matrix we can establish the camera frame...
[P1,P2,R,t,srot_axis,rot_angle,g]  = torr_linear_EtoPX(nE,handles.inlier_matches,C,handles.m3);

% %next convert the 6 parameters of g to a fundamental matrix
% f2 = torr_g2F(g,C);

[g,f] = torr_nonlinG(g ,nx1,ny1,nx2,ny2, length(nx1), handles.m3, C)

rot_axis = torr_sphere2unit([g(2) g(3)]);
t = torr_sphere2unit([g(5) g(6)]);
rot_angle = g(4);

disp('non_linear estimate of focal length')
focal_length
disp('rotation')
R
rot_axis
rot_angle
disp('translation')
t

%next correct the points so that they lie on the fundamental matrix
[corrected_matches error2] = torr_correctx4F(f, nx1,ny1,nx2,ny2, no_matches, m3);

%corrected matches should have zero error:
e2 = torr_errf2(f, corrected_matches(:,1), corrected_matches(:,2), corrected_matches(:,3),corrected_matches(:,4), length(nx1), m3);
disp('corrected match error is')
norm(e2)

%next we need to obtain P1 & P2
[P1, P2] = torr_g2FP(g,C);

%now use P matrices and corrected matches to get structure:
X = torr_triangulate(corrected_matches, m3, P1, P2);

%note structure is upside down!

%test reprojection error
% rx1 = (P1 * X)';
% 
% rx1(:,1) = m3 * rx1(:,1) ./ rx1(:,3);
% rx1(:,2) = m3 * rx1(:,2) ./ rx1(:,3);
% 
% rx2 = P2 * X;

inlier_index = torr_robust_chieral(X,P1,P2);

disp('number of outliers from chierality:')
no_matches - length(inlier_index)

X = X(:,inlier_index);
%flash up a new window and display the structure plus cameras:
%invert = 1;

% note becuase of row/column coordinate system of the image the X's are upside down so invert them prior
% to display.
X(2,:) = -X(2,:);
torr_display_structure(X, P1, P2);
X(2,:) = -X(2,:);


handles.P1 = P1;
handles.P2 = P2;
handles.X = X;
handles.inlier_matches = handles.inlier_matches(inlier_index,:);
handles.focal_length = focal_length;
handles.E = nE;
handles.C = C;
handles.f = f;
handles.n_matches = no_matches;

% saving the GUI data
guidata(handles.figure1, handles);



% --------------------------------------------------------------------
function varargout = sfm_parambutton_Callback(h, eventdata, handles, varargin)

pos_size = get(handles.figure1,'Position');
dlg_pos = [pos_size(1)+pos_size(3)/5 pos_size(2)+pos_size(4)/5];

cal_param = torr_cal_menu(handles, dlg_pos);

handles.focal_length = cal_param(1);
handles.aspect_ratio = cal_param(2);
handles.ppx =  cal_param(3);
handles.ppy =  cal_param(4);

%work out calibration matrix
C = [ handles.aspect_ratio 0 handles.ppx; 0 1 handles.ppy; 0 0 1/handles.focal_length];
C
handles.C = C;
% saving the GUI data
guidata(handles.figure1, handles);



% --------------------------------------------------------------------
function varargout = initialize(handles)

disp('this function isnt ready yet');
%phils atuff added, initialization
%corner parameters
handles.n_corners = 500; %max no of corners permitted/requested

handles.n_corners1 = 0; %the actual number detected
handles.n_corners2 = 0; 

handles.corner_sigma = 1.0;
handles.corner_width = 3;


%matchin parameters
handles.max_disparity = 100;
handles.match_half_size = 3;


%F parameters:
handles.no_samp = 500; % no of samples in the mapsac algorithm
handles.f_threshold = 6.0; % f_threshold in the mapsac algorithm

%informational variables
handles.n_matches = 0; %how many matches have we dectected.


%general parameters
%debugt mode
handles.debug = 1;
handles.m3 = 256; %third homogeous pixel coordinate, chosen as 256 to help conditioning, see my thesis
handles.pathname = ['C:\matlabR12\bin\'];


%calibration matrix 
handles.focal_length = 3; %first guess, which is in units of m3 i.e
                            %focal length in pixels is 3 * m3
handles.aspect_ratio = 1;
handles.ppx =  0;
handles.ppy =  0;
%work out calibration matrix
C = [a 0 handles.ppx; 0 1 handles.ppy; 0 0 1/handles.focal_length];
handles.C = C;

if ~handles.debug
    helpdlg('Phil asks: "how ya diddling", first load some images')
end


set(handles.save_image1_button, 'Enable', 'off');
set(handles.save_image2_button, 'Enable', 'off');
set(handles.Save_Images_menu, 'Enable', 'off');


%for corners
set(handles.detect_corner_button, 'Enable', 'off');
set(handles.save_corner_button, 'Enable', 'off');
set(handles.load_corner_button, 'Enable', 'off');
set(handles.corn_param_button, 'Enable', 'off');

%for correlation matches
set(handles.match_button, 'Enable', 'off');
set(handles.match_param_button, 'Enable', 'off');
set(handles.manual_match_button, 'Enable', 'off');
set(handles.save_match_button, 'Enable', 'off');    
set(handles.load_match_button, 'Enable', 'off');

%for F and correlation matches
set(handles.mapsac_button, 'Enable', 'off');
set(handles.mapsac_parameters_button, 'Enable', 'off');
set(handles.save_F_button, 'Enable', 'off');
set(handles.display_epipolar_button, 'Enable', 'off');
set(handles.display_epipolar_button2, 'Enable', 'off');

%self calibrate
set(handles.calibrate_button, 'Enable', 'on');




guidata(handles.figure1, handles);





% --------------------------------------------------------------------
function varargout = epi_button_Callback(h, eventdata, handles, varargin)

 torr_disp_epip_geom(handles.f,handles.matches12,handles.axes2,handles.axes3,handles.m3);


 f = handles.f;
f = [f(1) f(4) f(7) f(2) f(5) f(8) f(3) f(6) f(9)];

torr_disp_epip_geom(handles.f,handles.matches12,handles.axes3,handles.axes2,handles.m3);



% --------------------------------------------------------------------







