function obj_OUT = setLanguage(obj_IN, varargin)
%==========================================================================
% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: setMessages.m
% PATH: ..\common\@cGuiManager
%==========================================================================
% ABSTRACT: 
%   Set a new language for the interface including changing labels and
%   messages
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES         AROB@S      23/09/2013  Class creation
%	Michel OLPHE GALLIARD 	AROB@S      26/02/2014  Quality update & speed
%                                                   optimization
%
%   <NAME>       	<COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cGuiManager object
%==========================================================================
% OUTPUT:
%   obj_OUT     : Updated cGuiManager object
%==========================================================================

% Manage input arguments
% ----------------------
if nargin>1 && ~ischar(varargin{1}); throw(ClassCastException(...
        'String required as input')); end;

% Initialize output variable
% --------------------------
obj_OUT = obj_IN;

% Update language and manage interface
% ------------------------------------
if nargin > 1 
        
    % Deselect the current language menu
    set(findobj(obj_OUT.current_figure_handle, 'UserData', ...
        obj_OUT.language), 'Checked', 'off');

    % Load mandatory data
    user_data = getappdata(obj_OUT.current_figure_handle, 'UserData');

    % Update user data with the new language
    user_data.LANGUAGE = varargin{1};

    % Save user data structure
    setappdata(obj_OUT.current_figure_handle, 'UserData', user_data);
    
    % Deselect the current language menu
    set(findobj(obj_OUT.current_figure_handle, 'UserData', ...
        obj_OUT.language), 'Checked', 'on');

end

% Verify if the filename is valid
% -------------------------------
if isempty(obj_OUT.label_filename); return; end;

% Read the corresponding message filename
% ---------------------------------------
% open the file
fid = fopen(obj_OUT.label_filename, 'r');

% Manage error in file opening
if (fid <0); return; end;

% Read file content
file_content  = textscan(fid, '%s%s%s', 'CommentStyle', '%');

% Close
fclose(fid);

% Create specific message structure
% ---------------------------------
for i_property = 1:length(file_content{1})
    
    % Check if the current property is valid for label definition
    % (including table properties)
    if ~ismember(lower(file_content{2}{i_property}), {'string', 'title', ...
            'label', 'name', 'tooltipstring', 'columnname', 'rowname'})
        continue;
    end
    
    % Convert property by replace '-' with space and <moins> with '-'
    file_content{3}{i_property} = strrep(file_content{3}{i_property}, ...
        '-', ' ');
    file_content{3}{i_property} = strrep(file_content{3}{i_property},...
        '<moins>', '-');
    
    % This line is added to extract values separated by | and [] in a cell
    % array of strings. It is possible to add other separator by specify
    % them in expression, e.g. [^|[],] will also work with ,
    if ismember(lower(file_content{2}{i_property}), ...
            {'columnname', 'rowname'})
        
        if ~strcmpi(file_content{3}{i_property},'[]')
            
            file_content{3}{i_property} = regexp(file_content{3}{...
                i_property}, '[^|[]]+','match');
            
        else
            
            file_content{3}{i_property} = str2num(file_content{3}{...
                i_property}); %#ok<ST2NM>
            
        end
    end
    
    % Apply property to object
    if ~strcmpi(file_content{3}{i_property}, '#')
        
        set(findobj(obj_OUT.current_figure_handle, 'Tag', ...
            file_content{1}{i_property}), file_content{2}{i_property}, ...
            file_content{3}{i_property});
        
    end
   
end

% Update messages list
% --------------------
obj_OUT = obj_OUT.setMessages;
%==========================================================================
