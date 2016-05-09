function obj_OUT = initialize(obj_IN)
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% TEMPLATE MATLAB
%==========================================================================
% FILENAME: initialize.m
% PATH    : $TEMPLATE_HOME$\src\class\common\@cDragNDrop
%==========================================================================
% ABSTRACT: Drag and drop: initialize the drag & drop feature
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES       	AROB@S      11/07/2014  Creation
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
%==========================================================================
% OUTPUT:
%   obj_OUT     : Updated cDragNDrop object
%==========================================================================

% Initialize objects
% ------------------
obj_OUT = obj_IN;

% Define Drag handles
% -------------------
drag_handle = obj_OUT.drag_handles;

% Manage no definition
if isempty(drag_handle); return; end;

% Enable dragging on these objects
% --------------------------------
% First, disable uicontrols
value_types     = get(drag_handle, 'Type');

uicontrol_index          = find(strcmp('uicontrol', value_types));
disabled_uicontrol_index = strcmp(get(drag_handle(uicontrol_index), ...
    'Style'), 'pushbutton') | strcmp(get(drag_handle(uicontrol_index), ...
    'Style'), 'frame');

set(drag_handle(uicontrol_index(disabled_uicontrol_index)), 'Enable', ...
    'inactive');

% Manage axes
axes_index    = strcmp('axes', value_types);
children_axes = get(drag_handle(axes_index), 'Children');

% manage multiple axes (A row vector)
 if iscell(children_axes); children_axes = vertcat(children_axes{:})'; end;
drag_handle = [drag_handle children_axes];

% Set ButtonDownFcn to enable dragging
% ------------------------------------
set(drag_handle, 'ButtonDownFcn', @(src, event)processDragNDrop(obj_OUT, ...
    src, event));
%==========================================================================
