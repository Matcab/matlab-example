function obj_OUT = setDragHandles(obj_IN, value_IN)
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% TEMPLATE MATLAB
%==========================================================================
% FILENAME: getDragHandles.m
% PATH    : $TEMPLATE_HOME$\src\class\common\@cDragNDrop
%==========================================================================
% ABSTRACT: Drag and drop: get the drag handles
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES       	AROB@S      09/07/2014  Creation
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%
% There are some choices to make here. 
% If a uicontrol is set inactive, you can drag it with your left mouse
% button. But, this doesn't allow you to "use" the control. This is fine
% for pushbuttons, but not good for popupmenus and listboxes for instance.
% If the control is enabled, you have to right-click to drag. 
%
% Here's my decision: Disable only pushbuttons and frames. This will allow
% you to drag these with left mouse button. Others will require right-click.
%
% If object is an axes, set all children to be draggable, too (so you can
% click on a line to move the axis, for instance). If this behavior isn't
% enabled, you get different behavior when you click on an axes background
% and when you click on a line.  I need to turn this off if I ever enable
% dragging of lines from one plot to another. 
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
        'are required as drag handles'])); end;

% Initialize objects
% ------------------
obj_OUT = obj_IN;

% Define Drag handles
% -------------------
obj_OUT.drag_handles = value_IN;
%==========================================================================
