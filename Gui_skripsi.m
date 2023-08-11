function varargout = Gui_skripsi(varargin)
% GUI_SKRIPSI MATLAB code for Gui_skripsi.fig
%      GUI_SKRIPSI, by itself, creates a new GUI_SKRIPSI or raises the existing
%      singleton*.
%
%      H = GUI_SKRIPSI returns the handle to a new GUI_SKRIPSI or the handle to
%      the existing singleton*.
%
%      GUI_SKRIPSI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SKRIPSI.M with the given input arguments.
%
%      GUI_SKRIPSI('Property','Value',...) creates a new GUI_SKRIPSI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gui_skripsi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gui_skripsi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gui_skripsi

% Last Modified by GUIDE v2.5 14-Mar-2023 14:46:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gui_skripsi_OpeningFcn, ...
                   'gui_OutputFcn',  @Gui_skripsi_OutputFcn, ...
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


% --- Executes just before Gui_skripsi is made visible.
function Gui_skripsi_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);

ax = axes('unit', 'normalized', 'position', [0 0 1 1]);
background = imread('gambar.jpg'); imagesc(background);
set(ax,'handlevisibility','off','visible','off');
uistack(ax,'bottom');


% --- Outputs from this function are returned to the command line.
function varargout = Gui_skripsi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile ({'*.jpg';'*.png';'*.*'});
if ~isequal (filename,0)
    handles.data1 = imread(fullfile(pathname, filename));
    guidata(hObject,handles);
    axes(handles.axes1);
    imshow(handles.data1);
    title('Citra Asli');
else
    return
end

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
img = handles.data1;
idMode = get(hObject, 'value');
if idMode == 1
    
elseif idMode == 2
    axes(handles.axes2);
    gray = rgb2gray(img);
    imshow(gray), title('Citra Grayscale');
elseif idMode == 3
    axes(handles.axes3);
    gray = rgb2gray(img);
    edrob = edge(gray,'roberts');
    imshow(edrob), title('Robert');
elseif idMode == 4
    axes(handles.axes4);
    gray = rgb2gray(img);
    edpre = edge(gray,'prewitt');
    imshow(edpre), title('Prewitt');
elseif idMode == 5
    gray = rgb2gray(img);
    edrob =edge(gray,'roberts');
    edpre =edge(gray,'prewitt');
    akurasi = sum(edrob(:) == edpre(:)) / numel(edrob);
   textbox = uicontrol('Style', 'text',...
                    'String','',...
                    'Position', [300 60 300 30]);
 set(textbox,'FontSize',15,'FontName','Times New Roman', 'String', sprintf('Tingkat Akurasi: %.2f%%', akurasi * 100));
   
end


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
