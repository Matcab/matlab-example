function obj_OUT = display(obj_IN, varargin)
%==========================================================================
% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: display.m
% PATH: ..\common\@cErrorManager
%==========================================================================
% ABSTRACT: Display the error
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES         AROB@S      23/10/2013  Class creation
%	Michel OLPHE GALLIARD 	AROB@S      26/02/2014  Quality update & speed
%                                                   optimization
%
%   <NAME>       	<COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cErrorManager object
%   varargin    : command line arguments to display (see VARARGIN)
%==========================================================================
% OUTPUT:
%   obj_OUT     : Updated cErrorManager object
%==========================================================================

% Manage input arguments
% ----------------------
if nargin>1 && ~isa(varargin{1}, 'MException') && ~iscell(varargin{1}) ...
        && ~ischar(varargin{1})

    throw(ClassCastException('MException or string required as input'));

end

if nargin>2 && ~ischar(varargin{2}); throw(ClassCastException(...
        'String required as input')); end;

% Initialize output variable
% --------------------------
obj_OUT = obj_IN;

% Update message if necessary
% ---------------------------
if nargin>1; obj_OUT = obj_OUT.setError(varargin{:}); end;

% Display the message
% -------------------
LocalDisplayError(obj_OUT);

% Save the message into the error log file
% ----------------------------------------
obj_OUT.updateErrorLog;

% Update promt to facilitate debug
% --------------------------------
if ~isdeployed; obj_OUT.updatePrompt; end;

% Reinitialize error content
% --------------------------
obj_OUT = obj_OUT.initialize;
%==========================================================================

function LocalDisplayError(obj_IN)
%==========================================================================
%% DESCRIPTION: System error management
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cErrorManager object
%   varargin    : command line arguments to display (see VARARGIN)
%==========================================================================
% OUTPUT:
%==========================================================================

% initialize local variables
% --------------------------
icon_data_path = obj_IN.data_picture;

% Identify multiple item catched
% ------------------------------
if ~obj_IN.isMultipleError
    
    % Define the error
    [current_error, tmp_type] = obj_IN.getError('last');
    
    % Define the type of error
    all_type{1}  = tmp_type;
    current_type = all_type;
    
else
    
    % Define the first error
    [~, first_type] = obj_IN.getError('first');
    
    if strcmpi(first_type, 'applicative_error') || ...
            strcmpi(first_type, 'warning')
        
        % Define all errors
        all_error = obj_IN.getError('all');

        if ismember('system_error', {all_error.type})

            % Update current error
            current_error = all_error(find(strcmpi({all_error.type}, ...
                'system_error')==1, 1, 'last')).exception;
            
            % Define the type of error
            all_type{1}  =  all_error(find(strcmpi({all_error.type}, ...
                'system_error')==1, 1, 'last')).type;
            current_type = all_type;
            
        else
        
            % Update current error
            current_error = [all_error.exception];
            
            % Update the type of errors
            all_type      = {all_error.type};
            current_type  = unique(all_type);
        
        end
        
    else
        
        % Define the error
        [current_error, tmp_type] = obj_IN.getError('first');
        
        % Define the type of error
        all_type{1}  = tmp_type;
        current_type = all_type;
        
    end
    
end

% Manage case with no error defined
if isempty(current_error) || isempty(current_type); return; end;

% Initialize loval variable
% -------------------------
handles = cell(length(current_type), 1);

% Define error interface one for each type
% ----------------------------------------
for i_type = 1:length(current_type)
    
    % Update local variable
    error_message  = '';
    
    % Create the interface
    handles{i_type} = LocalCreateErrorManagerFigure(obj_IN);
    
    % Update interface according to current type
    current_type{i_type} = LocalUpdateObjects(obj_IN, handles{i_type}, ...
        current_type{i_type});
    
    % Display the error
    switch current_type{i_type}
        
        case {'degraded_system_error', 'system_error'}
            
            % Display the main informations
            figure_name   = 'Error management';
            current_title = 'SYSTEM ERROR';
            icon_image    = imread(fullfile(icon_data_path, ...
                'error_icon.png'), 'BackgroundColor', ...
                get(handles{i_type}.FgError, 'Color'));
            
            if ~isempty(obj_IN.applicative_id)
                
                current_subtitle = ['Error generated from ', ...
                    obj_IN.applicative_id, ' - ', datestr(now)];
                
            else
                
                current_subtitle = ['Error - ', datestr(now)];
                
            end
            
            % Display the error informations
            if ~isempty(current_error.stack)
                
                [~, current_file] = fileparts(current_error.stack(1).file);
                set(handles{i_type}.StFileContent, 'String', ...
                    [current_file, '.m']);
                set(handles{i_type}.StFunctionContent, 'String', ...
                    current_error.stack(1).name);
                set(handles{i_type}.StLineContent, 'String', ...
                    current_error.stack(1).line);
                
            else
                
                set(handles{i_type}.StFileContent, 'String', '');
                set(handles{i_type}.StFunctionContent, 'String', '');
                set(handles{i_type}.StLineContent, 'String', '');
                
            end
            
            error_message = sprintf('%s\n', [current_error.message, ...
                '(', current_error.identifier, ')']);
            
            % Manage cause error
            if ~isempty(current_error.cause)
                
                % Define the list of causes
                cause_error = current_error.cause;
                
                % Define corresponding string
                tmp_cause = LocalManageCauseError(cause_error);
                
                % Write the main message
                error_message = sprintf('%s\n%s', error_message, ...
                    tmp_cause);
                
            end
            
            error_message = sprintf('%s\n', error_message);
            
            if length(error_message)>250
                
                set(handles{i_type}.StMessageContent, 'Style', 'edit', ...
                    'Min', 0, 'Max', 2, 'Value', [], 'String', '', ...
                    'Enable', 'inactive');
                error_cell = LocalDefineCellFromString(error_message);
                set(handles{i_type}.StMessageContent, 'String', error_cell);
                
            else
                
                set(handles{i_type}.StMessageContent, 'String', error_message);
                
            end
            
        case 'applicative_error'
            
            % Display the main informations
            figure_name   = 'Error management';
            current_title = 'APPLICATIVE ERROR';
            icon_image    = imread(fullfile(icon_data_path, ...
                'error_icon.png'), 'BackgroundColor', ...
                get(handles{i_type}.FgError, 'Color'));
            
            if ~isempty(obj_IN.applicative_id)
                
                current_subtitle = ['Error generated from ', ...
                    obj_IN.applicative_id, ' - ', datestr(now)];
                
            else
                
                current_subtitle = ['Error - ', datestr(now)];
                
            end
            
            % Display the error informations
            for i_err = 1:length(current_error)
                
                % Identify the type of error
                if strcmpi(all_type{i_err}, current_type{i_type})
                    
                    % Manage the main error
                    if ~isempty(current_error(i_err).identifier)
                        
                        tmp_message = [current_error(i_err).message, ' (', ...
                            current_error(i_err).identifier, ')'];
                        
                    else
                        
                        tmp_message = current_error(i_err).message;
                        
                    end
                    
                    % Write the main message
                    if i_err == 1
                        
                        error_message = sprintf('%s', tmp_message);
                        
                    else
                        
                        error_message = sprintf('%s\n%s', error_message, ...
                            tmp_message);
                        
                    end
                    
                    % Manage cause error
                    if ~isempty(current_error(i_err).cause)
                        
                        % Define the list of causes
                        cause_error = current_error(i_err).cause;
                        
                        % Define corresponding string
                        tmp_cause = LocalManageCauseError(cause_error);
                        
                        % Write the main message
                        error_message = sprintf('%s\n%s', error_message, ...
                            tmp_cause);
                        
                    end
                    
                    error_message = sprintf('%s\n', error_message);
                    
                end
                
            end
            
            % Add a footer message
            if ~isempty(error_message)
                
                if obj_IN.footer_enable
                    % add more detail foot note
                    % -------------------------
                    error_message = sprintf('%s\n%s%s%s\n', error_message, ...
                        'For more details, please have a look in the log ',...
                        'file using the menu "Options/Log/Log file" located ', ...
                        'on the main interface.');
                end
                
                if length(error_message)>350
                    
                    set(handles{i_type}.StInformationContent, 'Style', ...
                        'edit', 'Min', 0, 'Max', 2, 'Value', [], ...
                        'String', '', 'Enable', 'inactive');
                    error_cell = LocalDefineCellFromString(error_message);
                    set(handles{i_type}.StInformationContent, 'String', ...
                        error_cell);
                    
                else
                    
                    set(handles{i_type}.StInformationContent, 'String', ...
                        error_message);
                    
                end
                
            end
            
        case 'warning'
            
            if obj_IN.getWarningEnable
                
                % Define the main informations
                figure_name   = 'Warning management';
                current_title = 'APPLICATIVE WARNING';
                icon_image    = imread(fullfile(icon_data_path, ...
                    'warning_icon.png'), 'BackgroundColor', ...
                    get(handles{i_type}.FgError, 'Color'));
                
                if ~isempty(obj_IN.applicative_id)
                    
                    current_subtitle = ['Warning generated from ', ...
                        obj_IN.applicative_id, ' - ', datestr(now)];
                    
                else
                    
                    current_subtitle = ['Warning - ', datestr(now)];
                    
                end
                
                % Display the error informations
                for i_err = 1:length(current_error)
                    
                    % Identify the type of error
                    if strcmpi(all_type{i_err}, current_type{i_type})
                        
                        if isempty(error_message)
                            
                            error_message = sprintf('%s', ...
                                current_error(i_err).message);
                            
                        else
                            
                            error_message = sprintf('%s\n\n%s', ...
                                error_message, current_error(i_err).message);
                            
                        end
                        
                        % Manage cause error
                        if ~isempty(current_error(i_err).cause)
                            
                            % Define the list of causes
                            cause_error = current_error(i_err).cause;
                            
                            % Define corresponding string
                            tmp_cause = LocalManageCauseError(cause_error, ...
                                'warning');
                            
                            % Write the main message
                            error_message = sprintf('%s\n%s', error_message, ...
                                tmp_cause);
                            
                        end
                        
                        error_message = sprintf('%s\n', error_message);
                        
                    end
                    
                end
                
                % Add a footer message
                if ~isempty(error_message)
                    
                    error_message = sprintf('%s\n\n%s %s %s\n', ...
                        error_message, 'No error has been generated.', ...
                        'This message is just standard information.', ...
                        'The process has succesfuly ended.');
                    
                    if length(error_message)>350
                        
                        set(handles{i_type}.StInformationContent, 'Style', ...
                            'edit', 'Min', 0, 'Max', 2, 'Value', [], ...
                            'String', '', 'Enable', 'inactive');
                        error_cell = LocalDefineCellFromString(...
                            error_message);
                        set(handles{i_type}.StInformationContent, ...
                            'String', error_cell);
                        
                    else
                        
                        set(handles{i_type}.StInformationContent, 'String', ...
                            error_message);
                        
                    end
                    
                end
                
            end
    end
    
    if ~isempty(error_message)
        
        % Display the main information
        set(handles{i_type}.StTitle, 'String', current_title);
        set(handles{i_type}.StSubTitle, 'String', current_subtitle);
        set(handles{i_type}.PbIcon, 'CData', icon_image);
        set(handles{i_type}.FgError, 'Name', figure_name, 'Visible', 'on');
        
    end
    
end
%==========================================================================

function handles_OUT = LocalCreateErrorManagerFigure(obj_IN, varargin)
%==========================================================================
%% DESCRIPTION: System error management
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cErrorManager object
%==========================================================================
% OUTPUT:
%   handles_OUT	: handle structure of interface
%==========================================================================

% Create common part
% ------------------
handles_OUT.FgError = figure('Tag', 'FgError', 'MenuBar', 'none', ...
    'Toolbar', 'none', 'NumberTitle', 'off', 'DockControl', 'off', ...
    'Name', '', 'Units', 'pixels', 'Position', [200 200 500 290], ...
    'Resize', 'off', 'Visible', 'off', 'Color', [0.941,0.941,0.941]);
handles_OUT.PbIcon = uicontrol('Tag', 'PbIcon', 'Style', 'pushbutton', ...
    'Parent', handles_OUT.FgError, 'Callback', [], 'String', '', ...
    'Units', 'pixels', 'Position', [20 220 50 50], 'Enable', 'inactive');
handles_OUT.StTitle = uicontrol('Tag', 'StTitle', 'Style', 'text', ...
    'Parent', handles_OUT.FgError, 'String', '', 'Units', 'pixels', ...
    'Position', [100 250 380 20], 'FontName', 'Calibri', 'FontSize', 18, ...
    'FontUnit', 'pixels', 'FontWeight', 'bold', 'HorizontalAlignment', ...
    'left');
handles_OUT.StSubTitle = uicontrol('Tag', 'StSubTitle', 'Style', 'text', ...
    'Parent', handles_OUT.FgError,'String', '', 'Units', 'pixels', ...
    'Position', [100 220 380 20], 'FontName', 'Calibri', 'FontSize', 12, ...
    'FontUnit', 'pixels', 'FontWeight', 'normal', 'HorizontalAlignment', ...
    'left');

% Create system error panel
% -------------------------
handles_OUT.PnErrorSystem = uipanel('Tag', 'PnErrorSystem', 'Parent', ...
    handles_OUT.FgError, 'Title', '', 'Units', 'pixels', 'Position', ...
    [10 40 480 160], 'Visible', 'off');
handles_OUT.StFile = uicontrol('Tag', 'StFile', 'Style', 'text', ...
    'Parent', handles_OUT.PnErrorSystem, 'String', 'FILE: ', 'Units', ...
    'pixels', 'Position', [10 130 60 15], 'FontName', 'Calibri', ...
    'FontSize', 9, 'FontUnit', 'pixels', 'FontWeight', 'bold', ...
    'HorizontalAlignment', 'right');
handles_OUT.StFileContent = uicontrol('Tag', 'StFileContent', 'Style', ...
    'text', 'Parent', handles_OUT.PnErrorSystem, 'String', '', 'Units', ...
    'pixels', 'Position', [80 130 370 15], 'FontName', 'Calibri', ...
    'FontSize', 9, 'FontUnit', 'pixels', 'FontWeight', 'normal', ...
    'HorizontalAlignment', 'left');
handles_OUT.StFunction = uicontrol('Tag', 'StFunction', 'Style', 'text', ...
    'Parent', handles_OUT.PnErrorSystem, 'String', 'FUNCTION: ', 'Units', ...
    'pixels', 'Position', [10 110 60 15], 'FontName', 'Calibri', ...
    'FontSize', 9, 'FontUnit', 'pixels', 'FontWeight', 'bold', ...
    'HorizontalAlignment', 'right');
handles_OUT.StFunctionContent = uicontrol('Tag', 'StFunctionContent', ...
    'Style', 'text', 'Parent', handles_OUT.PnErrorSystem, 'String', '', ...
    'Units', 'pixels', 'Position', [80 110 390 15], 'FontName', ...
    'Calibri', 'FontSize', 9, 'FontUnit', 'pixels', 'FontWeight', ...
    'normal', 'HorizontalAlignment', 'left');
handles_OUT.StLine = uicontrol('Tag', 'StLine', 'Style', 'text', ...
    'Parent', handles_OUT.PnErrorSystem, 'String', 'LINE: ', 'Units', ...
    'pixels', 'Position', [10 90 60 15], 'FontName', 'Calibri', ...
    'FontSize', 9, 'FontUnit', 'pixels', 'FontWeight', 'bold', ...
    'HorizontalAlignment', 'right');
handles_OUT.StLineContent = uicontrol('Tag', 'StLineContent', ...
    'Style', 'text', 'Parent', handles_OUT.PnErrorSystem, 'String', '', ...
    'Units', 'pixels', 'Position', [80 90 390 15], 'FontName', ...
    'Calibri', 'FontSize', 9, 'FontUnit', 'pixels', 'FontWeight', ...
    'normal', 'HorizontalAlignment', 'left');
handles_OUT.StMessage = uicontrol('Tag', 'StMessage', 'Style', 'text', ...
    'Parent', handles_OUT.PnErrorSystem, 'String', 'MESSAGE: ', 'Units', ...
    'pixels', 'Position', [10 70 60 15], 'FontName', 'Calibri', ...
    'FontSize', 9, 'FontUnit', 'pixels', 'FontWeight', 'bold', ...
    'HorizontalAlignment', 'right');
handles_OUT.StMessageContent = uicontrol('Tag', 'StMessageContent', ...
    'Style', 'text', 'Parent', handles_OUT.PnErrorSystem, 'String', '', ...
    'Units', 'pixels', 'Position', [80 10 390 75], 'FontName', ...
    'Calibri', 'FontSize', 9, 'FontUnit', 'pixels', 'FontWeight', ...
    'bold', 'HorizontalAlignment', 'left');

% Create the other panel
handles_OUT.PnInformation = uipanel('Tag', 'PnInformation', 'Parent', ...
    handles_OUT.FgError, 'Title', '', 'Units', 'pixels', 'Position', ...
    [20 40 460 160], 'Visible', 'off');
handles_OUT.StInformation = uicontrol('Tag', 'StInformation', 'Style',...
    'text', 'Parent', handles_OUT.PnInformation, 'String', 'MESSAGE: ', ...
    'Units', 'pixels', 'Position', [10 130 70 15], 'FontName', 'Calibri', ...
    'FontSize', 9, 'FontUnit', 'pixels', 'FontWeight', 'bold', ...
    'HorizontalAlignment', 'right');
handles_OUT.StInformationContent = uicontrol('Tag', ...
    'StInformationContent', 'Style', 'text', 'Parent', ...
    handles_OUT.PnInformation, 'String', '', 'Units', 'pixels', ...
    'Position', [90 10 380 135], 'FontName', 'Calibri', 'FontSize', 9, ...
    'FontUnit', 'pixels', 'FontWeight', 'bold', 'HorizontalAlignment', ...
    'left');

% Manage bug report button if necessary
% -------------------------------------
report_message = 'Would you like to report this error to the developer?';
handles_OUT.StReport = uicontrol('Tag', 'StReport', 'Style', 'text', ...
    'Parent', handles_OUT.FgError, 'String', report_message, 'Units', ...
    'pixels', 'Position', [10 10 310 15], 'FontName', 'Calibri', ...
    'FontSize', 9, 'FontUnit', 'pixels', 'FontWeight', 'normal',...
    'HorizontalAlignment', 'left');
handles_OUT.PbReport = uicontrol('Tag', 'PbReport', 'Style', ...
    'pushbutton', 'Parent', handles_OUT.FgError, 'String', 'YES', ...
    'Units', 'pixels', 'Position', [380 10 50 20], 'Enable', 'on');
handles_OUT.PbClose = uicontrol('Tag', 'PbClose', 'Style', 'pushbutton', ...
    'Parent', handles_OUT.FgError, 'String', 'NO', 'Units', 'pixels', ...
    'Position', [440 10 50 20], 'Enable', 'on');

set(handles_OUT.PbReport, 'Callback', @(src, event)manageReport(obj_IN, ...
    src, event, handles_OUT, 'report'));
set(handles_OUT.PbClose, 'Callback', @(src, event)manageReport(obj_IN, ...
    src, event, handles_OUT, 'close'));
%==========================================================================

function current_type_OUT = LocalUpdateObjects(obj_IN, handles_IN, ...
    current_type_IN)
%==========================================================================
%% DESCRIPTION: System error management
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cErrorManager object
%   varargin    : command line arguments to display (see VARARGIN)
%==========================================================================
% OUTPUT:
%==========================================================================

% Manage input arguments
% ----------------------
if ~obj_IN.bug_report && strcmpi(current_type_IN, 'system_error')
    
    current_type_OUT = 'degraded_system_error';
    
else
    
    current_type_OUT = current_type_IN;
    
end

switch current_type_OUT
    
    case 'system_error'
        
        % Update figure position
        set(handles_IN.FgError, 'Position', [200 200 500 290]);
        set(handles_IN.PbIcon, 'Position', [20 220 50 50]);
        set(handles_IN.StTitle, 'Position', [100 250 380 20]);
        set(handles_IN.StSubTitle, 'Position', [100 220 380 20]);
        
        % Display the right panel
        set(handles_IN.PnErrorSystem, 'Position', [10 40 480 160], ...
            'Visible', 'on');
        set(handles_IN.PnInformation, 'Position', [10 40 480 160], ...
            'Visible', 'off');
        
        % Define report button properties
        set(handles_IN.StReport, 'Visible', 'on');
        set(handles_IN.PbReport, 'Visible', 'on');
        set(handles_IN.PbClose, 'Visible', 'on');
        
    case 'degraded_system_error'
        
        % Update figure position
        set(handles_IN.FgError, 'Position', [200 200 500 260]);
        set(handles_IN.PbIcon, 'Position', [20 190 50 50]);
        set(handles_IN.StTitle, 'Position', [100 220 380 20]);
        set(handles_IN.StSubTitle, 'Position', [100 190 380 20]);
        
        % Display the right panel
        set(handles_IN.PnErrorSystem, 'Position', [10 10 480 160], ...
            'Visible', 'on');
        set(handles_IN.PnInformation, 'Position', [10 10 480 160], ...
            'Visible', 'off');
        
        % Define report button properties
        set(handles_IN.StReport, 'Visible', 'off');
        set(handles_IN.PbReport, 'Visible', 'off');
        set(handles_IN.PbClose, 'Visible', 'off');
        
    otherwise
        
        % Update figure position
        set(handles_IN.FgError, 'Position', [200 200 500 260]);
        set(handles_IN.PbIcon, 'Position', [20 190 50 50]);
        set(handles_IN.StTitle, 'Position', [100 220 380 20]);
        set(handles_IN.StSubTitle, 'Position', [100 190 380 20]);
        
        % Display the right panel
        set(handles_IN.PnErrorSystem, 'Position', [10 10 480 160], ...
            'Visible', 'off');
        set(handles_IN.PnInformation, 'Position', [10 10 480 160], ...
            'Visible', 'on');
        
        % Define report button properties
        set(handles_IN.StReport, 'Visible', 'off');
        set(handles_IN.PbReport, 'Visible', 'off');
        set(handles_IN.PbClose, 'Visible', 'off');
        
end
%==========================================================================

function string_OUT = LocalManageCauseError(cause_error_IN, varargin)
%==========================================================================
%% DESCRIPTION: System error management
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cErrorManager object
%   varargin    : command line arguments to display (see VARARGIN)
%==========================================================================
% OUTPUT:
%==========================================================================

% Initialize local variable
% -------------------------
is_warning = false;

% Manage input arguments
% ----------------------
if nargin > 1 && ischar(varargin{1}) && strcmpi(varargin{1}, 'warning'); ...
        is_warning = true; end;

% Define output variable
% ----------------------
string_OUT = '';

% Display the error informations
for i_cause = 1:length(cause_error_IN)
    
    % Manage the main error
    if ~isempty(cause_error_IN{i_cause}.identifier) && ~is_warning
        
        tmp_cause = [cause_error_IN{i_cause}.message, ' (', ...
            cause_error_IN{i_cause}.identifier, ')'];
        
    else
        
        tmp_cause = cause_error_IN{i_cause}.message;
        
    end
    
    % Write the main message
    if isempty(string_OUT)
        
        string_OUT = sprintf('%s', tmp_cause);
        
    else
        
        string_OUT = sprintf('%s\n%s', string_OUT, tmp_cause);
        
    end
    
    % Manage cause of causes
    if ~isempty(cause_error_IN{i_cause}.cause)
        
        % define the corresponding string
        current_string = LocalManageCauseError(cause_error_IN{i_cause}.cause);
        
        % Write the main message
        if isempty(string_OUT)
            
            string_OUT = sprintf('%s', current_string);
            
        else
            
            string_OUT = sprintf('%s\n%s', string_OUT, current_string);
            
        end
        
    end
    
end
%==========================================================================

function cell_OUT = LocalDefineCellFromString(string_IN, varargin)
%==========================================================================
%% DESCRIPTION: System error management
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cErrorManager object
%   varargin    : command line arguments to display (see VARARGIN)
%==========================================================================
% OUTPUT:
%==========================================================================

cell_OUT = {};
expression = '\n';

tmp_cell = regexp(string_IN, expression, 'split');

for i_cell = 1:length(tmp_cell)
    
    current_string = tmp_cell{i_cell};
    current_length = length(current_string);
    
    while current_length > 150
        
        tmp_index  = find(current_string==' ');
        char_index = tmp_index(find(tmp_index<=140, 1, 'last'));
        
        if ~isempty(char_index)
            
            cell_OUT{end+1,1} = ...
                current_string(1:char_index-1); %#ok<AGROW>
            current_string    = current_string(char_index+1:end);
            current_length    = length(current_string);
            
        else
            
            break;
            
        end
        
    end
    
    cell_OUT{end+1,1} = current_string(1:end); %#ok<AGROW>
    
end
%==========================================================================
