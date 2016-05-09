function obj_OUT = setScreensize(obj_IN, varargin)
%==========================================================================
% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: setScreensize.m
% PATH: ..\common\@cGuiManager
%==========================================================================
% ABSTRACT: Set the right screensize
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
        obj_OUT.screensize), 'Checked', 'off');

    % Load mandatory data
    user_data = getappdata(obj_OUT.current_figure_handle, 'UserData');

    % Update user data with the new language
    user_data.SCREEN_SIZE = varargin{1};

    % Save user data structure
    setappdata(obj_OUT.current_figure_handle, 'UserData', user_data);
    
    % Deselect the current language menu
    set(findobj(obj_OUT.current_figure_handle, 'UserData', ...
        obj_OUT.screensize), 'Checked', 'on');

end

% Verify if the filename is valid
% -------------------------------
if isempty(obj_OUT.screensize_filename); return; end;

% Save figure initial position
% ----------------------------
figure_initial_position = get(obj_OUT.current_figure_handle, 'Position');

% Read the corresponding message filename
% ---------------------------------------
% open the file
fid = fopen(obj_OUT.screensize_filename, 'r');

% Manage error in file opening
if (fid <0); return; end;

% Read file content
file_content  = textscan(fid, '%s%s', 'CommentStyle', '%', ...
    'Delimiter', '\t', 'MultipleDelimsAsOne', 1);

% Close file
fclose(fid);

% Get figure handles
% ------------------
handles = guihandles(obj_OUT.current_figure_handle);

% Create specific message structure
% ---------------------------------
for i_object = 1:length(file_content{1})
    
   if isfield(handles, file_content{1}{i_object}) && ...
           length(str2num(file_content{2}{i_object})) == 4 %#ok<ST2NM>
       
       set(handles.(deblank(file_content{1}{i_object})), ...
           'Units', 'pixels', 'Position', str2num(...
           file_content{2}{i_object})); %#ok<ST2NM>

   elseif isfield(handles, file_content{1}{i_object}) && ...
           length(str2num(file_content{2}{i_object})) == 1 %#ok<ST2NM>

       set(handles.(deblank(file_content{1}{i_object})), ...
           'FontUnits', 'pixels', 'FontSize', str2num(...
           file_content{2}{i_object})); %#ok<ST2NM>
       
   end
   
end

% Define figure new position
% --------------------------
figure_new_position = get(obj_OUT.current_figure_handle, 'Position');

% Update figure position
% ----------------------
set(obj_OUT.current_figure_handle, 'Position', ...
    [figure_initial_position([1,2]), figure_new_position([3,4])]);
%==========================================================================
