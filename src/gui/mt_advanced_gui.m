function varargout = mt_advanced_gui(varargin)
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% TEMPLATE MATLAB
%==========================================================================
% FILENAME: mt_advanced_gui.m
% PATH    : $TEMPLATE_HOME$\src\gui
%==========================================================================
% ABSTRACT: Matlab template software advanced interface callbacks
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES       	AROB@S      03/07/2014  Creation
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   varargin	: command line arguments to mt_advanced_gui (see VARARGIN)
%==========================================================================
% OUTPUT:
%   varargout  	:  cell array for returning output args (see VARARGOUT)
%==========================================================================

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @mt_advanced_gui_OpeningFcn, ...
    'gui_OutputFcn',  @mt_advanced_gui_OutputFcn, ...
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

function mt_advanced_gui_OpeningFcn(hObject, ~, handles, varargin)
%==========================================================================
%% DESCRIPTION: Initialize the TEMPLATE advanced interface
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   hObject     : handle to figure
%   eventdata   : reserved - to be defined in a future version of MATLAB
%   handles     : structure with handles and user data (see GUIDATA)
%   varargin    : command line arguments to mt_advanced_gui (see VARARGIN)
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
    setappdata(handles.FgAdvanced, 'ParentFigHdl', parent_figure_handle);
    
    % Manage interface standard behaviour using cGuiManager object
    % ------------------------------------------------------------
    % Define the gui manager object
    gui_manager = cGuiManager('figure_name', ...
        strrep(mfilename, '_gui', ''), 'current_figure_handle', ...
        handles.FgAdvanced, 'parent_figure_handle', parent_figure_handle);
    
    % Update handles structure in case of languages and screensize menu
    % creation
    handles = guihandles(handles.FgAdvanced);
    
    % Save gui_manager object into the handles structure
    handles.gui_fcn = gui_manager;
    
    % Choose default command line output for mt_advanced_gui
    handles.output = hObject;
    
    % Initialize interface objects
    % ----------------------------
    % Set standard callback functions (Close with cross)
    set(handles.FgAdvanced, 'CloseRequestFcn', @LocalClose);
    
    % Set Default skin
    handles.gui_fcn.setSkin('advanced', {'icon'});
    
    % Update handles structure
    % ------------------------
    guidata(hObject, handles);
    
    % Initialize interface
    % --------------------
    % initialize objects
    LocalUpdateObjects('initialization');
    
    % Data
    LocalUpdateData('initialization');
    
catch exception
    
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================

function varargout = mt_advanced_gui_OutputFcn(~, ~, handles)
%==========================================================================
%% DESCRIPTION: Define advanced interface output of GST
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

function FgAdvanced_KeyPressFcn(~, ~, ~) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Manage Add sources button callback
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
    
    % Update interface
    % ----------------
    LocalUpdateData('filter');
    
catch exception
    
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================

function PbAddSources_Callback(~, ~, handles) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Manage Add sources button callback
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
    
    % Modify pointer
    % --------------
    set(handles.FgAdvanced, 'pointer', 'watch');
    pause(eps);
    
    % Load a new signal
    % -----------------
    signals_data = LocalLoadSignals('add_sources');
    
    % Save the signals data
    % ---------------------
    setappdata(handles.FgAdvanced, 'SignalsData', signals_data);
    
    % Update interface
    % ----------------
    LocalUpdateData;
    
    % Modify pointer
    % --------------
    set(handles.FgAdvanced, 'pointer', 'arrow');
    pause(eps);
    
catch exception
    
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================

function PbSignalsFilter_Callback(~, ~, ~) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Manage SignalsFilter button callback
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
    
    % Update interface
    % ----------------
    LocalUpdateData('filter');
    
catch exception
    
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================

function PbPlots_Callback(~, ~, ~) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Manage Plots button callback
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
    
    % Update interface
    % ----------------
    LocalUpdateObjects('plot');
    
    % Update data
    % -----------
    LocalUpdateData('plot');
    
catch exception
    
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================

function PbResetPlots_Callback(~, ~, ~) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Manage Plots button callback
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
    
    % Update data
    % -----------
    LocalUpdateObjects('reset');
    
    % Update data
    % -----------
    LocalUpdateData('reset');
    
catch exception
    
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================

function PmSignalsSources_Callback(~, ~, ~) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Manage SignalSources popupmenu callback
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
    
    % Update interface
    % ----------------
    LocalUpdateObjects('reset');
    
catch exception
    
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================

function LbSignals_Callback(~, ~, ~) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Manage Signals listbox callback
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
    
    % Update interface
    % ----------------
    LocalUpdateData;
    
    
catch exception
    
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================

function CbPlotsExtraOrdinateTitle_Callback(~, ~, ~)
%==========================================================================
%% DESCRIPTION: Manage special panel title checkbox callback
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
    
    % Update interface
    % ----------------
    LocalUpdateObjects;
    
catch exception
    
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================

function EdSignalsFilter_KeyPressFcn(~, ~, handles) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Manage Add sources button callback
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
    % Get the UserData structure
    % --------------------------
    user_data = getappdata(handles.FgAdvanced, 'UserData');
    
    % Manage filter only in advanced mode
    % -----------------------------------
    if strcmpi(user_data.MODE, 'advanced')
        
        % Get editbox contents
        % --------------------
        edit_content = char(get(handles.EdSignalsFilter, 'String'));
        
        % Get current character
        % ---------------------
        current_character = get(handles.FgAdvanced, 'CurrentCharacter');
        
        % Define the Filter string
        % ------------------------
        if length(edit_content) >= 1 && get(handles.FgAdvanced, ...
                'CurrentCharacter') == 8 %Return
            
            % Delete last char
            edit_content(end) = [];
            
        elseif length(edit_content) >= 1 && get(handles.FgAdvanced, ...
                'CurrentCharacter') == 127 %Suppr
            
            % Erase first char
            edit_content(1) = [];
            
        elseif ~isempty(current_character) && get(handles.FgAdvanced, ...
                'CurrentCharacter') ~= 127 && get(handles.FgAdvanced, ...
                'CurrentCharacter') ~= 8
            
            % Add a char on the string
            edit_content(end+1) = char(current_character);
            
        end
        
        set(handles.EdSignalsFilter, 'String', edit_content);
        
        % Update interface
        % ----------------
        LocalUpdateData('filter');
        
    end
    
catch exception
    
    % Manage the error
    % ----------------
    err_manager = getappdata(0, 'ErrManager');
    err_manager = err_manager.display(exception);
    setappdata(0, 'ErrManager', err_manager);
    
end
%==========================================================================

function EdPlots_Callback(drag_handle_IN, drop_handle_IN, ~) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Template drop function management
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   drag   : object to drag
%   drop   : object to drop
%==========================================================================
% OUTPUT:
%==========================================================================
try
    
    % Identify object to drag
    % -----------------------
    current_element_list = get(drag_handle_IN, 'String');
    selected_element     = current_element_list(get(drag_handle_IN, 'Value'));
    
    
    % Drop the selection
    % ------------------
    set(drop_handle_IN, 'String', selected_element);
    
    % Update interface
    % ----------------
    LocalUpdateObjects;
    
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
%% DESCRIPTION: Manage interface object behaviour
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   varargin	: command line arguments to LocalUpdateObjects (see
%                 VARARGIN)
%==========================================================================
% OUTPUT:
%==========================================================================

% Initialize local variable
% -------------------------
update_mode = 'default';

% Manage input arguments
% ----------------------
if nargin > 0 && ischar(varargin{1}); update_mode = varargin{1}; end;

% Get figure handles structure
% ----------------------------
handles = guidata(findobj('Tag', 'FgAdvanced'));

% Get the UserData structure
% --------------------------
user_data = getappdata(handles.FgAdvanced, 'UserData');

% Manage objects initialization
% -----------------------------
if strcmpi(update_mode, 'initialization')
    
    % Update the help string
    set(handles.StPlotsInformation, 'FontWeight', 'bold', 'FontSize', 14);
    
    % Create special extra ordinate panel title
    handles.CbPlotsExtraOrdinateTitle_T2 = get(handles.PnPlotsExtraOrdinate, ...
        'TitleHandle');
    
    % Modify title uicontrol style to introduce a checkbox
    title_position = get(handles.CbPlotsExtraOrdinateTitle_T2, 'Position') + ...
        [0 0 70 10];
    set(handles.CbPlotsExtraOrdinateTitle_T2, 'style', 'checkbox', 'Tag', ...
        'PnPlotsExtraOrdinateTitle', 'Value', 0, 'Position', ...
        title_position, 'Callback', {@CbPlotsExtraOrdinateTitle_Callback, ...
        handles}, 'Fontname', 'Calibri', 'Fontsize', 12);
    
    % Save handles structure
    guidata(handles.FgAdvanced, handles);
    
    % Define initial values for popup and list
    set(handles.PmSignalsSources, 'Value', 1);
    set(handles.LbSignals, 'Value', 1);
    
    % Manage drag & drop feature
    dragndrop = cDragNDrop('figure_handle', handles.FgAdvanced);
    
    % Define the drop handles
    dragndrop = dragndrop.setDropCallback({{@mt_advanced_gui, ...
        'EdPlots_Callback', handles.LbSignals, handles.EdPlotsAbscissa, ...
        handles}, {@mt_advanced_gui, 'EdPlots_Callback', handles.LbSignals, ...
        handles.EdPlotsOrdinate, handles}, {@mt_advanced_gui, ...
        'EdPlots_Callback', handles.LbSignals, handles.EdPlotsExtraOrdinate, ...
        handles}});
    dragndrop = dragndrop.setDropHandles([handles.EdPlotsAbscissa, ...
        handles.EdPlotsOrdinate, handles.EdPlotsExtraOrdinate]);
    
    % Define the drag handles
    dragndrop = dragndrop.setDragHandles(handles.LbSignals);
    
    % Define the valid drag for each drop handle
    dragndrop = dragndrop.setDropValidDrag({});
    
    % Initialize dragand drop
    dragndrop = dragndrop.initialize;
    
    % Save the dragNdrop feature
    setappdata(handles.FgAdvanced, 'DragNDrop', dragndrop);
    
end

% Manage differences according to mode
% ------------------------------------
if strcmpi(user_data.MODE, 'advanced')
    
    set(handles.PbAddSources, 'Visible', 'on');
    set(handles.PbSignalsFilter, 'Visible', 'off');
    
else
    
    set(handles.PbAddSources, 'Visible', 'off');
    set(handles.PbSignalsFilter, 'Visible', 'on');
    
end

% Manage extra ordinate panel behaviour
% -------------------------------------
if get(handles.CbPlotsExtraOrdinateTitle_T2, 'Value') == 1
    
    set(handles.EdPlotsExtraOrdinate, 'Enable', 'inactive');
    
else
    
    set(handles.EdPlotsExtraOrdinate, 'Enable', 'off');
    
end

% Manage reset mode
% -----------------
if strcmpi(update_mode, 'initialization') || strcmpi(update_mode, 'reset')
    
    % Load MainData structure
    main_data = getappdata(handles.FgAdvanced, 'MainData');
    
    % Load image
    current_image = imread(fullfile(main_data.SOFT_DATA_PICTURE, ...
        'matlab_logo.png'));
    
    % Create an image
    handles.ImPlotsLogo = image(current_image, 'Parent', ...
        handles.AxPlots, 'UserData', 'img');
    
    % save handle structure
    guidata(handles.FgAdvanced, handles);
    
    % Make the axes non visible
    set(handles.AxPlots, 'Visible', 'off');
    
    % Empty Abscissa and ordinate
    set(handles.EdPlotsAbscissa, 'String', '');
    set(handles.EdPlotsOrdinate, 'String', '');
    set(handles.EdPlotsExtraOrdinate, 'String', '');
    
end

% Manage plot mode
% ----------------
if isempty(get(handles.EdPlotsAbscissa, 'String')) || ...
        isempty(get(handles.EdPlotsOrdinate, 'String'))
    
    set(handles.PbPlots, 'Enable', 'off');
    
else
    
    set(handles.PbPlots, 'Enable', 'on');
    
end

if strcmpi(update_mode, 'plot')
    
    % Manage existing image
    if isfield(handles, 'ImPlotsLogo')
        
        % Delete the image
        delete(handles.ImPlotsLogo);
        handles = rmfield(handles, 'ImPlotsLogo');
        
        % save handle structure
        guidata(handles.FgAdvanced, handles);
        
    end
    
    % Make the axes non visible
    set(handles.AxPlots, 'Visible', 'on');
    
end
%==========================================================================

function LocalUpdateData(varargin)
%==========================================================================
%% DESCRIPTION: Manage interface data behaviour
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   varargin	: command line arguments to LocalUpdateDisplay (see
%                 VARARGIN)
%==========================================================================
% OUTPUT:
%==========================================================================

% Initialize local variable
% -------------------------
update_mode = 'default';

% Manage input arguments
% ----------------------
if nargin > 0 && ischar(varargin{1}); update_mode = varargin{1}; end;

% Get figure handles structure
% ----------------------------
handles = guidata(findobj('Tag', 'FgAdvanced'));

% Manage objects initialization
% -----------------------------
if strcmpi(update_mode, 'initialization')
    
    % Load the Default signals
    signals_data = LocalLoadSignals(update_mode);
    
    % Save default signals
    setappdata(handles.FgAdvanced, 'SignalsData', signals_data);
    
end

% Load SignalData
% ---------------
signals_data = getappdata(handles.FgAdvanced, 'SignalsData');

% Update signals sets
% -------------------
% Define signal list
signals_set_list = signals_data.getElementNameList;

% Update popup menu
set(handles.PmSignalsSources, 'String', signals_set_list.name);

% Define the signals list
% -----------------------
selected_signal_set = get(handles.PmSignalsSources, 'Value');

% Define the current signals
current_signals = signals_data.getElement(signals_set_list.name{...
    selected_signal_set});

% Define the corresponding signals list
signals_list = LocalDefineSignalsList(current_signals.getSignalsList);

% Update signals list
% -------------------
previous_selected_index = get(handles.LbSignals, 'Value');
new_selected_index      = previous_selected_index(previous_selected_index<=...
    length(signals_list.display_list));
if isempty(new_selected_index); new_selected_index = 1; end;

set(handles.LbSignals, 'String', signals_list.display_list, 'Value', ...
    new_selected_index, 'UserData', signals_list);

% Update the table with the selected data
% ---------------------------------------
if ~isempty(signals_list.filtered_index)
    
    selected_signals_index = signals_list.filtered_index(get(...
        handles.LbSignals, 'Value'));
    
else
    
    selected_signals_index = get(handles.LbSignals, 'Value');
    
end

current_names = signals_list.name(selected_signals_index);
current_data  = cell2mat(signals_list.value(selected_signals_index));
set(handles.TblSignals, 'Data', current_data, 'ColumnName', current_names);

if strcmpi(update_mode, 'plot')
    
    LocalManagePlots;
    
end
%==========================================================================

function list_OUT = LocalDefineSignalsList(list_IN)
%==========================================================================
%% DESCRIPTION: Manage interface data behaviour
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   varargin	: command line arguments to LocalUpdateDisplay (see
%                 VARARGIN)
%==========================================================================
% OUTPUT:
%==========================================================================

% Initialize variable
% -------------------
% output
list_OUT = list_IN;

% Get figure handles structure
% ----------------------------
handles = guidata(findobj('Tag', 'FgAdvanced'));

% Manage display list taking into account the filters
% ---------------------------------------------------
if isempty(deblank(get(handles.EdSignalsFilter, 'String')))
    
    filter_string = '';
    
else
    
    filter_string = deblank(get(handles.EdSignalsFilter, 'String'));
    
end

% Define the display list
% -----------------------
if ~isempty(filter_string)
    
    [list_OUT.display_list, list_OUT.filtered_index] = list_filter(...
        list_OUT.name, filter_string);
    
else
    
    list_OUT.display_list    = list_OUT.name;
    list_OUT.filtered_index = [];
    
end
%==========================================================================

function LocalManagePlots(varargin)
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

% initialize variable
% -------------------
exist_extra_ordinate = false;

% Define handles structure
% ------------------------
handles = guidata(findobj('Tag', 'FgAdvanced'));

% Define the plot abscissa and ordinate
% -------------------------------------
signals_list      = get(handles.LbSignals, 'UserData');
selected_abscissa = char(get(handles.EdPlotsAbscissa, 'String'));
selected_ordinate = char(get(handles.EdPlotsOrdinate, 'String'));

% Manage extra ordinate
% ---------------------
if get(handles.CbPlotsExtraOrdinateTitle_T2, 'Value')== 1
    
    exist_extra_ordinate    = true;
    selected_extra_ordinate = char(get(handles.EdPlotsExtraOrdinate, 'String'));
    
end

% Define corresponding values
% ---------------------------
selected_abscissa_value = signals_list.value{strcmpi(signals_list.name, ...
    selected_abscissa)};
selected_ordinate_value = signals_list.value{strcmpi(signals_list.name, ...
    selected_ordinate)};

if exist_extra_ordinate; selected_extra_ordinate_value = signals_list.value{...
        strcmpi(signals_list.name, selected_extra_ordinate)}; end;

% Define corresponding unit
% -------------------------
selected_abscissa_unit = signals_list.unit{strcmpi(signals_list.name, ...
    selected_abscissa)};
if isempty(selected_abscissa_unit) && ~isempty(strfind(...
        selected_abscissa, 'time')); selected_abscissa_unit = 's'; end;

selected_ordinate_unit = signals_list.unit{strcmpi(signals_list.name, ...
    selected_ordinate)};

if exist_extra_ordinate; selected_extra_ordinate_unit = signals_list.unit{...
        strcmpi(signals_list.name, selected_extra_ordinate)}; end;

% Plots according to the number of ordinate
% -----------------------------------------
if ~exist_extra_ordinate
    
    % Plot the curve on the graphic
    % -----------------------------
    handles.AxCurve = plot(handles.AxPlots, selected_abscissa_value, ...
        selected_ordinate_value);
    grid(handles.AxPlots, 'on');
    
    % Update colors and line style
    % ----------------------------
    set(handles.AxCurve, 'Color', 'red', 'LineWidth', 1.5);
    
    % Define the different labels
    % ---------------------------
    xlabel(handles.AxPlots, strrep([selected_abscissa, ' [', ...
        selected_abscissa_unit, ']'], '_','\_'));
    ylabel(handles.AxPlots, strrep([selected_ordinate, ' [', ...
        selected_ordinate_unit, ']'], '_','\_'));
    
else
    
    % Define the two y label using plotyy
    [tmp_axes, handles.AxCurve(1), handles.AxCurve(2)] = plotyy(...
        selected_abscissa_value, selected_ordinate_value, ...
        selected_abscissa_value, selected_extra_ordinate_value, ...
        'Parent', handles.AxPlots);
    
    % Define the different labels
    % ---------------------------
    xlabel(handles.AxPlots, strrep([selected_abscissa, ' [', ...
        selected_abscissa_unit, ']'], '_','\_'));
    ylabel(tmp_axes(1), strrep([selected_ordinate, ' [', ...
        selected_ordinate_unit, ']'], '_','\_'), 'Color', 'red');
    ylabel(tmp_axes(2), strrep([selected_extra_ordinate, ' [', ...
        selected_extra_ordinate_unit, ']'], '_','\_'), 'Color', 'blue');
    
    % Update colors and line style
    % ----------------------------
    set(handles.AxCurve(1), 'LineWidth', 1.5, 'Color', 'red');
    set(handles.AxCurve(2), 'LineWidth', 1.5, 'Color', 'blue');
    set(tmp_axes(1), 'YColor', 'red');
    set(tmp_axes(2), 'YColor', 'blue');
    
    % Define the legend
    % -----------------
    legend(handles.AxPlots, 'String', {strrep(selected_ordinate, '_','\_'), ...
        strrep(selected_extra_ordinate, '_','\_')});
    
end

% Save handles structure
% ----------------------
guidata(handles.FgAdvanced, handles);
%==========================================================================

function signals_data_OUT = LocalLoadSignals(varargin)
%==========================================================================
%% DESCRIPTION: Manage interface data behaviour
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   varargin	: command line arguments to LocalUpdateDisplay (see
%                 VARARGIN)
%==========================================================================
% OUTPUT:
%==========================================================================

% Initialize local variable
% -------------------------
update_mode = 'default';

% Manage input arguments
% ----------------------
if nargin > 0 && ischar(varargin{1}); update_mode = varargin{1}; end;

% Get figure handles structure
% ----------------------------
handles = guidata(findobj('Tag', 'FgAdvanced'));

% Manage default directory
% ------------------------
if ismember(update_mode, {'initialization', 'add_sources'})
    
    % Get the UserData structure
    user_data = getappdata(handles.FgAdvanced, 'UserData');
    
    % Define the default data directory content
    if exist(fullfile(user_data.WORK_DIR, 'data', 'test_folder'), 'dir')==7
        
        current_folder = fullfile(user_data.WORK_DIR, 'data', 'test_folder');
        data_directory = dir(fullfile(user_data.WORK_DIR, 'data', ...
            'test_folder', '*.mat'));
        
    else
        
        % Get the MainData structure
        main_data = getappdata(handles.FgAdvanced, 'MainData');
        
        if exist(fullfile(main_data.SOFT_DATA_DEFAULT, 'test_folder'), ...
                'dir') == 7
            
            current_folder = fullfile(main_data.SOFT_DATA_DEFAULT, ...
                'test_folder');
            data_directory = dir(fullfile(main_data.SOFT_DATA_DEFAULT, ...
                'test_folder', '*.mat'));
            
        else
            
            current_folder = '';
            data_directory = [];
            
        end
        
    end
    
end

if strcmpi(update_mode, 'initialization')
    
    % Define the the signals collection
    signals_data_OUT = cSignalsData;
    
    % Manage empty directory
    if isempty(data_directory); return; end;
    
    % Define currents files
    for i_file = 1:length(data_directory)
        
        current_files{i_file} = fullfile(current_folder, ...
            data_directory(i_file).name); %#ok<AGROW>
        
    end
    
elseif strcmpi(update_mode, 'add_sources')
    
    % Load signal data
    signals_data_OUT = getappdata(handles.FgAdvanced, 'SignalsData');
    
    % Get the files defined from the user
    [file_name, path_name, ~] = uigetfile(...
        {'*.mat','GSP Results files (*.mat)'}, 'Advanced interface', ...
        current_folder, 'MultiSelect','on');
    
    % Manage cancellation
    if isnumeric(file_name) && isnumeric(path_name); return; end;
    
    % Define the selected files
    if ischar(file_name); file_names{1} = file_name; else file_names = file_name; end;
    
    % Initialize current files
    current_files = cell(1, length(file_names));
    
    for i_file = 1:length(file_names)
        
        current_files{i_file} = fullfile(path_name, file_names{i_file});
        
    end
    
end

% Define signals sets
for i_file = 1:length(current_files)
    
    % Define the signals
    current_signals = cSignals;
    
    % Initialize the signals content
    current_signals = current_signals.initialize(current_files{i_file});
    
    % Update collection
    signals_data_OUT = signals_data_OUT.addElement(current_signals.getName, ...
        current_signals);
    
end
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
    handles = guidata(findobj('Tag', 'FgAdvanced'));
    
    % Identify if other children windows are open
    % -------------------------------------------
    children_figure_handle_list = mt_manage_open_children_figure_pre(...
        handles.FgAdvanced);
    
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
