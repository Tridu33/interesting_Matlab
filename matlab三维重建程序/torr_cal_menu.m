%	By Philip Torr 2002
%	copyright Microsoft Corp.

function cal_param_out = c_menu(varargin)
% C_MENU Application M-file for c_menu.fig
%    FIG = C_MENU launch c_menu GUI.
%    C_MENU('callback_name', ...) invoke the named callback.

% Last Modified by GUIDE v2.0 16-May-2002 14:35:35
error(nargchk(0,4,nargin)) % function takes only 0 or 2 argument
if  nargin == 2 % LAUNCH GUI
    
    
    fig = openfig(mfilename,'reuse');    
        
    % Generate a structure of handles to pass to callbacks, and store it. 
    handles = guihandles(fig);
    
      
    cal_param = varargin{1};
    handles.focal_length = cal_param.focal_length;
    handles.aspect_ratio = cal_param.aspect_ratio;
    handles.ppx =  cal_param.ppx;
    handles.ppy =  cal_param.ppy;
    handles.m3 = cal_param.m3;
    
    
    
    foc_string = strcat(num2str(handles.focal_length),', in pixels:',num2str(handles.focal_length * handles.m3))
    set(handles.foc_button, 'String', foc_string);
    set(handles.ar_button, 'String', num2str(handles.aspect_ratio));
    set(handles.ppx_button, 'String', num2str(handles.ppx));
    set(handles.ppy_button, 'String', num2str(handles.ppy));
    
    
    
    
    guidata(fig, handles);
    
    
    
    
    % Wait for callbacks to run and window to be dismissed:
    uiwait(fig);
    
    
    % UIWAIT might have returned because the window was deleted using
    % the close box - in that case, return 'cancel' as the answer, and
    % don't bother deleting the window!
    if ~ishandle(fig)
        disp('No changes made');
        cal_param_out(1) = handles.focal_length;
        cal_param_out(2) = handles.aspect_ratio;
        cal_param_out(3) = handles.ppx;
        cal_param_out(4) = handles.ppy;
    else
        % otherwise, we got here because the user pushed one of the two buttons.
        % retrieve the latest copy of the 'handles' struct, and return the answer.
        % Also, we need to delete the window.
        
        handles = guidata(fig);
        cal_param_out(1) = handles.focal_length;
        cal_param_out(2) = handles.aspect_ratio;
        cal_param_out(3) = handles.ppx;
        cal_param_out(4) = handles.ppy;
        delete(fig);
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
function varargout = close_button_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.close_button.
%Stub for Callback of the uicontrol handles.close_button.
% 
% Obtaining the Figure Handle from Within a Callback.   In general, dismissing a modal figure requires the handle
% of the figure. Since most GUIs hide figure handles to prevent accidental access, the gcbf (get callback figure)
% command provides the most effective method to get the figure handle from within a callback routine.
% 
% gcbf returns the handle of the figure containing the object whose callback is executing. This enables you to use
% gcbf in the callback of the component that will dismiss the dialog. For example, suppose your dialog includes a
% push button (tagged pushbutton1) that closes the dialog. Its callback could include a call to delete at the end of
% its callback subfunction.

disp('closing');
% cal_param_out.max_disparity = handles.max_disparity;
% cal_param_out.corner_sigma = handles.corner_sigma;
% cal_param_out.match_half_size = handles.match_half_size;

uiresume(handles.figure1);



% --------------------------------------------------------------------
function varargout = foc_button_Callback(h, eventdata, handles, varargin)

nc = str2num(get(handles.foc_button, 'String'));

minnc = 1;
maxnc = 1000000;
if (isempty(nc) | (nc < minnc)  | (nc >maxnc))
    nc = handles.focal_length;
    WARNDLG(['out of range' num2str(minnc) '-' num2str(maxnc)],'ooops') 
end;

handles.focal_length = nc;
foc_string = strcat(num2str(handles.focal_length),', in pixels:',num2str(handles.focal_length * handles.m3))
set(handles.foc_button, 'String', foc_string);

%save data
guidata(handles.figure1, handles);



% --------------------------------------------------------------------
function varargout = ar_button_Callback(h, eventdata, handles, varargin)


nc = str2num(get(handles.ar_button, 'String'));

minnc = 0;
maxnc = 1000000;
if (isempty(nc) | (nc < minnc)  | (nc >maxnc))
    nc = handles.aspect_ratio;
    WARNDLG(['out of range' num2str(minnc) '-' num2str(maxnc)],'ooops') 
end;

handles.aspect_ratio = nc;
set(handles.ar_button, 'String', num2str(handles.aspect_ratio));

%save data
guidata(handles.figure1, handles);



% --------------------------------------------------------------------
function varargout = ppx_button_Callback(h, eventdata, handles, varargin)



nc = str2num(get(handles.ppx_button, 'String'));

minnc = 0;
maxnc = 1000000;
if (isempty(nc) | (nc < minnc)  | (nc >maxnc))
    nc = handles.max_ppx;
    WARNDLG(['out of range' num2str(minnc) '-' num2str(maxnc)],'ooops') 
end;

handles.ppx = nc;
set(handles.ppx_button, 'String', num2str(handles.ppx));

%save data
guidata(handles.figure1, handles);

% --------------------------------------------------------------------
function varargout = ppy_button_Callback(h, eventdata, handles, varargin)


nc = str2num(get(handles.ppy_button, 'String'));

minnc = 0;
maxnc = 1000000;
if (isempty(nc) | (nc < minnc)  | (nc >maxnc))
    nc = handles.max_ppy;
    WARNDLG(['out of range' num2str(minnc) '-' num2str(maxnc)],'ooops') 
end;

handles.ppy = nc;
set(handles.ppy_button, 'String', num2str(handles.ppy));

%save data
guidata(handles.figure1, handles);
