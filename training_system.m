function varargout = training_system(varargin)
% TRAINING_SYSTEM M-file for training_system.fig
%      TRAINING_SYSTEM, by itself, creates a new TRAINING_SYSTEM or raises the existing
%      singleton*.
%
%      H = TRAINING_SYSTEM returns the handle to a new TRAINING_SYSTEM or the handle to
%      the existing singleton*.
%
%      TRAINING_SYSTEM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRAINING_SYSTEM.M with the given input arguments.
%
%      TRAINING_SYSTEM('Property','Value',...) creates a new TRAINING_SYSTEM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before training_system_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to training_system_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help training_system

% Last Modified by GUIDE v2.5 05-May-2012 02:07:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @training_system_OpeningFcn, ...
                   'gui_OutputFcn',  @training_system_OutputFcn, ...
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


% --- Executes just before training_system is made visible.
function training_system_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to training_system (see VARARGIN)

% Choose default command line output for training_system
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(handles.epoch_edit,'String',num2str(get(handles.epoch_slider,'Value')));
% UIWAIT makes training_system wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global lod 
lod =0;

% --- Outputs from this function are returned to the command line.
function varargout = training_system_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load_training.
function load_training_Callback(hObject, eventdata, handles)
% hObject    handle to load_training (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global training_set
global smpl_num
global lod
[FileName,PathName] = uigetfile('training set.mat','Load training data');
if FileName==0, return, end

Struct1 = load( fullfile(PathName,FileName) );
c = struct2cell(Struct1);
 training_set = c{1};
 smpl_num = c{2};
set(handles.text4, 'String', 'the training data have been loaded successfully.')
 lod =1;



% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global lod
global training_set
global smpl_num
L1=get(handles.lvq1_chk,'Value');
L2=get(handles.lvq2_chk,'Value');
L3=get(handles.lvq3_chk,'Value');
if((L1 || L2 || L3 )&& lod)
 hMainGui = getappdata(0, 'hMainGui');
 LVQ1=getappdata(hMainGui,'LVQ1');
  LVQ2=getappdata(hMainGui,'LVQ2');
   LVQ3=getappdata(hMainGui,'LVQ3');
   Epochs=get(handles.epoch_slider,'Value');
 [T_LVQ1,T_LVQ2,T_LVQ3,c1,c2,c3] = Train_LVQ(LVQ1,LVQ2,LVQ3,training_set,smpl_num,Epochs,L1,L2,L3);
 c1 = c1 -1;
 c2 = c2 -1;
 c3= c3 -1;
 setappdata(hMainGui,'LVQ1',T_LVQ1);
 setappdata(hMainGui,'LVQ2',T_LVQ2);
 setappdata(hMainGui,'LVQ3',T_LVQ3);
 if(c1 && c2 && c3 && L1 && L2 && L3)
 set(handles.text4,'String','Traing completed successfully for LVQ1 and LVQ2 and LVQ3.')
 elseif(c1 && c2 && L1 && L2)
     set(handles.text4,'String','Traing completed successfully for LVQ1 and LVQ2.')

 elseif(c2 && c3 && L2 && L3)
     set(handles.text4,'String','Traing completed successfully for LVQ2 and LVQ3.')

 elseif(c1 && c3 && L1 && L3)
     
     set(handles.text4,'String','Traing completed successfully for LVQ1 and LVQ3.')
 elseif(c1 && L1)
     
     set(handles.text4,'String','Traing completed successfully for LVQ1.')
 elseif(c2 && L2)
     
     set(handles.text4,'String','Traing completed successfully for LVQ2.')
 elseif(c3 && L3)
     
     set(handles.text4,'String','Traing completed successfully for LVQ3.')
 end
elseif(lod == 0)
    set(handles.text4,'String','pleas load valid training data.')
else  
set(handles.text4,'String','pleas select one or mor from the LVQs.')
end
% --- Executes on slider movement.
function epoch_slider_Callback(hObject, eventdata, handles)
% hObject    handle to epoch_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.epoch_edit,'String',num2str(get(handles.epoch_slider,'Value')));

% --- Executes during object creation, after setting all properties.
function epoch_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epoch_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function epoch_edit_Callback(hObject, eventdata, handles)
% hObject    handle to epoch_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of epoch_edit as text
%        str2double(get(hObject,'String')) returns contents of epoch_edit as a double
set(handles.epoch_slider,'Value',str2num(get(handles.epoch_edit,'String')));

% --- Executes during object creation, after setting all properties.
function epoch_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epoch_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in lvq1_chk.
function lvq1_chk_Callback(hObject, eventdata, handles)
% hObject    handle to lvq1_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lvq1_chk


% --- Executes on button press in lvq2_chk.
function lvq2_chk_Callback(hObject, eventdata, handles)
% hObject    handle to lvq2_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lvq2_chk


% --- Executes on button press in lvq3_chk.
function lvq3_chk_Callback(hObject, eventdata, handles)
% hObject    handle to lvq3_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lvq3_chk


% --- Executes on button press in back_pb.
function back_pb_Callback(hObject, eventdata, handles)
% hObject    handle to back_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(gcf,'Visible','off')
pcb_inspection;


% --- Executes on button press in save_lvq_pb.
function save_lvq_pb_Callback(hObject, eventdata, handles)
% hObject    handle to save_lvq_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
L1=get(handles.lvq1_chk,'Value');
L2=get(handles.lvq2_chk,'Value');
L3=get(handles.lvq3_chk,'Value');

 hMainGui = getappdata(0, 'hMainGui');
 if (L1)
 LVQ1=getappdata(hMainGui,'LVQ1');
 uisave('LVQ1','LVQ1 net.mat')
 end
 if(L2)
  LVQ2=getappdata(hMainGui,'LVQ2');
  uisave('LVQ2','LVQ2 net.mat')
 end
 if(L3)
     
   LVQ3=getappdata(hMainGui,'LVQ3');
   uisave('LVQ3','LVQ3 net.mat')
 end
