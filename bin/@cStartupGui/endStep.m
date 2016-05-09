function obj_OUT = endStep(obj_IN, varargin)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: endStep.m
% PATH    : ..\bin\@cStartupGui
%==========================================================================
% ABSTRACT: End current step and update its status
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES         AROB@S      16/05/2011  Creation
%	Mathieu CABANES         AROB@S      15/02/2013  Migration to MATLAB
%                                                   2011b
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cStartupGui object
%   varargin	: commande line argument of endStep (see VARARGIN)
%==========================================================================
% OUTPUT:
%   obj_OUT     : updated cStartupGui object
%==========================================================================

% initialize object
% -----------------
obj_OUT = obj_IN;

% initialize color structure
% --------------------------
current_error = {};
colors = struct( ...
    'ok',           [0 0.5 0], ...  % Green
    'error',        [1 0 0], ...    % Red
    'warning',      [1 0.7 0.4]);   % Orange

% Display information text
% ------------------------
if nargin == 2 && ischar(varargin{1}) && ...
        any(strcmpi(fieldnames(colors), varargin{1}))
    
    % Information string and mode are defined in first input
    info_txt = LocalExtractTxtInfo(varargin{1});
    mode     = lower(varargin{1});
    
elseif nargin == 2 && iscell(varargin{1})
    
    % Initialize
    is_warning   = false;
    is_error     = false;
    message_list = varargin{1};
    
    for i_msg = 1:length(message_list)
        
        current_info = message_list{i_msg};

        if iscell(current_info) && length(current_info)==2 && ...
                ischar(current_info{1,2}) && ...
                strcmpi(current_info{1,2}, 'warning')
            
            % Update status
            if ~is_warning; is_warning = true; end;
        
            % Update current errors
            if isa(current_info{1,1}, 'MException'); ...
                    current_error{end+1} = current_info{1,1}; end; %#ok<AGROW>
            
        elseif iscell(current_info)
            
            % Update status
            if ~is_error; is_error = true; end;

            % Update current errors
            current_error{end+1} = current_info{1,1}; %#ok<AGROW>
            
        elseif isa(current_info, 'MException')
            
            % Update status
            if ~is_error; is_error = true; end;

            % Update current errors
            current_error{end+1} = current_info; %#ok<AGROW>
            
        end
                                            
    end
    
    % Define info text
    if is_error
        
        info_txt = 'ERROR';
        mode     = 'error';
        
    elseif is_warning 
        
        info_txt = 'WARNING';
        mode     = 'warning';
    
    else
        
        info_txt = 'OK';
        mode     = 'ok';
        
    end
    
elseif nargin == 2
        
        % Input define only text to display which is considered as a
        % warning
        info_txt = LocalExtractTxtInfo(varargin{1});
        mode     = 'warning';
    
elseif (nargin == 3) && any(strcmpi(fieldnames(colors),varargin{1})) ...
        && isa(varargin{2}, 'MException')
    
    % Information string and mode are defined by 2 arguments
    info_txt             = LocalExtractTxtInfo(varargin{1});
    mode                 = lower(varargin{1});
    current_error{end+1} = varargin{2};
    
elseif (nargin == 3) && any(strcmpi(fieldnames(colors),varargin{1}))
    
    % Information string and mode are defined by 2 arguments
    info_txt = LocalExtractTxtInfo(varargin{2});
    mode     = lower(varargin{1});
    
elseif (nargin == 3) && any(strcmpi(fieldnames(colors),varargin{2}))
    
    % Information string and mode are defined by 2 arguments
    info_txt = LocalExtractTxtInfo(varargin{1});
    mode     = lower(varargin{2});
    
else
    
    % By default, display OK
    info_txt = 'OK';
    mode     = 'ok';
    
end

% Stock information if a error appears
% ------------------------------------
if (strcmpi(mode, 'error') || strcmpi(mode, 'warning')) && ...
        ~isempty(current_error)
    
    obj_OUT.error_list(end+1:end+length(current_error)) = ...
        current_error(1:length(current_error));
    
elseif strcmpi(mode, 'error')
        
    obj_OUT.error_list{end+1} = lasterror; %#ok<*LERR>

end        

% Create text object and display information
if ishandle(obj_OUT.FgStartupGui) && ...
        (obj_OUT.current_step <= length(obj_OUT.step_list))
    
    % Define current step text definition position
    text_position = get(obj_OUT.StStep(obj_OUT.current_step), 'Position');
    
    % define statust text position
    status_text_position(1) = text_position(1)+text_position(3);
    status_text_position(2) = text_position(2);
    status_text_position(3) = 70;
    status_text_position(4) = text_position(4);
    
    % Create object to display message
    uicontrol('Style', 'text', 'Parent', obj_OUT.FgStartupGui, ...
        'Units', 'pixels', 'BackgroundColor', [0.941, 0.941, 0.941], ...
        'ForegroundColor', colors.(mode), 'HorizontalAlignment', ...
        'right', 'FontName', 'Calibri', 'FontSize', 11, 'FontWeight', ...
        'bold', 'Position', status_text_position, 'String', info_txt);
    
end
%==========================================================================

function [txt_OUT] = LocalExtractTxtInfo(varargin)
%==========================================================================
%% DESCRIPTION: Extract text information to display
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   varargin	: command line arguments to LocalExtractTxtInfo (see
%                 VARARGIN)
%==========================================================================
% OUTPUT:
%   txt_OUT    	: Text of each action defining the initialization process
%==========================================================================
% Initialize variable
% -------------------
tmp_txt = cell(nargin,1);

for i_argin = 1:nargin
    
    if ischar(varargin{i_argin})
        
        tmp_txt{i_argin} = varargin{i_argin};
        
    elseif isstruct(varargin{i_argin}) && isfield(varargin{i_argin}, 'message')
        
        tmp_txt{i_argin} = varargin{i_argin}.message;
        
    else
        
        tmp_txt{i_argin} = '';
        
    end
    
end

% Concatenate to get output text
% ------------------------------
txt_OUT = regexprep(sprintf('%s\n', tmp_txt{:}), '\n$', '');
%==========================================================================