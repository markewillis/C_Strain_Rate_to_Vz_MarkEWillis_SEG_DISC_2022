function varargout = C_Strain_Rate_to_VZ_MarkEWillis_SEG_DISC_2022(varargin)
%
% This gui allows the conversion of strain rate wavelets to particle velocity
%
%
% ***********************************************************************************************************
% MIT License
% 
% Copyright (c) 2022 Mark E. Willis
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
%
% **********************************************************************************************************
%
% C_STRAIN_RATE_TO_VZ_MARKEWILLIS_SEG_DISC_2022 MATLAB code for C_Strain_Rate_to_VZ_MarkEWillis_SEG_DISC_2022.fig
%      C_STRAIN_RATE_TO_VZ_MARKEWILLIS_SEG_DISC_2022, by itself, creates a new C_STRAIN_RATE_TO_VZ_MARKEWILLIS_SEG_DISC_2022 or raises the existing
%      singleton*.
%
%      H = C_STRAIN_RATE_TO_VZ_MARKEWILLIS_SEG_DISC_2022 returns the handle to a new C_STRAIN_RATE_TO_VZ_MARKEWILLIS_SEG_DISC_2022 or the handle to
%      the existing singleton*.
%
%      C_STRAIN_RATE_TO_VZ_MARKEWILLIS_SEG_DISC_2022('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in C_STRAIN_RATE_TO_VZ_MARKEWILLIS_SEG_DISC_2022.M with the given input arguments.
%
%      C_STRAIN_RATE_TO_VZ_MARKEWILLIS_SEG_DISC_2022('Property','Value',...) creates a new C_STRAIN_RATE_TO_VZ_MARKEWILLIS_SEG_DISC_2022 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before C_Strain_Rate_to_VZ_MarkEWillis_SEG_DISC_2022_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to C_Strain_Rate_to_VZ_MarkEWillis_SEG_DISC_2022_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help C_Strain_Rate_to_VZ_MarkEWillis_SEG_DISC_2022

% Last Modified by GUIDE v2.5 09-Jul-2022 16:59:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @C_Strain_Rate_to_VZ_MarkEWillis_SEG_DISC_2022_OpeningFcn, ...
                   'gui_OutputFcn',  @C_Strain_Rate_to_VZ_MarkEWillis_SEG_DISC_2022_OutputFcn, ...
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


% --- Executes just before C_Strain_Rate_to_VZ_MarkEWillis_SEG_DISC_2022 is made visible.
function C_Strain_Rate_to_VZ_MarkEWillis_SEG_DISC_2022_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to C_Strain_Rate_to_VZ_MarkEWillis_SEG_DISC_2022 (see VARARGIN)

% Choose default command line output for C_Strain_Rate_to_VZ_MarkEWillis_SEG_DISC_2022
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes C_Strain_Rate_to_VZ_MarkEWillis_SEG_DISC_2022 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global TIparams

TIparams.f0       = 70;
TIparams.gl       = 15;
TIparams.velocity = 2000;


% --- Outputs from this function are returned to the command line.
function varargout = C_Strain_Rate_to_VZ_MarkEWillis_SEG_DISC_2022_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_run.
function pushbutton_run_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TIparams

model.velocity = TIparams.velocity;
model.z0       = TIparams.velocity;
model.f0       = TIparams.f0;
model.GL       = TIparams.gl;

model.dt       = 0.0001;
model.nsamples = 20000;
model.time     = (1:model.nsamples)*model.dt;
model.amps     = 1;

sim          = createSimulations(model);

lw = 2;

period = 1.0/TIparams.f0 * 2;
trange = [-1 1]*period + 1.;

% plot out the strain rate data
plot(handles.axes_input,sim.time,sim.strainRate,'k','linewidth',lw)
title('Strain Rate (5m)','fontsize',16,'fontweight','bold')
set(handles.axes_input,'fontsize',16,'fontweight','bold')
xlim(handles.axes_input,trange)
xlabel(handles.axes_input,'Time (s)')
title(handles.axes_input,'Strain Rate','fontsize',16,'fontweight','bold')
maxV = max(abs(sim.strainRate));
ylim(handles.axes_input,[-1 1]*maxV)


plot(handles.axes_output,sim.time,sim.Vz,'k','linewidth',lw)
hold(handles.axes_output,'on')
plot(handles.axes_output,sim.time,sim.vzFromDAS,'r','linewidth',lw)
title(handles.axes_output,'Vz (black), Vz from DAS (red)','fontsize',16,'fontweight','bold')
set(handles.axes_output,'fontsize',16,'fontweight','bold')
xlim(handles.axes_output,trange)
hold(handles.axes_output,'off')
xlabel(handles.axes_output,'Time (s)')
maxV = max(abs(sim.Vz));
ylim(handles.axes_output,[-1 1]*maxV)


function edit_velocity_Callback(hObject, eventdata, handles)
% hObject    handle to edit_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_velocity as text
%        str2double(get(hObject,'String')) returns contents of edit_velocity as a double

global TIparams

value = str2double(get(hObject,'String'));

if isnan(value) || value < 100 || value > 50000
    % not a number or out of range return to default value
    set(hObject,'String',num2str(TIparams.velocity))
    return
end

TIparams.velocity = value;

% --- Executes during object creation, after setting all properties.
function edit_velocity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_f0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f0 as text
%        str2double(get(hObject,'String')) returns contents of edit_f0 as a double

global TIparams

value = str2double(get(hObject,'String'));

if isnan(value) || value < .01 || value > 500
    % not a number or out of range return to default value
    set(hObject,'String',num2str(TIparams.f0))
    return
end

TIparams.f0 = value;

% --- Executes during object creation, after setting all properties.
function edit_f0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_gl_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gl as text
%        str2double(get(hObject,'String')) returns contents of edit_gl as a double

global TIparams

value = str2double(get(hObject,'String'));

if isnan(value) || value < .01 || value > 500
    % not a number or out of range return to default value
    set(hObject,'String',num2str(TIparams.gl))
    return
end

TIparams.gl = value;

% --- Executes during object creation, after setting all properties.
function edit_gl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
