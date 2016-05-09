function obj_OUT = setParentFigureHandle(obj_IN, value_IN)
%==========================================================================
% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: setParentFigureHandle.m
% PATH: ..\common\@cGuiManager
%==========================================================================
% ABSTRACT: Get the parent figure handle
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES         AROB@S      23/09/2013  Class creation
%	Mathieu CABANES         AROB@S      26/02/2014  Quality update & speed
%                                                   optimization
%
%   <NAME>       	<COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cGuiManager object
%   value_IN    : handle of the figure to set
%==========================================================================
% OUTPUT:
%   obj_OUT     : Updated cGuiManager object
%==========================================================================

% Manage input
% ------------
if ~ishandle(value_IN); throw(ClassCastException(...
        'Object handle required as input')); end;

% Initialize output variable
% --------------------------
obj_OUT = obj_IN;

% Get the figure name
% -------------------
obj_OUT.parent_figure_handle = value_IN;
%==========================================================================
