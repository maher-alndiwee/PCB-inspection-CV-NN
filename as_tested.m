function varargout = as_tested(varargin)
% AS_TESTED M-file for as_tested.fig
%      AS_TESTED, by itself, creates a new AS_TESTED or raises the existing
%      singleton*.
%
%      H = AS_TESTED returns the handle to a new AS_TESTED or the handle to
%      the existing singleton*.
%
%      AS_TESTED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AS_TESTED.M with the given input arguments.
%
%      AS_TESTED('Property','Value',...) creates a new AS_TESTED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before as_tested_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to as_tested_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help as_tested

% Last Modified by GUIDE v2.5 05-May-2012 01:49:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @as_tested_OpeningFcn, ...
                   'gui_OutputFcn',  @as_tested_OutputFcn, ...
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


% --- Executes just before as_tested is made visible.
function as_tested_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to as_tested (see VARARGIN)
global bw_tst
global aq_im
% Choose default command line output for as_tested
handles.output = hObject;
hMainGui = getappdata(0, 'hMainGui');
bw_tst = getappdata(hMainGui,'bw_image');
aq_im = getappdata(hMainGui,'aq_im');
axes(handles.tst_axes)
imshow(aq_im)
set(handles.tst_axes,'NextPlot','replace');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes as_tested wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = as_tested_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in back_pb.
function back_pb_Callback(hObject, eventdata, handles)
% hObject    handle to back_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(as_tested,'Visible','off');
pcb_inspection;


% --- Executes on button press in load_pb.
function load_pb_Callback(hObject, eventdata, handles)
% hObject    handle to load_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global bw_ref
global hols_box
global lins_box
[FileName,PathName] = uigetfile('*.mat','Select mat file');
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
global defects_pat_pos
global count
global def_box
hMainGui = getappdata(0  , 'hMainGui');
LVQ1 = getappdata(hMainGui,'LVQ1');
hMainGui = getappdata(0  , 'hMainGui');
LVQ2 = getappdata(hMainGui,'LVQ1');
hMainGui = getappdata(0  , 'hMainGui');
LVQ3 = getappdata(hMainGui,'LVQ3');
set(handles.tst_axes,'NextPlot','add');
[bw_def def_box] = fnd_def(bw_ref,bw_tst);
 x= size(def_box);
def_num = x(2)
%defects_pat_pos = cell(def_num,2);

 defects_pat_pos = scan_def_pos(def_box,hols_box,lins_box);
 
for def_id=1:def_num
   pat_num = defects_pat_pos{def_id,2};
    pat_pos = defects_pat_pos{def_id,1};
  for pat=1:5:pat_num;
     
 def_type=def_classifier(pat_pos{pat,1},pat_pos{pat,2},pat_pos{pat,3},def_id,LVQ1,LVQ2,LVQ3,bw_ref,bw_tst,bw_def,lins_box,hols_box,def_box);
      pat_pos{pat,4}= def_type;
    end
    defects_pat_pos{def_id,1} = pat_pos;
end
 count = 1;
% --- Executes on button press in save_pb.
function save_pb_Callback(hObject, eventdata, handles)
% hObject    handle to save_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global defects_pat_pos
uisave('defects_pat_pos','pcb_profile.mat')

% --- Executes on button press in next_pb.
function next_pb_Callback(hObject, eventdata, handles)
% hObject    handle to next_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count
global aq_im
global defects_pat_pos
global def_box
global hols_box
global lins_box

siz=size(def_box);
def_num = siz(2);
axes(handles.tst_axes)

if (count == def_num)
    count =1;
else
count = count + 1;
end
 
if((def_num~=0) && (defects_pat_pos{count,2}~= 0)) 
cla
pat_pos = defects_pat_pos{count,1}
pat_num = defects_pat_pos{count,2};
def_type = pat_pos{:,4}

imshow(aq_im)
rectangle('position',def_box(:,count),'edgecolor','r');
if (pat_num > 0)
for pat=1:pat_num
 if (strcmp(pat_pos{pat,1},'hole'))
    rectangle('position',hols_box(:,pat_pos{pat,2}),'edgecolor','g','curvature',[1,1]);
 else
     rectangle('position',lins_box(:,pat_pos{pat,2}),'edgecolor','b');
 end
  
    set(handles.def_nots, 'String',def_type)
end
end

elseif(def_num == 0)
  
  
    set(handles.def_nots, 'String', 'there is n`t any defact')
end


% --- Executes on button press in previous_pb.
function previous_pb_Callback(hObject, eventdata, handles)
% hObject    handle to previous_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count
global aq_im
global defects_pat_pos
global def_box
global hols_box
global lins_box
global aq_im
siz=size(def_box);
def_num = siz(2);
axes(handles.tst_axes)


if (count <= 1)
    count = def_num;
else
count = count - 1;
end
if((def_num~=0) && (defects_pat_pos{count,2}~= 0)) 
cla
pat_pos = defects_pat_pos{count,1};
pat_num = defects_pat_pos{count,2};
def_type = pat_pos{:,4};
imshow(aq_im)
rectangle('position',def_box(:,count),'edgecolor','r');
if (pat_num > 0)
for pat=1:pat_num
 if (strcmp(pat_pos{pat,1},'hole'))
    rectangle('position',hols_box(:,pat_pos{pat,2}),'edgecolor','g','curvature',[1,1]);
 else
     rectangle('position',lins_box(:,pat_pos{pat,2}),'edgecolor','b');
 end
 set(handles.def_nots, 'String',def_type)
end
end


elseif(def_num == 0)
  
  
    set(handles.def_nots, 'String', 'there is n`t any defact')

end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
