function varargout = mt_basic_gui(varargin)
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% TEMPLATE MATLAB
%==========================================================================
% FILENAME: mt_basic_gui.m
% PATH    : $TEMPLATE_HOME$\src\gui
%==========================================================================
% ABSTRACT: Matlab template software basic HMI interface callbacks
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES       	AROB@S      19/06/2014  Creation
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   varargin	: command line arguments to gst_main_gui (see VARARGIN)
%==========================================================================
% OUTPUT:
%   varargout  	:  cell array for returning output args (see VARARGOUT)
%==========================================================================

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mt_basic_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @mt_basic_gui_OutputFcn, ...
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
%==========================================================================

function mt_basic_gui_OpeningFcn(hObject, ~, handles, varargin)
%==========================================================================
%% DESCRIPTION: Initialize the TEMPLATE main interface
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   hObject     : handle to figure
%   eventdata   : reserved - to be defined in a future version of MATLAB
%   handles     : structure with handles and user data (see GUIDATA)
%   varargin    : command line arguments to mt_main_gui (see VARARGIN)
%==========================================================================
% OUTPUT:
%==========================================================================
try
    
    % Initialize local variable
    % -------------------------
    parent_figure_handle = 0;
    
    % Manage input arguments
    % ----------------------
    if nargin > 0
        
        for i_arg = 1:length(varargin)
            
            if ishandle(varargin{1}); parent_figure_handle = varargin{1}; end;
            
        end
    
    end
    
    % Save ParentFigHdl
    % -----------------
    setappdata(handles.FgBasic, 'ParentFigHdl', parent_figure_handle);
    
    % Manage interface standard behaviour using cGuiManager object
    % ------------------------------------------------------------
    % Define the gui manager object
    gui_manager = cGuiManager('figure_name', ...
        strrep(mfilename, '_gui', ''), 'current_figure_handle', ...
        handles.FgBasic, 'parent_figure_handle', parent_figure_handle);

    % Update handles structure in case of languages and screensize menu
    % creation
    handles = guihandles(handles.FgBasic);
    
    % Save gui_manager object into the handles structure
    handles.gui_fcn = gui_manager;

    % Choose default command line output for mt_main_gui
    handles.output = hObject;

    % Initialize interface objects
    % ----------------------------
    % Set standard callback functions (Close with cross)
    set(handles.FgBasic, 'CloseRequestFcn', @LocalClose);

    % Set Default skin
    handles.gui_fcn.setSkin('default');
    
    % Update handles structure
    % ------------------------
    guidata(hObject, handles);

    % Initialize interface
    % --------------------
    % Data
    LocalUpdateDisplay('initialization');
    
    % graphical object
    LocalUpdateObjects('initialization');
        
catch exception
   
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================

function varargout = mt_basic_gui_OutputFcn(~, ~, handles) 
%==========================================================================
%% DESCRIPTION: Define main interface output of GST
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   hObject     : handle to figure
%   eventdata   : reserved - to be defined in a future version of MATLAB
%   handles     : structure with handles and user data (see GUIDATA)
%==========================================================================
% OUTPUT:
%   varargout	:  cell array for returning output args (see VARARGOUT)
%==========================================================================
try
    
% Get default command line output from handles structure
% ------------------------------------------------------
varargout{1} = handles.output;

catch exception
   
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================

function PbDirectory_Callback(~, ~, handles) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Define Directory selection button callback
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   hObject     : handle to figure
%   eventdata   : reserved - to be defined in a future version of MATLAB
%   handles     : structure with handles and user data (see GUIDATA)
%==========================================================================
% OUTPUT:
%==========================================================================
try
    
    % Define mandatory data
    % ---------------------    
    % UserData structure
    user_data = getappdata(handles.FgBasic, 'UserData');
    
    % Define Default directory
    % ------------------------
    default_directory = get(handles.EdDirectory, 'String');

    % Manage empty directory
    if isempty(default_directory) && exist(fullfile(user_data.WORK_DIR, ...
            'data', 'files_folder'), 'dir')==7
       
        % Define the default directory        
        default_directory = fullfile(user_data.WORK_DIR, 'data', 'files_folder'); 
    
    elseif isempty(default_directory)
        
        default_directory = fullfile(user_data.WORK_DIR, 'data');
        
    end
    
    % Get the selected directory
    % --------------------------
    new_directory = uigetdir(default_directory, ...
        handles.gui_fcn.getMessages('DIRECTORY_TITLE'));
    
    if isnumeric(new_directory); return; end;
    
    % Update interface
    % ----------------
    set(handles.EdDirectory, 'String', new_directory);

    % update interface data
    LocalUpdateDisplay('list');

    % update interface objects
    LocalUpdateObjects;

catch exception
   
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================

function PbEditFile_Callback(~, ~, ~) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Define Directory selection button callback
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   hObject     : handle to figure
%   eventdata   : reserved - to be defined in a future version of MATLAB
%   handles     : structure with handles and user data (see GUIDATA)
%==========================================================================
% OUTPUT:
%==========================================================================
try
    
    LocalUpdateDisplay('info');
    
catch exception
   
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================

function LbFiles_Callback(~, ~, ~) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Define Directory selection button callback
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   hObject     : handle to figure
%   eventdata   : reserved - to be defined in a future version of MATLAB
%   handles     : structure with handles and user data (see GUIDATA)
%==========================================================================
% OUTPUT:
%==========================================================================
try
     
    LocalUpdateDisplay('no_info');

catch exception
   
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================

function CbFormatList_Callback(~, ~, ~) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Define Directory selection button callback
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   hObject     : handle to figure
%   eventdata   : reserved - to be defined in a future version of MATLAB
%   handles     : structure with handles and user data (see GUIDATA)
%==========================================================================
% OUTPUT:
%==========================================================================
try
    
    % Update List display
    % -------------------
    LocalUpdateDisplay('list');
    
catch exception
   
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================

function PmCurveSelection_Callback(~, ~, ~) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Define Directory selection button callback
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   hObject     : handle to figure
%   eventdata   : reserved - to be defined in a future version of MATLAB
%   handles     : structure with handles and user data (see GUIDATA)
%==========================================================================
% OUTPUT:
%==========================================================================
try
    % Update plot
    % -----------
    LocalUpdateDisplay('plot');
    
catch exception
    
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================

function PmColorSelection_Callback(~, ~, ~) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Define Directory selection button callback
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   hObject     : handle to figure
%   eventdata   : reserved - to be defined in a future version of MATLAB
%   handles     : structure with handles and user data (see GUIDATA)
%==========================================================================
% OUTPUT:
%==========================================================================
try
   
    % Update plot
    % -----------
    LocalUpdateDisplay('plot');
    
catch exception
   
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================

function RbLegend_Callback(~, ~, ~) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Define Directory selection button callback
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   hObject     : handle to figure
%   eventdata   : reserved - to be defined in a future version of MATLAB
%   handles     : structure with handles and user data (see GUIDATA)
%==========================================================================
% OUTPUT:
%==========================================================================
try
   
    % Update plot
    % -----------
    LocalUpdateDisplay('plot');
    
catch exception
   
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================

function SlAbscissa_Callback(~, ~, ~) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Define Directory selection button callback
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   hObject     : handle to figure
%   eventdata   : reserved - to be defined in a future version of MATLAB
%   handles     : structure with handles and user data (see GUIDATA)
%==========================================================================
% OUTPUT:
%==========================================================================
try
    
    % Update plot
    % -----------
    LocalUpdateDisplay('plot');
    
catch exception
   
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================

function AxCurve_ButtonDownFcn(~, ~, handles)
%==========================================================================
%% DESCRIPTION: Define Directory selection button callback
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   hObject     : handle to figure
%   eventdata   : reserved - to be defined in a future version of MATLAB
%   handles     : structure with handles and user data (see GUIDATA)
%==========================================================================
% OUTPUT:
%==========================================================================

% Get the current position
% ------------------------
current_position = get(handles.AxPlot, 'CurrentPoint');

% Display the position into the edit box
% --------------------------------------
set(handles.EdValueX, 'String', sprintf('%4.2f', current_position(1,1)));
set(handles.EdValueY, 'String', sprintf('%4.2f', current_position(1,2)));
%==========================================================================

function LocalUpdateDisplay(varargin)
%==========================================================================
%% DESCRIPTION: Define Directory selection button callback
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   varargin    : command line arguments to mt_main_gui (see VARARGIN)
%==========================================================================
% OUTPUT:
%==========================================================================

% Manage input arguments
% ----------------------
if nargin>0 && ischar(varargin{1})
    
    update_mode = varargin{1};
    
else
    
    update_mode = 'all';
    
end

% Get handles structure
% ---------------------
handles = guidata(findobj('Tag', 'FgBasic'));

% Manage Initialization
% ---------------------
if strcmpi(update_mode, 'initialization')

    % Get UserData structure
    user_data = getappdata(handles.FgBasic, 'UserData');
    
    % List initialization
    if exist(fullfile(user_data.WORK_DIR, 'data', 'files_folder'), 'dir')==7

        set(handles.EdDirectory, 'String', fullfile(user_data.WORK_DIR, ...
            'data', 'files_folder'));
        
    else
        
        set(handles.EdDirectory, 'String', '');
    
    end
    
    set(handles.LbFiles, 'String', '', 'Value', []);
    
    % plot initialization
    plot_list = {'', 'sin', 'cos', 'tan'};
    set(handles.PmCurveSelection, 'Value', 1, 'UserData', plot_list);

    color_list = {'red', 'green', 'blue', 'black'};
    set(handles.PmColorSelection, 'Value', 1, 'UserData', color_list);
    
    set(handles.SlAbscissa, 'Min', 1, 'Max', 5, 'Value', 1, 'SliderStep', [0.25 1]);
    set(handles.EdAbscissa, 'String', '1');

end

% Manage list
% -----------
if any(strcmpi(update_mode, {'list', 'all', 'initialization'}))
   
    % Update list display
    % -------------------
    % Define the targeted directory
    current_directory = get(handles.EdDirectory, 'String');
    
    % Define the directory content
    if ~isempty(current_directory)
        
        directory_content = dir(current_directory);
        
    else
       
        directory_content = [];
        
    end
    
    % Define the file list
    file_list = LocalDefineFileList(directory_content(...
        ~[directory_content.isdir]));
    
    % Display the list
    if get(handles.CbFormatList, 'Value') == 0

        set(handles.LbFiles, 'String', file_list.name, 'UserData', file_list);

    else
        
        set(handles.LbFiles, 'String', file_list.display_list, 'UserData', file_list);
        
    end
    
    % Initialize selection
    if isempty(get(handles.LbFiles, 'Value'))
        
        set(handles.LbFiles, 'Value', 1);
        
    else
        
        set(handles.LbFiles, 'Value', min(get(handles.LbFiles, 'Value'), ...
            length(file_list.name)));

    end
    
end

% Manage information about list elements
% --------------------------------------
if strcmpi(update_mode, 'info')

    % Define the selected element in the list
    file_list              = get(handles.LbFiles, 'UserData');
    selected_element_index = get(handles.LbFiles, 'Value');
    
    % Define associated informations
    selected_element_date  = file_list.date{selected_element_index};
    selected_element_size  = file_list.bytes(selected_element_index);
    
    set(handles.StDateInfo, 'String', ['Date: ', selected_element_date], ...
        'FontWeight', 'bold');
    set(handles.StSizeInfo, 'String', ['Size: ', num2str(...
        selected_element_size), ' bytes'], 'FontWeight', 'bold');

elseif strcmpi(update_mode, 'no_info')
    
    set(handles.StDateInfo, 'String', '');
    set(handles.StSizeInfo, 'String', '');

end

% Manage Axe information
% ----------------------
if any(strcmpi(update_mode, {'initialization', 'plot'})) && ...
        get(handles.PmCurveSelection, 'Value') == 1
       
    % Load MainData structure
    main_data = getappdata(handles.FgBasic, 'MainData');
    
    % Load image
    current_image = imread(fullfile(main_data.SOFT_DATA_PICTURE, ...
        'matlab_plot_logo.png'));

    % Create an image
    handles.ImPlotLogo = image(current_image, 'Parent', ...
        handles.AxPlot, 'UserData', 'img');

    % save handle structure
    guidata(handles.FgBasic, handles);
    
    % Make the axes non visible
    set(handles.AxPlot, 'Visible', 'off');

    % Enable the slider
    set(handles.SlAbscissa, 'Enable', 'inactive');
    set(handles.EdAbscissa, 'Enable', 'off');

    % Display the position into the edit box
    set(handles.EdValueX, 'String', '');
    set(handles.EdValueY, 'String', '');
    
elseif strcmpi(update_mode, 'plot')

    % Manage existing image
    if isfield(handles, 'ImPlotLogo')
       
        % Delete the image
        delete(handles.ImPlotLogo);
        handles = rmfield(handles, 'ImPlotLogo');
        
        % save handle structure
        guidata(handles.FgBasic, handles);

    end

    % Manage the plot
    LocalManagePlot;
    
    % Make the Axes visible
    set(handles.AxPlot, 'Visible', 'on');
    
    % Enable the slider
    set(handles.SlAbscissa, 'Enable', 'on');
    set(handles.EdAbscissa, 'String', num2str(get(handles.SlAbscissa, ...
        'Value')), 'Enable', 'inactive');
    
end
%==========================================================================

function LocalUpdateObjects(varargin)
%==========================================================================
%% DESCRIPTION: Define Directory selection button callback
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   varargin    : command line arguments to mt_main_gui (see VARARGIN)
%==========================================================================
% OUTPUT:
%==========================================================================

% Manage input arguments
% ----------------------
if nargin>0 && ischar(varargin{1})
    
    update_mode = varargin{1};
    
else
    
    update_mode = 'default';
    
end

% Get handles structure
% ---------------------
handles = guidata(findobj('Tag', 'FgBasic'));

% % Manage update according to the mode
% % -----------------------------------
if strcmpi(update_mode, 'initialization')

    set(handles.EdDirectory, 'Enable', 'inactive');
    set(handles.LbFiles, 'Enable', 'inactive');
    set(handles.PbEditFile, 'Enable', 'off');
    set(handles.EdValueX, 'Enable', 'inactive');
    set(handles.EdValueY, 'Enable', 'inactive');
    
end

% Manage File Edition
% -------------------
if ~isempty(get(handles.LbFiles, 'String'))
   
    set(handles.LbFiles, 'Enable', 'on');
    set(handles.PbEditFile, 'Enable', 'on');
    
end
%==========================================================================

function list_OUT = LocalDefineFileList(list_IN)
%==========================================================================
%% DESCRIPTION: Define Directory selection button callback
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   list_IN     : Input list to define
%==========================================================================
% OUTPUT:
%   list_OUT	: Updated list
%==========================================================================

% Initialize output
% -----------------
if isempty(list_IN)

list_OUT.name         = {''};
list_OUT.display_list = {''};
list_OUT.date         = {''};
list_OUT.bytes        = 1;

else
    
list_OUT.name         = cell(1, length(list_IN));
list_OUT.display_list = cell(1, length(list_IN));
list_OUT.date         = cell(1, length(list_IN));
list_OUT.bytes        = ones(1, length(list_IN));

end

% Define Formated list
% --------------------
for i_element = 1:length(list_IN)

    % Get the current element
    current_element = list_IN(i_element).name;
    
    % Define the possible file extension
    [~,element_name, element_extension] = fileparts(current_element);

    switch element_extension
        
        case {'.mdl', '.slx'}
            
            element_color = 'blue';
            element_type  = 'Simulink Model';
            
        case {'.m', '.mat'}
            
            element_color = 'red';
            
            if strcmpi(element_extension, '.m')
                
                element_type  = 'Matlab M-file';
                
            else
                
                element_type  = 'Matlab MAT-file';
                
            end
            
        case {'.png', '.jpeg', '.jpg', '.tiff'}
            
            element_color = 'green';
            element_type  = ['Image file (', ...
                upper(element_extension(1:end)), ')'];
            
        otherwise
            
            element_color = 'black';
            element_type  = 'Text file';
            
    end
    
    % Update output
    list_OUT.name{i_element}         = list_IN(i_element).name;
    list_OUT.display_list{i_element} = ['<html><table><tr><td width=180>', ...
        '<font color="', element_color, '">', element_name, ...
        '</font></td><td>', element_type, '</td></tr></table></html>']; 
    list_OUT.date{i_element}         = list_IN(i_element).date;
    list_OUT.bytes(i_element)        = list_IN(i_element).bytes;
    
end
%==========================================================================

function LocalManagePlot(varargin)
%==========================================================================
%% DESCRIPTION: Define Directory selection button callback
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   list_IN     : Input list to define
%==========================================================================
% OUTPUT:
%   list_OUT	: Updated list
%==========================================================================

% Define handles structure
% ------------------------
handles = guidata(findobj('Tag', 'FgBasic'));

% Get the factor
% --------------
current_factor = get(handles.SlAbscissa, 'Value');

% Intialize abscissa
% ------------------
x = -current_factor*pi:0.01:current_factor*pi;

% Display the position into the edit box
% --------------------------------------
set(handles.EdValueX, 'String', '');
set(handles.EdValueY, 'String', '');

% Define the selected function
% ----------------------------
plot_list           = get(handles.PmCurveSelection, 'UserData');
selected_plot_index = get(handles.PmCurveSelection, 'Value');
selected_plot_name  = plot_list{selected_plot_index};

% Define the selected color
% -------------------------
color_list = get(handles.PmColorSelection, 'UserData');
selected_color_index = get(handles.PmColorSelection, 'Value');
selected_color_name = color_list{selected_color_index};

% Plot the curve on the graphic
% -----------------------------
switch selected_plot_name
    
    case 'cos'
        
        handles.AxCurve = plot(handles.AxPlot, x, cos(x));

    case 'sin'
        
        handles.AxCurve = plot(handles.AxPlot, x, sin(x));
        
    case 'tan'
        
        x = (-pi/2)+0.01:0.01:(pi/2)-0.01;
        handles.AxCurve = plot(handles.AxPlot, x, tan(x));
        
    otherwise
        
        return;

end

grid(handles.AxPlot, 'on');

% Update colors and line style
% ----------------------------
set(handles.AxCurve, 'Color', selected_color_name, 'LineWidth', 1.5, ...
    'ButtonDownFcn', {@AxCurve_ButtonDownFcn, handles});

% Define the different labels
% ---------------------------
xlabel(handles.AxPlot, 'angle [rad]');
ylabel(handles.AxPlot, selected_plot_name);
legend(handles.AxPlot, ['Plot ', selected_plot_name, ' function'], ...
    'Location', 'SouthEast');

if get(handles.RbLegend, 'Value') == 1
    
    legend(handles.AxPlot, 'show');
    
else
    
    legend(handles.AxPlot,'hide');
    
end

% Save handles structure
% ----------------------
guidata(handles.FgBasic, handles);
%==========================================================================

function LocalClose(varargin)
%==========================================================================
%% DESCRIPTION: Close properly the interfaces
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
% hObject   : handle to figure
% eventdata : reserved - to be defined in a future version of MATLAB
% handles   : structure with handles and user data (see GUIDATA)
%==========================================================================
% OUTPUT:
%==========================================================================
try
    
    % Get figure handles
    % ------------------
    handles = guidata(findobj('Tag', 'FgBasic'));
        
    % Identify if other children windows are open
    % -------------------------------------------
    children_figure_handle_list = mt_manage_open_children_figure_pre(...
        handles.FgBasic);
    
    % Close figures
    % -------------
    if ~isempty(children_figure_handle_list)
        
        % Close all open figure
        handles.gui_fcn.close(children_figure_handle_list);
        
    else
        
        % Close current figure
        handles.gui_fcn.close();
        
    end
    
catch exception
    
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================
