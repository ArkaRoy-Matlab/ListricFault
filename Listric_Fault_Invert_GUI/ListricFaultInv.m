% ***************************************************************
% *** Matlab GUI for inversion of fault plane from gravity data
% *** Source Code is mainly written for research purposes. The codes are
% *** having copyrights and required proper citations whenever it is used.
% *** Developed by:
% ***       Mr. Arka Roy (email: arka.phy@gmail.com)
% ***       Mr. Thatikonda Suresh Kumar (email: sureshkumarncess@gmail.com)
% ***       Mr. Rajat Kumar Sharma (email: rajat.sharma.mmm@gmail.com)
% ***       Solid Earth Research Group, National Centre for Earth Science Studies,
% ***       Ministry of Earth Sciences, Government of India
% ***       Thiruvanthapuram, Kerala, India
% ****************************************************************

function varargout = ListricFaultInv(varargin)
% LISTRICFAULTINV MATLAB code for ListricFaultInv.fig
%      LISTRICFAULTINV, by itself, creates a new LISTRICFAULTINV or raises the existing
%      singleton*.
%
%      H = LISTRICFAULTINV returns the handle to a new LISTRICFAULTINV or the handle to
%      the existing singleton*.
%
%      LISTRICFAULTINV('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LISTRICFAULTINV.M with the given input arguments.
%
%      LISTRICFAULTINV('Property','Value',...) creates a new LISTRICFAULTINV or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ListricFaultInv_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ListricFaultInv_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ListricFaultInv

% Last Modified by GUIDE v2.5 30-Sep-2021 14:44:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ListricFaultInv_OpeningFcn, ...
                   'gui_OutputFcn',  @ListricFaultInv_OutputFcn, ...
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

% --- Executes just before ListricFaultInv is made visible.
function ListricFaultInv_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ListricFaultInv (see VARARGIN)

% Choose default command line output for ListricFaultInv
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ListricFaultInv wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ListricFaultInv_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function obs_path_Callback(hObject, eventdata, handles)
% hObject    handle to obs_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of obs_path as text
%        str2double(get(hObject,'String')) returns contents of obs_path as a double
file_obs= get(hObject,'String');
x_obs=importdata(file_obs);


% --- Executes during object creation, after setting all properties.
function obs_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to obs_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function grv_path_Callback(hObject, eventdata, handles)
% hObject    handle to grv_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of grv_path as text
%        str2double(get(hObject,'String')) returns contents of grv_path as a double



% --- Executes during object creation, after setting all properties.
function grv_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to grv_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function density_fnc_Callback(hObject, eventdata, handles)
% hObject    handle to density_fnc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of density_fnc as text
%        str2double(get(hObject,'String')) returns contents of density_fnc as a double


% --- Executes during object creation, after setting all properties.
function density_fnc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to density_fnc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in obs_btn.
function obs_btn_Callback(hObject, eventdata, handles)
% hObject    handle to obs_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,filepath]=uigetfile({'*.*'},'File for Observation points');
fullname_obs=fullfile(filepath,filename);
set(handles.obs_path, 'string', fullname_obs);


% --- Executes on button press in grv_btn.
function grv_btn_Callback(hObject, eventdata, handles)
% hObject    handle to grv_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,filepath]=uigetfile({'*.*'},'File for Gravity Data');
fullname_fld=fullfile(filepath,filename);
set(handles.grv_path, 'string', fullname_fld);


% --- Executes when entered data in editable cell(s) in data_table.
function data_table_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to data_table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in data_load.
function data_load_Callback(hObject, eventdata, handles)
% hObject    handle to data_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file_obs= get(handles.obs_path,'String');
x_obs=importdata(file_obs);
file_data= get(handles.grv_path,'String');
data=importdata(file_data);
val=[x_obs data];
set(handles.data_table,'data',val)



function yspan_Callback(hObject, eventdata, handles)
% hObject    handle to yspan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yspan as text
%        str2double(get(hObject,'String')) returns contents of yspan as a double


% --- Executes during object creation, after setting all properties.
function yspan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yspan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function npop_Callback(hObject, eventdata, handles)
% hObject    handle to npop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of npop as text
%        str2double(get(hObject,'String')) returns contents of npop as a double


% --- Executes during object creation, after setting all properties.
function npop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to npop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c1_Callback(hObject, eventdata, handles)
% hObject    handle to c1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c1 as text
%        str2double(get(hObject,'String')) returns contents of c1 as a double


% --- Executes during object creation, after setting all properties.
function c1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c2_Callback(hObject, eventdata, handles)
% hObject    handle to c2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c2 as text
%        str2double(get(hObject,'String')) returns contents of c2 as a double


% --- Executes during object creation, after setting all properties.
function c2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxit_Callback(hObject, eventdata, handles)
% hObject    handle to maxit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxit as text
%        str2double(get(hObject,'String')) returns contents of maxit as a double


% --- Executes during object creation, after setting all properties.
function maxit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    cla(handles.axes4,'reset')
    cla(handles.axes3,'reset')
    cla(handles.axes5,'reset')
    cla(handles.axes1,'reset')
    
    str=get(handles.density_fnc,'String');
    str = vectorize(str);
    density = str2func(['@(z)' str]);
    file_obs= get(handles.obs_path,'String');
    x_obs=importdata(file_obs);
    file_data= get(handles.grv_path,'String');
    data=importdata(file_data);
    
    npop_str= get(handles.npop,'String');
    npop=str2num(npop_str);
    c1_str= get(handles.c1,'String');
    c1=str2num(c1_str);
    c2_str= get(handles.c2,'String');
    c2=str2num(c2_str);
    maxit_str= get(handles.maxit,'String');
    maxit=str2num(maxit_str);
    
    y_span=(x_obs(end)-x_obs(1))/2;
    z_obs=0;
    ss='Model Started Running';
    drawnow;
    set(handles.md_run,'string', ss)
    %Run Model for 10 times and taking best model out of this 10 independent runs
    for i=1:1
        %running independent model
        [x_data,y_data,best_cost,error_energy,tf]=Listric_Fault_Invert(x_obs,data,density,npop,c1,c2,maxit);
        %[x_l,z_l,x_h,z_h,best_cost,error_energy]=Fault_Invert(data,x_obs,z_obs,density,npop,c1,c2,maxit);
        %Saving data for all independent run
        xx_data(i,:)=x_data; yy_data(i,:)=y_data; bb_cost(i)=best_cost; err(i,:)=error_energy;
        %ss=sprintf('%d independent run finished.',i);
        %drawnow;
        %set(handles.md_run,'string', ss)
    end
    ss='Model Run finished';
    set(handles.md_run,'string',ss);
    %finding minimum of cost function
    [mm,id]=min(bb_cost);
    %outputs for best Model
    x_data=xx_data(id,:);y_data=yy_data(id,:); 
    bst_err=sqrt(squeeze(err(id,:)));
%% Plotting the estimated Fault structure   
                [t_leg,c_leg]=lgwt(10,0,1);
                %close polygonal form of depth profile 
                 x1(1:length(x_data)+2)=[x_data tf*inf tf*inf];
                 y1(1:length(y_data)+2)=[y_data y_data(end) y_data(1)];
                 %gravity field for given depth profile 
                 yy=tf*poly_gravityrho(x_obs,0,x1,y1,density,t_leg,c_leg);
                 handles.grv_data = yy;       %new
                 guidata(hObject, handles);   %new
        %Plotting the estimated gravity anomaly Fault structure
        
        axes(handles.axes1);
        
        plot(x_obs,data,'ro','Linewidth',2);
        hold on
        plot(x_obs,yy,'Linewidth',2)
        xlabel('Observation Points (m)')
        ylabel('Gravity Anomaly (mGal)')
        title('Gravity Anomaly plot')
        legend('Observed','Optimized','Location','best')
        xlim([x_obs(1) x_obs(end)])
        box on
        
        axes(handles.axes4);
        hold on
                   if tf==1
                        %plotting the inverted fault structure using patched surface
                        patch([x_data x_obs(end) x_obs(end) x_data(1)],[y_data y_data(end) y_data(1) y_data(1)],density([y_data y_data(end) y_data(1) y_data(1)]),'EdgeColor','k') ;
                        
                    else
                        %plotting the inverted fault structure using patched surface
                        patch([x_data x_obs(1) x_obs(1) x_data(1)],[y_data y_data(end) y_data(1) y_data(1)],density([y_data y_data(end) y_data(1) y_data(1)]),'EdgeColor','k') ;
                       
                    end
                %colormap for the surface plot
                colormap hsv
                %clim=[-1000 -400]; %colorbar axis limit in kg/m^3
                %positioning the color bar
                
                c = colorbar('southoutside');
                %colorbar labelling
                c.Label.String = 'Density contrast (kg/m^3)';
                %caxis(clim)
                %set(c,'visible','off')
                box on
                %reversing the axis
                set(gca,'Ydir','reverse')   
                %axis limit 
                xlim([x_obs(1) x_obs(end)])
                %ylim([0 5000])
        
                %axis labelling
                xlabel('Horizontal distance (m)')
                ylabel('Depth (m)')
                title('2D Listric Fault Structure')
            
    points_upper=sprintf('X = %f m and Z = %f m',x_data(1),y_data(1));
    set(handles.upper,'string', points_upper)
    
    points_lower=sprintf('X = %f m and Z = %f m',x_data(end),y_data(end));
    set(handles.lower,'string', points_lower)
    
    %RMSE of given model 
     RMSE_g=sqrt((sum((data-yy').^2))/length(data))/(max(data(:))-min(data(:)));
     set(handles.rmse,'string', num2str(RMSE_g))
    zz=linspace(0,max(y_data));
    den=density(zz)+0.*zz;
    
    axes(handles.axes3);
    cla()
    plot(den,zz,'Linewidth',2)
    set(gca,'Ydir','reverse')
    %set(gca,'Xdir','reverse')
    xlabel('Density contrast (kg/m^3)')
    ylabel('Depth (m)')
    title('Density contrast variation with depth')
    
    axes(handles.axes5);
    semilogy(1:length(bst_err),bst_err,'Linewidth',2)
    title('Objective function value for each iterations')
    ylabel('Objective function (mGal)')
    xlabel('Number of iterations')
    
    

% --- Executes on button press in push_fault.
function push_fault_Callback(hObject, eventdata, handles)
% hObject    handle to push_fault (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%2. Copy axes to new figure and save
        [filename,pathname] = uiputfile(...
                                     {'*.fig';'*.png';'*.jpg';'*.tif';'*.bmp';'*.*'}, ...
                                        'Save as');
        outputFileName = fullfile(pathname,filename);
        fignew = figure('Visible','on'); % Invisible figure
        newAxes = copyobj(handles.axes4,fignew); % Copy the appropriate axes
        colormap(fignew,hsv)
        %the plotting region
            c=colorbar('southoutside');
            %colorbar labelling
            c.Label.String = 'Density contrast (kg/m^3)';
        set(newAxes,'Position',get(groot,'DefaultAxesPosition')); % The original position is copied too, so adjust it.
        set(fignew,'CreateFcn','set(gcbf,''Visible'',''on'')'); % Make it visible upon loading
        hold on
        saveas(fignew,outputFileName);
        delete(fignew);
       


% --- Executes on button press in push_grav.
function push_grav_Callback(hObject, eventdata, handles)
% hObject    handle to push_grav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = uiputfile(...
                                     {'*.fig';'*.png';'*.jpg';'*.tif';'*.bmp';'*.*'}, ...
                                        'Save as');
        outputFileName = fullfile(pathname,filename);
        fignew1 = figure('Visible','on'); % Invisible figure
        newAxes1 = copyobj(handles.axes1,fignew1); % Copy the appropriate axes
        
        set(newAxes1,'Position',get(groot,'DefaultAxesPosition')); % The original position is copied too, so adjust it.
        set(fignew1,'CreateFcn','set(gcbf,''Visible'',''on'')'); % Make it visible upon loading
        hold on
        legend('Observed','Optimized','Location','best')
        saveas(fignew1,outputFileName);
        delete(fignew1);

% --- Executes on button press in push_density.
function push_density_Callback(hObject, eventdata, handles)
% hObject    handle to push_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = uiputfile(...
                                     {'*.fig';'*.png';'*.jpg';'*.tif';'*.bmp';'*.*'}, ...
                                        'Save as');
        outputFileName = fullfile(pathname,filename);
        fignew2 = figure('Visible','on'); % Invisible figure
        newAxes2 = copyobj(handles.axes3,fignew2); % Copy the appropriate axes
        
        set(newAxes2,'Position',get(groot,'DefaultAxesPosition')); % The original position is copied too, so adjust it.
        set(fignew2,'CreateFcn','set(gcbf,''Visible'',''on'')'); % Make it visible upon loading
        hold on
        saveas(fignew2,outputFileName);
        delete(fignew2);

% --- Executes on button press in push_rmse.
function push_rmse_Callback(hObject, eventdata, handles)
% hObject    handle to push_rmse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = uiputfile(...
                                     {'*.fig';'*.png';'*.jpg';'*.tif';'*.bmp';'*.*'}, ...
                                        'Save as');
        outputFileName = fullfile(pathname,filename);
        fignew3 = figure('Visible','on'); % Invisible figure
        newAxes3 = copyobj(handles.axes5,fignew3); % Copy the appropriate axes
        
        set(newAxes3,'Position',get(groot,'DefaultAxesPosition')); % The original position is copied too, so adjust it.
        set(fignew3,'CreateFcn','set(gcbf,''Visible'',''on'')'); % Make it visible upon loading
        hold on
        saveas(fignew3,outputFileName);
        delete(fignew3);
        

% --- Executes on button press in push_data.
function push_data_Callback(hObject, eventdata, handles)
% hObject    handle to push_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = uiputfile(...
                                     {'*.dat';'*.txt';'*.*'}, ...
                                        'Save as');
        
        zz=handles.grv_data;
        fnm = fullfile(pathname,filename);
        fid = fopen(fnm,'wt');
        fprintf(fid,'%.2f\n',zz);
        fclose(fid);
