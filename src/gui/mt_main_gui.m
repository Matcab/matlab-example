function varargout = mt_main_gui(varargin)
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% TEMPLATE MATLAB
%==========================================================================
% FILENAME: mt_main_gui.m
% PATH    : $TEMPLATE_HOME$\src\gui
%==========================================================================
% ABSTRACT: Matlab template software main interface callbacks
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
%   varargin	: command line arguments to mt_main_gui (see VARARGIN)
%==========================================================================
% OUTPUT:
%   varargout  	:  cell array for returning output args (see VARARGOUT)
%==========================================================================

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mt_main_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @mt_main_gui_OutputFcn, ...
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

function mt_main_gui_OpeningFcn(hObject, ~, handles, varargin)
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
            
    % Manage interface standard behaviour using cGuiManager object
    % ------------------------------------------------------------
    % Define the gui manager object
    gui_manager = cGuiManager('figure_name', ...
        strrep(mfilename, '_gui', ''), 'current_figure_handle', ...
        handles.FgMain, 'parent_figure_handle', 0);
    
    % Update handles structure in case of languages and screensize menu
    % creation
    handles = guihandles(handles.FgMain);
    
    % Save gui_manager object into the handles structure
    handles.gui_fcn = gui_manager;

    % Choose default command line output for mt_main_gui
    handles.output = hObject;
    
    % Initialize interface objects
    % ----------------------------
    % Set standard callback functions (Close with cross, keybord callback)
    set(handles.FgMain, 'CloseRequestFcn', @LocalClose, ...
        'KeyPressFcn', {@KeyPressFcn_callback, handles});

    % Update handles structure
    guidata(hObject, handles);
 
    % Manage specific features related to Option menu
    LocalManageOptionMenus;
    
    % Update interface object status
    LocalUpdateObjects;
    
catch exception

    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);

end
%==========================================================================

function varargout = mt_main_gui_OutputFcn(~, ~, handles) 
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

function PbBasicFigure_Callback(~, ~, handles) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Manage BasicFigure button callback
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
    
    % Manage only one instance of the interface
    % -----------------------------------------
    if isempty(findobj('Tag', 'FgBasic'))
    
        % Open the Basic Interface
        % ------------------------
        mt_basic_gui(handles.FgMain);

    end
    
catch exception

    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);

end
%==========================================================================

function PbAdvancedFigure_Callback(~, ~, handles) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Manage BasicFigure button callback
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
    
    % Manage only one instance of the interface
    % -----------------------------------------
    if isempty(findobj('Tag', 'FgAdvanced'))
    
        % Open the Basic Interface
        % ------------------------
        mt_advanced_gui(handles.FgMain);
            
    end

catch exception

    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);

end
%==========================================================================

function PbJavaFigure_Callback(~, ~, ~) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Manage BasicFigure button callback
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
    

catch exception

    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);

end
%==========================================================================

function PbLibraryExample_Callback(~, ~, ~) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Manage BasicFigure button callback
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
    

catch exception

    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);

end
%==========================================================================

function MbClose_Callback(~, ~, ~) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Manage BasicFigure button callback
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
    

catch exception

    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);

end
%==========================================================================

function MbUserGuide_Callback(~, ~, ~) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Manage BasicFigure button callback
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
    

catch exception

    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);

end
%==========================================================================

function MbGuidelinesPart1_Callback(~, ~, handles) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Manage BasicFigure button callback
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
    
    % Get the MainData structure
    % --------------------------
    main_data = getappdata(handles.FgMain, 'MainData');
    
    % Open the corresponding guideline
    % --------------------------------
    % User guide opening
    %-------------------
    if exist(main_data.SOFT_SG_PART1, 'file')==2
        
        system(['start ' main_data.SOFT_SG_PART1]);
        
    end

catch exception

    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);

end
%==========================================================================

function ChangeMode(hObject, ~, handles) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Change GST mode according to the selected menu
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
    
    % Load UserData structure
    % -----------------------
    user_data = getappdata(handles.FgMain, 'UserData');
    
    % Update previous selection status
    % --------------------------------
    set(findobj('UserData', user_data.MODE), 'Checked', 'off');
    
    % Update new selection status
    % ---------------------------
    set(hObject, 'Checked', 'on');
    
    % Update user_data structure
    % --------------------------
    user_data.MODE = get(hObject, 'UserData');
    
    % Save UserData Structure
    % -----------------------
    setappdata(handles.FgMain, 'UserData', user_data);
    
    % Update Object display
    % ---------------------
    LocalUpdateObjects;
        
catch exception
    
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================

function ChangeLanguage(hObject, varargin) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Change GST display language according to the selected menu
%==========================================================================
% ALGORITHM:
%   Get language identifier (saved in menu UserData) and use GUImanager
%   function to change language to selected one (SET_LANGUAGE). Update
%   displayed data to ensure that all text are in correct language, also
%   reload log messages.
%==========================================================================
% INPUT:
%   hObject     : handle to figure
%   eventdata   : reserved - to be defined in a future version of MATLAB
%   handles     : structure with handles and user data (see GUIDATA)
%==========================================================================
% OUTPUT:
%==========================================================================
try
    
    % Define handle structure
    % -----------------------
    handles = guidata(hObject);
    
    % Close all other interfaces
    % --------------------------
    LocalCloseChildren;
        
    % Define new language in the interface
    % ------------------------------------
    handles.gui_fcn.setLanguage(get(hObject,'UserData'));
    
    % Save handles structure
    % ----------------------
    guidata(hObject, handles);
    
catch exception
    
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================

function ChangeScreensize(hObject, varargin) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Change GST screensize according to the selected menu
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
    
    % Define the handles structure
    % ----------------------------
    handles = guidata(hObject);
        
    % Close all other interfaces
    % --------------------------
    LocalCloseChildren;
    
    % Define new size
    % ---------------
    handles.gui_fcn.setScreensize(get(hObject,'UserData'));
    
    % Save handles structure
    % ----------------------
    guidata(hObject, handles);
    
catch exception
    
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================

function LocalUpdateObjects(varargin)
%==========================================================================
%% DESCRIPTION: Update interface according to user selection
%==========================================================================
% ALGORITHM:
%   Make visible on/off Parameter menu according to user mode selected
%==========================================================================
% INPUT:
%   handles   : structure with handles and user data (see GUIDATA)
%==========================================================================
% OUTPUT:
%==========================================================================

% Get the handles structure
% -------------------------
handles = guidata(findobj('Tag', 'FgMain'));

% Get the user data structure
% ---------------------------
user_data = getappdata(handles.FgMain, 'UserData');

% Manage interface objects according to user mode
% -----------------------------------------------
if strcmpi(user_data.MODE, 'standard')
    
    set(handles.PbJavaFigure, 'Enable', 'off');
    set(handles.PbLibraryExample, 'Enable', 'off');

else
    
    set(handles.PbJavaFigure, 'Enable', 'inactive');
    set(handles.PbLibraryExample, 'Enable', 'inactive');
    
end

% Manage panels titles
% --------------------
tmp_title(1) = get(handles.PnStandardFigure_T2, 'TitleHandle');
tmp_title(2) = get(handles.PnJavaFigure_T2, 'TitleHandle');
tmp_title(3) = get(handles.PnLibraryExample_T2, 'TitleHandle');
set(tmp_title, 'BackgroundColor', [0, 0, 0.542], 'ForegroundColor', [1 1 1]);
%==========================================================================

function LocalManageOptionMenus(varargin)
%==========================================================================
%% DESCRIPTION: Manage option menu: Create language and screensize menus
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   handles   : structure with handles and user data (see GUIDATA)
%==========================================================================
% OUTPUT:
%==========================================================================

% Get figure handles
% ------------------
handles = guidata(findobj('Tag', 'FgMain'));

% Initialize local variable
% -------------------------
list_checked={'off' 'on'};

% Load UserData structures
% ------------------------
user_data = getappdata(handles.FgMain, 'UserData');

% Initialize software mode
% ------------------------
set(handles.MbStandard, 'Checked', list_checked{...
    strcmpi(user_data.MODE, get(handles.MbStandard, 'UserData'))+1});
set(handles.MbAdvanced, 'Checked', list_checked{...
    strcmpi(user_data.MODE, get(handles.MbAdvanced, 'UserData'))+1});

% Save figure handles
% ------------------
guidata(findobj('Tag', 'FgMain'), handles);
%==========================================================================

function LocalCloseChildren(varargin)
%==========================================================================
%% DESCRIPTION: Close all children of the main window
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   handles_IN : handles structure
%==========================================================================
% OUTPUT:
%==========================================================================

% Define handles structure
% ------------------------
handles = guidata(findobj('Tag', 'FgMain'));

% Identify if other children windows are open
% -------------------------------------------
children_figure_handle_list = mt_manage_open_children_figure_pre(...
    handles.FgMain);

% Close children windows
% ----------------------
if ~isempty(children_figure_handle_list); handles.gui_fcn.close(...
        children_figure_handle_list, 'only_children'); end;
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
    handles = guidata(findobj('Tag', 'FgMain'));
        
    % Identify if other children windows are open
    % -------------------------------------------
    children_figure_handle_list = mt_manage_open_children_figure_pre(...
        handles.FgMain);
    
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
