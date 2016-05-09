function obj_OUT = setDropHandles(obj_IN, value_IN)
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% TEMPLATE MATLAB
%==========================================================================
% FILENAME: setDropHandles.m
% PATH    : $TEMPLATE_HOME$\src\class\common\@cDragNDrop
%==========================================================================
% ABSTRACT: Drag and drop: define drop handles
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES       	AROB@S      09/07/2014  Creation
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cDragNDrop object
%   value_IN	: cell array containing all drag handles
%==========================================================================
% OUTPUT:
%   obj_OUT     : Updated cDragNDrop object
%==========================================================================

% Manage input arguments
% ----------------------
if ~all(ishandle(value_IN)); throw(ClassCastException(['Object handles ', ...
        'are required as drop handles'])); end;

% Initialize objects
% ------------------
obj_OUT = obj_IN;

% Define Drag handles
% -------------------
obj_OUT.drop_handles = value_IN;
%==========================================================================
