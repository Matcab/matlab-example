function close(obj_IN, varargin)
%==========================================================================
% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: close.m
% PATH: ..\common\@cGuiManager
%==========================================================================
% ABSTRACT: Close interface
%==========================================================================
% REVISION HISTORY:
%   AUTHOR      	COMPANY     DATE        COMMENT
%   Laurent Vaylet 	AROB@S   	27/01/2006  Creation
%	Mathieu CABANES	AROB@S      23/09/2013  Class creation
%
%   <NAME>       	<COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%   Save the configuration file if the interface is the main interface
%   Close possible children interface
%   Close the interface
%==========================================================================
% INPUT:
%   obj_IN      : GuiManager object
%   varargin    : command line arguments to close (see VARARGIN)
%==========================================================================
% OUTPUT:
%==========================================================================

% Load mandatory structure
% ------------------------
main_data = getappdata(obj_IN.current_figure_handle, 'MainData');
user_data = getappdata(obj_IN.current_figure_handle, 'UserData');

% Save UserData structure in parent figure
% ----------------------------------------
if (obj_IN.parent_figure_handle == 0) && ~isempty(main_data.SOFT_CFG_FILE)
    
    save(main_data.SOFT_CFG_FILE, '-struct', 'user_data');
    
else
    
    setappdata(obj_IN.parent_figure_handle, 'UserData', user_data);
    
end

% Manage input arguments
% ----------------------
if ~isempty(varargin)
    
    children_fig_hdl = varargin{1};
    delete(children_fig_hdl(1:end));
    
end

if nargin == 3 && ischar(varargin{2}) && strcmpi(varargin{2}, ...
        'only_children'); return; end;

% Close current figure
% --------------------
delete(obj_IN.current_figure_handle);
%==========================================================================

