function varargout = training(varargin)
% TRAINING M-file for training.fig
%      TRAINING, by itself, creates a new TRAINING or raises the existing
%      singleton*.
%
%      H = TRAINING returns the handle to a new TRAINING or the handle to
%      the existing singleton*.
%
%      TRAINING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRAINING.M with the given input arguments.
%
%      TRAINING('Property','Value',...) creates a new TRAINING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before training_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to training_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help training

% Last Modified by GUIDE v2.5 16-Apr-2012 01:17:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @training_OpeningFcn, ...
                   'gui_OutputFcn',  @training_OutputFcn, ...
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


% --- Executes just before training is made visible.
function training_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to training (see VARARGIN)
global bw_tst
global aq_im
% Choose default command line output for training
handles.output = hObject;
hMainGui = getappdata(0, 'hMainGui');
bw_tst = getappdata(hMainGui,'bw_image');
aq_im = getappdata(hMainGui,'aq_im');
axes(handles.tst_axes)
imshow(aq_im)
set(handles.tst_axes,'NextPlot','replace');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes training wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = training_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in back_pb.
function back_pb_Callback(hObject, eventdata, handles)
% hObject    handle to back_pb (see GCBO)
% eventdata  reserved - to be defined in a f

% handles    structure with handles and user data (see GUIDATA)b
set(training,'Visible','off');
pcb_inspection;


% --- Executes on button press in load_pb.
function load_pb_Callback(hObject, eventdata, handles)
% hObject    handle to load_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global bw_ref
global hols_box
global lins_box
[FileName,PathName] = uigetfile('templte.mat','Select mat file');
if FileName==0, return, end

Struct1 = load( fullfile(PathName,FileName) );
c = struct2cell(Struct1);
 bw_ref = c{1};
 hols_box = c{2};
 lins_box = c{3};
 


% --- Executes on button press in inspect_pb.
function inspect_pb_Callback(hObject, eventdata, handles)
% hObject    handle to inspect_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global hols_box
global lins_box
global bw_ref
global bw_tst
global defacts_pat_pos
global count
global def_box
global smpl_num 
global bw_def
global training_set


 smpl_num =1;
set(handles.tst_axes,'NextPlot','add');
[bw_def def_box] = fnd_def(bw_ref,bw_tst);
 x= size(def_box);
def_num = x(2);
defacts_pat_pos = cell(def_num,2);

 defacts_pat_pos = scan_def_pos(def_box,hols_box,lins_box);
for def_id=1:def_num
 %   pat_num = defacts_pat_pos{def_id,2};
    pat_pos = defacts_pat_pos{def_id,1};
  
    % for pat=1:pat_num;
     %    def_type=def_classifier(pat_pos{pat,1},pat_pos{pat,2},pat_pos{pat,3},def_id);
      %   pat_pos{pat,4}= def_type;
     end
     %defacts_pat_pos{def_id,1} = pat_pos;
%end
training_set= cell(3*def_num,3);
 count = 1;
% --- Executes on button press in save_pb.
function save_pb_Callback(hObject, eventdata, handles)
% hObject    handle to save_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global training_set
global smpl_num
smpl_num = smpl_num - 1;
for i =1:smpl_num
    figure,imshow(training_set{i,1})
end
uisave({'training_set','smpl_num'},'training set.mat')

% --- Executes on button press in next_pb.
function next_pb_Callback(hObject, eventdata, handles)
% hObject    handle to next_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count
global aq_im
global defacts_pat_pos
global def_box
global hols_box
global lins_box
global aq_im
siz=size(def_box);
def_num = siz(2);
axes(handles.tst_axes)

if (count == def_num)
    count =1;
else
count = count + 1;
end

if(def_num~=0)
cla
pat_pos = defacts_pat_pos{count,1};
pat_num = defacts_pat_pos{count,2};

imshow(aq_im)
rectangle('position',def_box(:,count),'edgecolor','r');
if (pat_num > 0)
for pat=1:pat_num
 if (strcmp(pat_pos{pat,1},'hole'))
    rectangle('position',hols_box(:,pat_pos{pat,2}),'edgecolor','g','curvature',[1,1]);
 else
     rectangle('position',lins_box(:,pat_pos{pat,2}),'edgecolor','b');
 end

end
end
  
  
   
end


% --- Executes on button press in previous_pb.
function previous_pb_Callback(hObject, eventdata, handles)
% hObject    handle to previous_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count
global aq_im
global defacts_pat_pos
global def_box
global hols_box
global lins_box

siz=size(def_box);
def_num = siz(2);
axes(handles.tst_axes)


if (count <= 1)
    count = def_num;
else
count = count - 1;
end
if(def_num~=0)
cla
pat_pos = defacts_pat_pos{count,1};
pat_num = defacts_pat_pos{count,2};

imshow(aq_im)
rectangle('position',def_box(:,count),'edgecolor','r');
if (pat_num > 0)
for pat=1:pat_num
 if (strcmp(pat_pos{pat,1},'hole'))
    rectangle('position',hols_box(:,pat_pos{pat,2}),'edgecolor','g','curvature',[1,1]);
 else
     rectangle('position',lins_box(:,pat_pos{pat,2}),'edgecolor','b');
 end

end
end




end


% --- Executes on selection change in def_poup.
function def_poup_Callback(hObject, eventdata, handles)
% hObject    handle to def_poup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global def_type
global net_id
global def_val
def_val=get(handles.def_poup,'Value');
switch def_val
    case 1
       def_type = 1;
       net_id=1;
    case 2
        def_type = 2;
        net_id=1;
    case 3
        def_type = 1;
        net_id =2;
    case 4
        def_type = 2;
        net_id =2;
    case 5
        def_type = 3;
        net_id = 2;
    case 6
        def_type = 1;
        net_id = 3;
    case 7
        def_type = 2;
        net_id = 3;
    case 8
        def_type = 3;
        net_id = 3;
    case 9
        def_type = 4;
        net_id = 3;
    case 10 
        def_type = 5;
        net_id = 3;
       otherwise
        def_type = 0;
        net_id = 0;
end

% Hints: contents = cellstr(get(hObject,'String')) returns def_poup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from def_poup


% --- Executes during object creation, after setting all properties.
function def_poup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to def_poup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in get_pb.
function get_pb_Callback(hObject, eventdata, handles)
% hObject    handle to get_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global def_box
global hols_box
global lins_box
global bw_ref
global bw_tst
global bw_def
global def_val
global count
global training_set 
global def_type
global net_id

global smpl_num 
global defacts_pat_pos
if(def_val ==1)
   training_set{smpl_num,1} = imcrop(bw_ref,def_box(:,count));
    training_set{smpl_num,2} = def_type;
     training_set{smpl_num,3} = net_id; 
     smpl_num = smpl_num +1;
elseif((def_val ==2)||(def_val ==9)||(def_val ==10))
    training_set{smpl_num,1} = imcrop(bw_def,def_box(:,count));
     training_set{smpl_num,2} = def_type;
     training_set{smpl_num,3} = net_id; 
      smpl_num = smpl_num +1;
    elseif((def_val ==6)||(def_val ==7)||(def_val ==8))
        pat_pos = defacts_pat_pos{count,1};
pat_num = defacts_pat_pos{count,2};


if (pat_num > 0)
for pat=1:pat_num
 if (strcmp(pat_pos{pat,1},'line'))
 training_set{smpl_num,1}= imcrop(bw_tst ,lins_box(:,pat_pos{pat,2}));
  training_set{smpl_num,2} = def_type;
     training_set{smpl_num,3} = net_id; 
  smpl_num = smpl_num +1;
 end
end
end

elseif((def_val ==3)||(def_val ==4)||(def_val ==5))
  
    pat_pos = defacts_pat_pos{count,1};
pat_num = defacts_pat_pos{count,2};


if (pat_num > 0)
for pat=1:pat_num
 if (strcmp(pat_pos{pat,1},'hole'))
 training_set{smpl_num,1}= imcrop(bw_def ,hols_box(:,pat_pos{pat,2}));
  training_set{smpl_num,2} = def_type;
     training_set{smpl_num,3} = net_id; 
  smpl_num = smpl_num +1;

 end

end
end
end
