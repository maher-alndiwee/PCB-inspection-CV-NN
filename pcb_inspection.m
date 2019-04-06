function varargout = pcb_inspection(varargin)
% PCB_INSPECTION M-file for pcb_inspection.fig
%      PCB_INSPECTION, by itself, creates a new PCB_INSPECTION or raises the existing
%      singleton*.
%
%      H = PCB_INSPECTION returns the handle to a new PCB_INSPECTION or the handle to
%      the existing singleton*.
%
%      PCB_INSPECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PCB_INSPECTION.M with the given input arguments.
%
%      PCB_INSPECTION('Property','Value',...) creates a new PCB_INSPECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pcb_inspection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pcb_inspection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pcb_inspection

% Last Modified by GUIDE v2.5 04-May-2012 00:48:07

% Begin initialization code - DO NOT EDIT


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pcb_inspection_OpeningFcn, ...
                   'gui_OutputFcn',  @pcb_inspection_OutputFcn, ...
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


% --- Executes just before pcb_inspection is made visible.
function pcb_inspection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pcb_inspection (see VARARGIN)

% Choose default command line output for pcb_inspection
handles.output = hObject;

clc 
set(handles.brightness_edit,'String',num2str(get(handles.brightness_slider,'Value')));
set(handles.sharpness_edit,'String',num2str(get(handles.sharpness_slider,'Value')));
set(handles.threshold_edit,'String',num2str(get(handles.threshold_slider,'Value')));
% Update handles structure
guidata(hObject, handles);
setappdata(0  , 'hMainGui'    , gcf);
axes(handles.image_axes)
cla




% UIWAIT makes pcb_inspection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pcb_inspection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in previwe.
function previwe_Callback(hObject, eventdata, handles)
% hObject    handle to previwe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.image_axes)

global h
global ss
%vid1 =  videoinput('winvideo', 2, 'RGB24_320x240'); % create video input object from the 1st source
vid1 = videoinput('winvideo', 2, 'YUY2_640x480');

h1 = image; % create image object
vid1.ReturnedColorSpace='rgb';  
axis ij % flip the image
h = preview(vid1,h1);
          % type of the returned image
%ss=getselectedsource(vid1);              %getting additional propertie

%ss.Brightness=get(handles.brightness_slider,'Value');        %or   set(gss,'Brightness',value);
%ss.Sharpness=get(handles.sharpness_slider,'Value');













% --- Executes on button press in snapshot.
function snapshot_Callback(hObject, eventdata, handles)
% hObject    handle to snapshot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global h
global  def_threshold 
global gray_im

aq_im=getimage(h);
%aq_im=im_rotation(aq_im1);
hMainGui = getappdata(0  , 'hMainGui');
setappdata(hMainGui, 'aq_im', aq_im);
                                               
 gray_im1=rgb2gray(aq_im);             
gray_im = medfilt2(gray_im1);
%se = strel('disk',2);
%gray_im = imdilate(gray_im2,se);
 [bw_im def_threshold] =imthresh(gray_im)            %finding the suitable threshold between [0,1] and /3 to make it better
 set(handles.threshold_edit,'String',num2str(def_threshold));
 set(handles.threshold_slider,'value',def_threshold);
axes(handles.image_axes)
imshow(aq_im)


% --- Executes on slider movement.
function brightness_slider_Callback(hObject, eventdata, handles)
% hObject    handle to brightness_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.brightness_edit,'String',num2str(get(handles.brightness_slider,'Value')));
global ss
ss.Brightness=get(handles.brightness_slider,'Value');        %or   set(gss,'Brightness',value);


% --- Executes during object creation, after setting all properties.
function brightness_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to brightness_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on slider movement.
function sharpness_slider_Callback(hObject, eventdata, handles)
% hObject    handle to sharpness_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.sharpness_edit,'String',num2str(get(handles.sharpness_slider,'Value')));
global ss
ss.Sharpness=get(handles.sharpness_slider,'Value');
% --- Executes during object creation, after setting all properties.
function sharpness_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sharpness_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function brightness_edit_Callback(hObject, eventdata, handles)
% hObject    handle to brightness_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of brightness_edit as text
%        str2double(get(hObject,'String')) returns contents of brightness_edit as a double
val = str2double(get(handles.brightness_edit,'String')); 

    set(handles.brightness_slider,'Value',val); 
global ss
ss.Brightness=get(handles.brightness_slider,'Value');        %or   set(gss,'Brightness',value);

% --- Executes during object creation, after setting all properties.
function brightness_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to brightness_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sharpness_edit_Callback(hObject, eventdata, handles)
% hObject    handle to sharpness_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sharpness_edit as text
%        str2double(get(hObject,'String')) returns contents of sharpness_edit as a double
val = str2double(get(handles.sharpness_edit,'String')); 

    set(handles.sharpness_slider,'Value',val); 
global ss
ss.Sharpness=get(handles.sharpness_slider,'Value');
% --- Executes during object creation, after setting all properties.
function sharpness_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sharpness_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function threshold_slider_Callback(hObject, eventdata, handles)
% hObject    handle to threshold_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val = num2str(get(handles.threshold_slider,'Value'));
set(handles.threshold_edit,'String',val);
  global threshold 
    threshold = str2num(val);
    global gray_im
thresholder = threshold/255;
axes(handles.image_axes)
bw_im =im2bw(gray_im,thresholder);
%se = strel('disk',0);
%bw_im = imdilate(bw_im1,se);
hMainGui = getappdata(0  , 'hMainGui');
setappdata(hMainGui, 'bw_image', bw_im);

imshow (bw_im)

% --- Executes during object creation, after setting all properties.
function threshold_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threshold_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function threshold_edit_Callback(hObject, eventdata, handles)
% hObject    handle to threshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of threshold_edit as text
%        str2double(get(hObject,'String')) returns contents of threshold_edit as a double
val = str2double(get(handles.threshold_edit,'String')); 

    set(handles.threshold_slider,'Value',val); 
    global threshold 
    threshold = val;
   
global gray_im
thresholder = threshold/255;
axes(handles.image_axes)
bw_im=im2bw(gray_im,thresholder);
hMainGui = getappdata(0  , 'hMainGui');
setappdata(hMainGui, 'bw_image', bw_im);
imshow (bw_im)


% --- Executes during object creation, after setting all properties.
function threshold_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function thresholding_button_Callback(hObject, eventdata, handles)
% hObject    handle to thresholding_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global def_threshold
global gray_im
thresholder = def_threshold/255;
axes(handles.image_axes)
bw_im=im2bw(gray_im,thresholder);
imshow (bw_im)
hMainGui = getappdata(0  , 'hMainGui');
setappdata(hMainGui, 'bw_image', bw_im);
 set(handles.threshold_edit,'String',num2str(def_threshold));
 set(handles.threshold_slider,'value',def_threshold);


% --- Executes on button press in as_referance_pb.
function as_referance_pb_Callback(hObject, eventdata, handles)
% hObject    handle to as_referance_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(pcb_inspection,'Visible','off');
as_referance;



% --- Executes on button press in as_tested_pb.
function as_tested_pb_Callback(hObject, eventdata, handles)
% hObject    handle to as_tested_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(pcb_inspection,'Visible','off');
as_tested;


% --- Executes on button press in load_pb.
function load_pb_Callback(hObject, eventdata, handles)
% hObject    handle to load_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global def_threshold
global gray_im
[name dir]=uigetfile({'*.jpg;*.jpeg;*.png;*.gif;*.bmp','All Image Files'});
if( name ~= 0)
full_name = [dir name];
aq_im =img_rotation( imread(full_name));
%aq_im =imread(full_name);
hMainGui = getappdata(0  , 'hMainGui');
setappdata(hMainGui, 'aq_im', aq_im);
 gray_im1=rgb2gray(aq_im);             %can be using "histeq(gray_im,n)" function.
gray_im = medfilt2(gray_im1);
%se = strel('disk',2);
%gray_im = imdilte(gray_im2,se);
 [bw_im def_threshold] =imthresh(gray_im);             %finding the suitable threshold between [0,1]
 def_threshold = def_threshold + 38;
 set(handles.threshold_edit,'String',num2str(def_threshold));
 set(handles.threshold_slider,'value',def_threshold);
axes(handles.image_axes)
imshow(aq_im)
end






% --- Executes on button press in as_training.
function as_training_Callback(hObject, eventdata, handles)
% hObject    handle to as_training (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(pcb_inspection,'Visible','off');
training;


% --- Executes on button press in trainsys_pb.
function trainsys_pb_Callback(hObject, eventdata, handles)
% hObject    handle to trainsys_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(pcb_inspection,'Visible','off');
training_system;


% --- Executes on button press in select1_pb.
function select1_pb_Callback(hObject, eventdata, handles)
% hObject    handle to select1_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('LVQ1.mat','Load the network LVQ1');
if FileName==0, return, end

strc = load( fullfile(PathName,FileName) );
cll=struct2cell(strc);
LVQ1=cll{1};
hMainGui = getappdata(0  , 'hMainGui');
setappdata(hMainGui,'LVQ1',LVQ1)


% --- Executes on button press in select2_pb.
function select2_pb_Callback(hObject, eventdata, handles)
% hObject    handle to select2_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('LVQ2.mat','Load the network LVQ2');
if FileName==0, return, end

strc = load( fullfile(PathName,FileName) );
cll=struct2cell(strc);
LVQ2=cll{1};

hMainGui = getappdata(0  , 'hMainGui');
setappdata(hMainGui,'LVQ2',LVQ2)


% --- Executes on button press in select3_pb.
function select3_pb_Callback(hObject, eventdata, handles)
% hObject    handle to select3_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('LVQ3.mat','Load the network LVQ3');
if FileName==0, return, end

strc = load( fullfile(PathName,FileName) );
cll=struct2cell(strc);
LVQ3=cll{1};

hMainGui = getappdata(0  , 'hMainGui');
setappdata(hMainGui,'LVQ3',LVQ3)


% --- Executes on button press in create1_pb.
function create1_pb_Callback(hObject, eventdata, handles)
% hObject    handle to create1_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,PathName] = uigetfile('init_data1.mat','load init data for LVQ1');
if FileName==0, return, end

strc = load( fullfile(PathName,FileName) );
cll=struct2cell(strc);
p1=cll{1};
t1=[1 2];
t=ind2vec(t1);

LVQ1= newlvq(p1,20,[.5 .5]);
LVQ1 = train(LVQ1,p1,t);
hMainGui = getappdata(0  , 'hMainGui');
setappdata(hMainGui,'LVQ1',LVQ1)

% --- Executes on button press in create2_pb.
function create2_pb_Callback(hObject, eventdata, handles)
% hObject    handle to create2_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('init_data2.mat','load init data for LVQ2');
if FileName==0, return, end

strc = load( fullfile(PathName,FileName) );
cll=struct2cell(strc);
p2=cll{1};
t2=[1 2 3];
t=ind2vec(t2);

LVQ2= newlvq(p2,40,[1/3 1/3 1/3]);
LVQ2 = train(LVQ2,p2,t);
hMainGui = getappdata(0  , 'hMainGui');
setappdata(hMainGui,'LVQ2',LVQ2)

% --- Executes on button press in create3_pb.
function create3_pb_Callback(hObject, eventdata, handles)
% hObject    handle to create3_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('init_data3.mat','load init data for LVQ3');
if FileName==0, return, end

strc = load( fullfile(PathName,FileName) );
cll=struct2cell(strc);
p3=cll{1};
t3=[1 2 3 4 5];
t=ind2vec(t3);

LVQ3= newlvq(p3,50,[.2 .2 .2 .2 .2]);
LVQ3 = train(LVQ3,p3,t);
hMainGui = getappdata(0  , 'hMainGui');
setappdata(hMainGui,'LVQ3',LVQ3)
