function manageReport(obj_IN, ~, ~, handles, varargin)
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
%   AUTHOR      	COMPANY     DATE        COMMENT
%	Mathieu CABANES	AROB@S      23/10/2013  Class creation
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
if nargin>4 && ischar(varargin{1}) && strcmpi(varargin{1}, 'close')
    
    % Close interface
    delete(handles.FgError);

else
        
    % Get the last error
    [current_error, ~] = obj_IN.getError('last');

    
    % Define the error message
    [~, current_file] = fileparts(current_error.stack(1).file);
    error_message = sprintf(...
        '%s (%s) - Error in function %s (line %d) located in file %s.m', ...
        current_error.message, current_error.identifier, current_file, ...
        current_error.stack(1).line, current_error.stack(1).name);

    % Launch the bug report
    cBugReport('figure_handle', 0, 'priority_level', 1, 'message', ...
        error_message);

    % Close interface
    delete(handles.FgError);

end
%==========================================================================
