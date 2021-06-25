function varargout = D_123190094_SAW(varargin)
% D_123190094_SAW MATLAB code for D_123190094_SAW.fig
%      D_123190094_SAW, by itself, creates a new D_123190094_SAW or raises the existing
%      singleton*.
%
%      H = D_123190094_SAW returns the handle to a new D_123190094_SAW or the handle to
%      the existing singleton*.
%
%      D_123190094_SAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in D_123190094_SAW.M with the given input arguments.
%
%      D_123190094_SAW('Property','Value',...) creates a new D_123190094_SAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before D_123190094_SAW_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to D_123190094_SAW_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help D_123190094_SAW

% Last Modified by GUIDE v2.5 25-Jun-2021 23:31:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @D_123190094_SAW_OpeningFcn, ...
                   'gui_OutputFcn',  @D_123190094_SAW_OutputFcn, ...
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


% --- Executes just before D_123190094_SAW is made visible.
function D_123190094_SAW_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to D_123190094_SAW (see VARARGIN)

% Choose default command line output for D_123190094_SAW
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes D_123190094_SAW wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = D_123190094_SAW_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in proses.
function proses_Callback(hObject, eventdata, handles)
% hObject    handle to proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('DATA_RUMAH.xlsx');
opts.SelectedVariableNames = (3:8);
tabeldata = readtable('DATA_RUMAH.xlsx',opts);
input = table2cell(tabeldata);
dataX = table2array(tabeldata);

k=[0,1,1,1,1,1];%merupakan nilai atribut, dimana 1= atribut keuntungan dan 0= biaya
w= [0.3 0.2 0.23 0.1 0.07 0.1] % bobot tiap kriteria
%normalisasi matrik
[m n]=size (dataX); %matriks m x n dengan ukuran sebanyak variabel x(input)
R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong

for j=1:n,
if k(j)==1, %statement untuk kriteria dengan atribut keuntungan
    R(:,j)=dataX(:,j)./max(dataX(:,j));
else
    R(:,j)=min(dataX(:,j))./dataX(:,j);
    end;
end;
for i=1:m,
    V(i)= sum(w.*R(i,:));
end;

%mencari 20 rumah yang paling sesuai
opts1 = detectImportOptions('DATA_RUMAH.xlsx');
opts1.SelectedVariableNames = ([1,3:8]);
inputX1 = readtable('DATA_RUMAH.xlsx', opts1); %menginput data berdasarkan kriteria
input1 = table2cell(inputX1);
V = V.';
V = num2cell(V);
hasil = {input1; V};
hasil = horzcat(hasil{:});
hasilrank = sortrows(hasil, 8, 'descend');
ranked = hasilrank(1:20,:);
set(handles.uitable2,'Data',ranked); %menampilkan hasil perhitungan ke table gui

% --- Executes on button press in tampil.
function tampil_Callback(hObject, eventdata, handles)
% hObject    handle to tampil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ReadData = xlsread('DATA_RUMAH.xlsx','sheet1','C1:H1011'); %membaca file excel DATA_RUMAH,beserta nama sheet dan range data
set(handles.uitable1,'Data',ReadData); %menampilkan pada uitable1
