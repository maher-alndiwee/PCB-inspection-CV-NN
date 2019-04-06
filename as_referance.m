function varargout = as_referance(varargin)
% AS_REFERANCE M-file for as_referance.fig
%      AS_REFERANCE, by itself, creates a new AS_REFERANCE or raises the existing
%      singleton*.
%
%      H = AS_REFERANCE returns the handle to a new AS_REFERANCE or the handle to
%      the existing singleton*.
%
%      AS_REFERANCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AS_REFERANCE.M with the given input arguments.
%
%      AS_REFERANCE('Property','Value',...) creates a new AS_REFERANCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before as_referance_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to as_referance_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help as_referance

% Last Modified by GUIDE v2.5 26-Mar-2012 02:54:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @as_referance_OpeningFcn, ...
                   'gui_OutputFcn',  @as_referance_OutputFcn, ...
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


% --- Executes just before as_referance is made visible.
function as_referance_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to as_referance (see VARARGIN)

% Choose default command line output for as_referance
handles.output = hObject;
clc
set(handles.hols_edit,'String',num2str(get(handles.hols_slider,'Value')));
set(handles.lins_edit,'String',num2str(get(handles.lins_slider,'Value')));
global bw_ref
global bw_hols
setappdata(0  , 'as_referance'    , gcf);
hMainGui = getappdata(0, 'hMainGui');
bw_ref = getappdata(hMainGui,'bw_image');
bw_hols = fnd_hols(bw_ref);
axes(handles.ref_axes)
imshow(bw_ref)
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes as_referance wait for user response (see UIRESUME)
% uiwait(handles.as_referance);


% --- Outputs from this function are returned to the command line.
function varargout = as_referance_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;





% --- Executes on button press in store_pb.
function store_pb_Callback(hObject, eventdata, handles)
% hObject    handle to store_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bw_ref
global hols_box
global hols_num
global lins_box
global lins_num
uisave({'bw_ref','hols_box','lins_box'} ,'templet.mat')


function lins_edit_Callback(hObject, eventdata, handles)
% hObject    handle to lins_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=str2num(get(handles.lins_edit,'String'));
set(handles.lins_slider,'Value',val);
global bw_ref
global bw_hols_dilt
global bw_lins
axes(handles.ref_axes)
bw_lins=fnd_lins(bw_ref,bw_hols_dilt,val,val);
imshow(bw_lins)

% Hints: get(hObject,'String') returns contents of lins_edit as text
%        str2double(get(hObject,'String')) returns contents of lins_edit as a double


% --- Executes during object creation, after setting all properties.
function lins_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lins_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function lins_slider_Callback(hObject, eventdata, handles)
% hObject    handle to lins_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(handles.lins_slider,'Value');
set(handles.lins_edit,'String',num2str(val));
global bw_ref
global bw_hols_dilt
global bw_lins
axes(handles.ref_axes)
bw_lins=fnd_lins(bw_ref,bw_hols_dilt,val,val);
imshow(bw_lins)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function lins_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lins_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in get_lins_pb.
function get_lins_pb_Callback(hObject, eventdata, handles)
% hObject    handle to get_lins_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global lins_box
global lins_num
global bw_lins
[lins_box,lins_num]=fnd_lins2(bw_lins);


% --- Executes on slider movement.
function hols_slider_Callback(hObject, eventdata, handles)
% hObject    handle to hols_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = num2str(get(handles.hols_slider,'Value'));
set(handles.hols_edit,'String',val);


global bw_hols
global hols_box
global hols_num
global bw_hols_dilt
global bw_ref

[hols_box,hols_num,bw_hols_dilt]  = fnd_hols2(bw_hols,str2num(val));
imshow(bw_ref)
hold on;
for cnt = 1:hols_num
rectangle('position',hols_box(:,cnt),'edgecolor','r','curvature',[1,1]);
end
hold off
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function hols_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hols_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function hols_edit_Callback(hObject, eventdata, handles)
% hObject    handle to hols_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=str2num(get(handles.hols_edit,'String'));
set(handles.hols_slider,'Value',val);

global bw_hols
global hols_box
global hols_num
global bw_hols_dilt
global bw_ref

[hols_box,hols_num,bw_hols_dilt]  = fnd_hols2(bw_hols,val);
imshow(bw_ref)
hold on;
for cnt = 1:hols_num
rectangle('position',hols_box(:,cnt),'edgecolor','r','curvature',[1,1]);
end
hold off

% Hints: get(hObject,'String') returns contents of hols_edit as text
%        str2double(get(hObject,'String')) returns contents of hols_edit as a double


% --- Executes during object creation, after setting all properties.
function hols_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hols_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in get_hols_pb.
function get_hols_pb_Callback(hObject, eventdata, handles)
% hObject    handle to get_hols_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bw_ref
global bw_hols_dilt
global bw_lins
axes(handles.ref_axes)
bw_lins=fnd_lins(bw_ref,bw_hols_dilt,1,1);
imshow(bw_lins)



% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(as_referance,'Visible','off');
pcb_inspection;
