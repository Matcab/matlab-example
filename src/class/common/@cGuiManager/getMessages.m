function value_OUT = getMessages(obj_IN, varargin)
%==========================================================================
% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: getMessages.m
% PATH: ..\common\@cGuiManager
%==========================================================================
% ABSTRACT: Get the figure name
%==========================================================================
% REVISION HISTORY:
%   AUTHOR      	COMPANY     DATE        COMMENT
%	Mathieu CABANES	AROB@S      23/09/2013  Class creation
%
%   <NAME>       	<COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : GuiManager object
%   varargin	: command line arguments to getMessages (see VARARGIN)
%==========================================================================
% OUTPUT:
%   value_OUT 	: Messages
%==========================================================================

% Manage input arguments
% ----------------------
if nargin>1 && ~ischar(varargin{1}); throw(ClassCastException(...
        'String required as input')); end;

% Define messages according to input argument
% -------------------------------------------
if nargin > 1 && isfield(obj_IN.messages, varargin{1})

    % Get the specific message identified
    value_OUT = obj_IN.messages.(varargin{1});
    
elseif nargin > 1
        
    % Get the missing message identifier
    value_OUT = varargin{1};
    
else
    
    % Get all message structure
    value_OUT = obj_IN.messages;

end
%==========================================================================
