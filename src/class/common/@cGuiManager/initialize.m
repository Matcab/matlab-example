function obj_OUT = initialize(obj_IN, varargin)
%==========================================================================
% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: initialize.m
% PATH: ..\common\@cGuiManager
%==========================================================================
% ABSTRACT: Initialize interface update
%==========================================================================
% REVISION HISTORY:
%   AUTHOR      	COMPANY     DATE        COMMENT
%   Laurent Vaylet 	AROB@S   	27/01/2006  Creation
%   Olivier Dufour	AROB@S    	14/11/2007  Update - Creation of generic
%                                           functions in order to manage
%                                           all kind of in-house software
%   Olivier Dufour	AROB@S      27/05/2009  Add skin management, modify
%                                           parent-child and key event
%                                           management. Implemented in
%                                           bdtool-v2.0.
%                                           Use read_config_file librairy
%                                           function for skin definition
%   Olivier Dufour	AROB@S      30/09/2009  Add colors and font management
%                                           in skins. Integration of
%                                           read_config_file in this file
%                                           (LocalReadConfigFile) Clean
%                                           code, update documentation used
%                                           in TACNI 6.0.
%   Olivier Dufour	AROB@S      03/05/2010  Function is documented and
%                                           functionnalities are tested and
%                                           improved.
%   Olivier Dufour	AROB@S      09/12/2010  Corrections in skin behaviour
%                                           (problem with panel for MATLAB
%                                           7.5 and allow definition on
%                                           multiline vectors)
%   Mathieu CABANES AROB@S      09/12/2010  Corrections in LocalSetLanguage
%                                           to take into account new object
%                                           available in Matlab 7.11
%                                           (table)
%   Mathieu CABANES AROB@S      18/11/2011  Update of Close function to
%                                           take into account the
%                                           possibility to delete several
%                                           children interfaces
%	Mathieu CABANES	AROB@S      23/09/2013  Class creation
%
%   <NAME>       	<COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%   Load MainData & UserData loading from the parent interface and save
%   them in the current interface
%   Figure handles structure loading
%   Set window default properties (properties defined directly in
%   program)
%   Set window size (according to screensize definition file)
%   Set window labels (according to label definition file)
%   Load window messages (according to label definition file)
%   Set window specific aspect (according to skin)
%   Finalize window initialization (save parent figure handles in
%   UserData, centered window on screen, define window KeyPress
%   callback)
%==========================================================================
% INPUT:
%   obj_IN      : GuiManager object
%   varargin    : command line argument of initialize (see VARARGIN)
%                 nargin = 2 => varargin{1} = main_data
%                 nargin = 3 => varargin{2} = user_data
%==========================================================================
% OUTPUT:
%==========================================================================

% Initialize output variable
% --------------------------
obj_OUT = obj_IN;

% Manage input arguments
% ----------------------
tmp_main_data = [];
tmp_user_data = [];
if nargin>1 && isstruct(varargin{1}); tmp_main_data = varargin{1}; end;
if nargin>2 && isstruct(varargin{2}); tmp_user_data = varargin{2}; end;

% Manage MainData structure
% -------------------------
% Check if MainData contains mandatory fields
if ~isempty(tmp_main_data)
        
    main_data = LocalCheckData('main', tmp_main_data);
    
elseif isappdata(obj_OUT.parent_figure_handle, 'MainData')
    
    main_data = LocalCheckData('main', getappdata(...
        obj_OUT.parent_figure_handle, 'MainData'));
    
else
    
    main_data = LocalCheckData('main');
    
end

% Save MainData structure in new window workspace
setappdata(obj_OUT.current_figure_handle, 'MainData', main_data);

% Manage UserData structure
% -------------------------
% Check if UserData contains mandatory fields
if ~isempty(tmp_user_data)
    
    user_data = LocalCheckData('main', tmp_user_data);
    
elseif isappdata(obj_OUT.parent_figure_handle, 'UserData')
    
    user_data = LocalCheckData('user', getappdata(...
        obj_OUT.parent_figure_handle, 'UserData'));
    
else
    
    user_data = LocalCheckData('user');
    
end

% Save UserData structure in new window workspace
setappdata(obj_OUT.current_figure_handle, 'UserData', user_data);

% All control on the windows will be available using the handle (even if
% they are hidden)
% ----------------------------------------------------------------------
set(0,'ShowHiddenHandles', 'on');

% Define default interface properties
% -----------------------------------
LocalDefineDefaultProperties(obj_OUT);

% Define default menu for languages and screensizes
% -------------------------------------------------
LocalManageOptionMenus(obj_OUT);

% Define interface messages
% -------------------------
obj_OUT = obj_OUT.setMessages;

% Set size
% --------
obj_OUT = obj_OUT.setScreensize;

% Text update according to the choosen language
% ---------------------------------------------
obj_OUT = obj_OUT.setLanguage;

% Set skin
% --------
obj_OUT.setSkin;

% Set icon
% --------
obj_OUT.setIcon;

% Userdate update for called and calling interface
% ------------------------------------------------
if obj_OUT.parent_figure_handle == 0
    
    set(obj_OUT.current_figure_handle, 'UserData', 1);
    
else
    
    set(obj_OUT.current_figure_handle, 'UserData', get(...
        obj_OUT.parent_figure_handle, 'UserData'));
    
end

% Figure centering
% ----------------
movegui(obj_OUT.current_figure_handle, 'center')

% The called window becomes the current window
% --------------------------------------------
set(0,'CurrentFigure', obj_OUT.current_figure_handle);
%==========================================================================

function LocalDefineDefaultProperties(obj_IN)
%==========================================================================
%% DESCRIPTION: Create window and graphical objects
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   color_IN    : interface background color
%   varargin	: command line arguments to startup_gui (see VARARGIN)
%==========================================================================
% OUTPUT:
%   handles     : current interface handle
%==========================================================================

% Set default properties
% ----------------------
% Set figure properties
set(obj_IN.current_figure_handle, ...
    'Color',            [0.941,0.941,0.941], ...
    'MenuBar',          'none', ...
    'ToolBar',          'none', ...
    'NumberTitle',      'off', ...
    'DockControl',      'off');

% Set UIcontrol and UIpanel properties
set(findobj(obj_IN.current_figure_handle, 'Type', 'uicontrol', ...
    '-or', 'Type', 'uipanel'), ...
    'FontUnits',        'pixels', ...
    'FontSize',         11, ...
    'FontName',         'Arial', ...
    'FontWeight',       'normal', ...
    'ForegroundColor',  [0,0,0], ...
    'BackgroundColor',  get(obj_IN.current_figure_handle, 'Color'));

% Set edit, popupmenu and listbox specific properties
set(findobj(obj_IN.current_figure_handle, 'Style', 'popupmenu', '-or', ...
    'Style', 'edit', '-or', 'Style', 'listbox'), ...
    'BackgroundColor',  [1,1,1]);
%==========================================================================

function LocalManageOptionMenus(obj_IN)
%==========================================================================
%% DESCRIPTION: Manage option menu: Create language and screensize menus
%==========================================================================
% ALGORITHM: In CmLanguage/CmScreensize menu, create one submenu per
% defining language/screensize. Callback is the same for each menu
% (MbChangeLanguage/MbChangeScreensize), submenus are differenciated by
% UserData values
%==========================================================================
% INPUT:
%   handles   : structure with handles and user data (see GUIDATA)
%==========================================================================

% Initialize local variable
% -------------------------
list_checked={'off' 'on'};

% Load MainData  and UserData structures
% --------------------------------------
main_data = getappdata(obj_IN.current_figure_handle, 'MainData');
user_data = getappdata(obj_IN.current_figure_handle, 'UserData');

% Get the figure handle
% ---------------------
handles = guihandles(obj_IN.current_figure_handle);

% Create language menus
% ---------------------
if isfield(handles, 'MbLanguages')
    
    language_callback = [obj_IN.figure_name, '_gui(''', ...
        'ChangeLanguage'', gcbo)'];
    
    for i_lang = 1:length(main_data.SOFT_LANGUAGES)
        
        uimenu('Parent', handles.MbLanguages, 'Label', ...
            ['Mb',upper(main_data.SOFT_LANGUAGES{i_lang}(1)), ...
            lower(main_data.SOFT_LANGUAGES{i_lang}(2:end))], ...
            'Tag', ['Mb',upper(main_data.SOFT_LANGUAGES{i_lang}(1)), ...
            lower(main_data.SOFT_LANGUAGES{i_lang}(2:end))], ...
            'UserData', main_data.SOFT_LANGUAGES{i_lang}, ...
            'Checked', list_checked{strcmpi(user_data.LANGUAGE, ...
            main_data.SOFT_LANGUAGES{i_lang})+1},...
            'Callback', language_callback);

    end
    
end

% Create screensize menus
% -----------------------
if isfield(handles, 'MbScreensizes')

    screensize_callback = [obj_IN.figure_name, '_gui(''', ...
        'ChangeScreensize'', gcbo)'];

    for i_size = 1:length(main_data.SOFT_SCREENSIZES)
        
        uimenu('Parent', handles.MbScreensizes, 'Label', ...
            main_data.SOFT_SCREENSIZES{i_size}, 'Tag', ...
            ['Mb',main_data.SOFT_SCREENSIZES{i_size}], ...
            'UserData', main_data.SOFT_SCREENSIZES{i_size}, ...
            'Checked', list_checked{strcmpi(user_data.SCREEN_SIZE, ...
            main_data.SOFT_SCREENSIZES{i_size})+1},...
            'Callback', screensize_callback);
        
    end
    
end

% Get the figure handle
% ---------------------
guidata(obj_IN.current_figure_handle, handles);
%==========================================================================

function struct_OUT = LocalCheckData(data_type_IN, varargin)
%==========================================================================
%% DESCRIPTION: Create window and graphical objects
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   color_IN    : interface background color
%   varargin	: command line arguments to startup_gui (see VARARGIN)
%==========================================================================
% OUTPUT:
%   handles     : current interface handle
%==========================================================================

% Manage input arguments
% ----------------------
if nargin>1 && isstruct(varargin{1})
    
    struct_OUT = upgrade(varargin{1}, LocalDefineData(data_type_IN));
    
else
    
    struct_OUT = LocalDefineData(data_type_IN);
    
end

% Manage MainData specificity
% ---------------------------
if strcmpi(data_type_IN, 'main')
    
    % Define the skin available in the software
    % -----------------------------------------
    if ~isempty(struct_OUT.SOFT_DATA_SKINS)  && ...
            (~isfield(struct_OUT, 'SOFT_SKINS') || ...
            (isfield(struct_OUT, 'SOFT_SKINS') && ...
            isempty(struct_OUT.SOFT_SKINS)))
        
        % List available skins (correspond to .ini files found in skin
        % directory)
        skin_list = dir(fullfile(struct_OUT.SOFT_DATA_SKINS, '*.ini'));
        struct_OUT.SOFT_SKINS = arrayfun(@(x) strrep(x.name,'.ini',''), ...
            skin_list, 'UniformOutput', false);
        
    elseif ~isfield(struct_OUT, 'SOFT_SKINS') || ...
            isempty(struct_OUT.SOFT_SKINS)
        
        % By default, list of skins is empty
        struct_OUT.SOFT_SKINS = {''};
        
    end
    
    % Define the screensize available in the software
    % -----------------------------------------------
    if ~isempty(struct_OUT.SOFT_DATA_SCREENSIZE) && ...
            (~isfield(struct_OUT, 'SOFT_SCREENSIZES') || ...
            (isfield(struct_OUT, 'SOFT_SCREENSIZES') && ...
            isempty(struct_OUT.SOFT_SCREENSIZES)))
        
        % List available screensize (correspond to directory found in the
        % screensize directory)
        screensize_list = dir(struct_OUT.SOFT_DATA_SCREENSIZE);
        struct_OUT.SOFT_SCREENSIZES = {screensize_list(...
            ~ismember({screensize_list.name}, {'.', '..'}) & ...
            [screensize_list.isdir]).name};
        
    elseif ~isfield(struct_OUT, 'SOFT_SCREENSIZES') || ...
            isempty(struct_OUT.SOFT_SCREENSIZES)
        
        % By default, list of skins is empty
        struct_OUT.SOFT_SCREENSIZES = {''};
        
    end
    
    % Define the languages available in the software
    % -----------------------------------------------
    if ~isempty(struct_OUT.SOFT_DATA) && ...
            (~isfield(struct_OUT, 'SOFT_LANGUAGES') || ...
            (isfield(struct_OUT, 'SOFT_LANGUAGES') && ...
            isempty(struct_OUT.SOFT_LANGUAGES)))
        
        available_languages = {'fr', 'en', 'us', 'sw', 'sp', 'it'};
        
        % List available languages (correspond to directory found in the
        % screensize directory)
        languages_list = dir(struct_OUT.SOFT_DATA);
        struct_OUT.SOFT_LANGUAGES = {languages_list(...
            ismember({languages_list.name}, available_languages) & ...
            [languages_list.isdir]).name};
        
    elseif ~isfield(struct_OUT, 'SOFT_LANGUAGES') || ...
            isempty(struct_OUT.SOFT_LANGUAGES)
        
        % By default, list of skins is empty
        struct_OUT.SOFT_LANGUAGES = {''};
        
    end
    
end
%==========================================================================

function struct_OUT = LocalDefineData(data_type_IN)
%==========================================================================
%% DESCRIPTION: Create window and graphical objects
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   color_IN    : interface background color
%   varargin	: command line arguments to startup_gui (see VARARGIN)
%==========================================================================
% OUTPUT:
%   handles     : current interface handle
%==========================================================================

% Evaluate if the structure is well define
% ----------------------------------------
switch data_type_IN
    
    case 'user'
        
        % Define minimum UserData structure
        struct_OUT.LANGUAGE    = 'en';
        struct_OUT.SCREEN_SIZE = '800x600';
        struct_OUT.SKIN        = 'default';
        
    case 'main'
        
        % Define minimum MainData structure
        struct_OUT.SOFT_SHORT_NAME      = 'SOFT';
        struct_OUT.SOFT_DATA            = '';
        struct_OUT.SOFT_DATA_SCREENSIZE = '';
        struct_OUT.SOFT_DATA_SKINS      = '';
        struct_OUT.SOFT_DATA_PICTURE    = '';
        struct_OUT.SOFT_CFG_FILE        = '';
        
    otherwise
        
        struct_OUT = [];
        return;
        
end
%==========================================================================
