function varargout = im2bw_args(varargin)
% IM2BW_ARGS MATLAB code for im2bw_args.fig
%      IM2BW_ARGS, by itself, creates a new IM2BW_ARGS or raises the existing
%      singleton*.
%
%      H = IM2BW_ARGS returns the handle to a new IM2BW_ARGS or the handle to
%      the existing singleton*.
%
%      IM2BW_ARGS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IM2BW_ARGS.M with the given input arguments.
%
%      IM2BW_ARGS('Property','Value',...) creates a new IM2BW_ARGS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before im2bw_args_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to im2bw_args_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help im2bw_args

% Last Modified by GUIDE v2.5 15-Oct-2018 17:00:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @im2bw_args_OpeningFcn, ...
                   'gui_OutputFcn',  @im2bw_args_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before im2bw_args is made visible.
function im2bw_args_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to im2bw_args (see VARARGIN)

% Choose default command line output for im2bw_args
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
h_pjimage=findobj('Tag','figure_pjimage');
h_pjimage=guihandles(h_pjimage); 
setappdata(handles.figure_im2bw,'h_pjimage',h_pjimage);
% UIWAIT makes im2bw_args wait for user response (see UIRESUME)
% uiwait(handles.figure_im2bw);


% --- Outputs from this function are returned to the command line.
function varargout = im2bw_args_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider_val_Callback(hObject, eventdata, handles)
% hObject    handle to slider_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(hObject,'Value'); 
set(handles.txt_display,'String',num2str(val)); 
h_pjimage=getappdata(handles.figure_im2bw,'h_pjimage');
axes(h_pjimage.axes_dst); 
img_src=getappdata(h_pjimage.figure_pjimage,'img_src');
bw=im2bw(img_src,val); 
imshow(bw); 
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
