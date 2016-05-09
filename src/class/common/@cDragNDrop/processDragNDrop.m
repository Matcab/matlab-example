function processDragNDrop(obj_IN, hObject, ~)
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% TEMPLATE MATLAB
%==========================================================================
% FILENAME: processDragNDrop.m
% PATH    : $TEMPLATE_HOME$\src\class\common\@cDragNDrop
%==========================================================================
% ABSTRACT: Drag and drop: define drag & drop process
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES       	AROB@S      10/07/2014  Creation
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cDragNDrop object
%   varargin    : command line arguments to processDragNDrop (see VARARGIN)
%==========================================================================
% OUTPUT:
%==========================================================================

% Define the parent handle of the source
% --------------------------------------
% This restricts the application to uicontrols and axes. 
source_handle = hObject;
parent_handle = get(hObject, 'Parent');

% Check the parent: if it's an axes, not a figure, we do a little
% manipulation. This allows you to drag an axes by grabbing one of it's
% lines. Assign the parent axes to source.
if strcmp(get(parent_handle, 'Type'), 'axes'); source_handle = ...
        parent_handle; end;

% Manage the drag
% ---------------
% dragrect works with rect specified in pixels.  Odd, since it returns
% values in the host figure's units. 
LocalDefineDragForm(obj_IN, source_handle);

% Figure out where we landed
% --------------------------
% Get the object(s) under the mouse
current_objects = LocalManageTargetedObject(obj_IN);

% Replace any axes children with their parents since we don't track axes
% children as drop targets 
parent_objects = get(current_objects, 'Parent');
if iscell(parent_objects); parent_objects = vertcat(parent_objects{:}); end;

children_axes = strcmp(get(parent_objects,'Type'),'axes');
current_objects(children_axes) = parent_objects(children_axes);

% Check if the objects are in the drop handles list
drop_handles = obj_IN.getDropHandles;

% Index into drop target we hit
selected_handles_index = find(ismember(drop_handles, current_objects));

% Manage an non target object: indicate to user that this wasn't valid.
if isempty(selected_handles_index); LocalNotValidTarget(obj_IN); return; end;

% Check drop target valididity
drop_valid_drag_handles = obj_IN.getDropValidDrag;

% Valid drag sources for this target
valid_drag_handles = drop_valid_drag_handles{selected_handles_index};

% Manage an non valid source fir this target
if ~ismember(source_handle, valid_drag_handles); LocalNotValidTarget(obj_IN); ...
        return; end;

% Evaluate callback
% -----------------
% Did we hit multiple targets? If so, only fire callback for first one
if length(selected_handles_index) > 1; selected_handles_index = ...
        selected_handles_index(1); end;

drop_callbacks   = obj_IN.getDropCallback;
current_callback = drop_callbacks{selected_handles_index};
feval(current_callback{1:end});
%==========================================================================

function LocalDefineDragForm(obj_IN, source_handle_IN)
%==========================================================================
%% DESCRIPTION: Initialize the TEMPLATE advanced interface
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%==========================================================================
% OUTPUT:
%==========================================================================

source_units = get(source_handle_IN ,'Units');
set(source_handle_IN, 'Units', 'pixels');

current_point = get(obj_IN.figure_handle, 'CurrentPoint');

source_position = get(source_handle_IN, 'Position');
drag_position   = [current_point(1)-source_position(3)/2 ...
    current_point(2)-10 source_position(3) 20];
new_drag_position = dragrect(drag_position); %#ok<NASGU>

set(source_handle_IN,'Units',source_units);
%==========================================================================

function current_objects_OUT = LocalManageTargetedObject(obj_IN)
%==========================================================================
%% DESCRIPTION: Define the object pointed with the mouse
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN              : cDragNDrop object
%==========================================================================
% OUTPUT:
%   current_objects_OUT	: target object
%==========================================================================

% initialize output
% -----------------
exist_children    = true;
parent_handle     = obj_IN.figure_handle;
initial_position  = [0 0];

% Define the current pointer position
% -----------------------------------
current_pointer = get(obj_IN.figure_handle, 'CurrentPoint');

% Define the Drop handles objects
% -------------------------------
while exist_children

    children_handles = get(parent_handle, 'Children');
    
    % Remove menus, so that everything else works nicely.
    menus_handles = [findobj(parent_handle, 'Type', 'uimenu'); ...
        findobj(parent_handle, 'Type', 'uicontextmenu')];
    children_handles = setdiff(children_handles, menus_handles);
    
    if ~isempty(children_handles) && ~strcmpi(get(parent_handle,'Type'), ...
            'axes') 

        % Define childre position
        tmp_children_position = get(children_handles, 'Position');
        
        % Manage only the standard object with 4 position values
        children_position = cell2mat(tmp_children_position(cell2mat(...
            cellfun(@(x)(length(x)==4), tmp_children_position, ...
            'UniformOutput', false))));

        % Update the position according to the figure position
        children_position(:,1) = children_position(:,1)+ initial_position(1);
        children_position(:,2) = children_position(:,2)+ initial_position(2);
        
        % Identify the possible targets
        selected_handle = children_handles(...
            current_pointer(1)>=children_position(:,1) & ...
            current_pointer(1)<=children_position(:,1)+children_position(:,3) & ...
            current_pointer(2)>=children_position(:,2) & ...
            current_pointer(2)<=children_position(:,2)+children_position(:,4));
        
            % Manage several objects located at the same place
        if length(selected_handle)>1 ; selected_handle = findobj(...
                selected_handle, 'Visible', 'on'); end;

        % Update the parent handle
        parent_handle     = selected_handle;
        selected_position = get(selected_handle, 'Position');
        initial_position  = initial_position + selected_position(1:2);
        
    else
        
        exist_children = false;
        
    end
        
end

% Define the current object
% -------------------------
current_objects_OUT = parent_handle;

% Manage not available uicontrols
if strcmpi(get(current_objects_OUT, 'Type'), 'uicontrol') && ...
        strcmpi(get(current_objects_OUT, 'Enable'), 'off')
    
    current_objects_OUT = [];
    
end
%==========================================================================

function LocalNotValidTarget(obj_IN)
%==========================================================================
%% DESCRIPTION: Initialize the TEMPLATE advanced interface
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN	: cDragNDrop object
%==========================================================================
% OUTPUT:
%==========================================================================

% Indicate to the user that the source can't be dropped here
% ----------------------------------------------------------
pointer      = get(obj_IN.figure_handle, 'Pointer');
default_icon = LocalDefineNotValidIcon;

set(obj_IN.figure_handle, 'Pointer','custom');
set(obj_IN.figure_handle, 'PointerShapeCData', default_icon, ...
    'PointerShapeHotSpot',[9 9]);
pause(0.2);
set(obj_IN.figure_handle, 'Pointer', pointer);
%==========================================================================

function icon_OUT = LocalDefineNotValidIcon
%==========================================================================
%% DESCRIPTION: Design a non valid icon
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%==========================================================================
% OUTPUT:
%   icon_OUT = matrix of the non valid icon
%==========================================================================

% Create icon for mouse pointer indicating target isn't valid
icon_OUT = [...
    NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
    NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
    NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
    NaN NaN NaN NaN NaN NaN NaN 1   1   NaN NaN NaN 1   NaN NaN NaN
    NaN NaN NaN NaN NaN 1   NaN NaN 1   1   1   NaN NaN NaN NaN NaN
    NaN NaN NaN NaN 1   NaN NaN NaN NaN NaN 1   1   NaN NaN NaN NaN
    NaN NaN NaN NaN 1   NaN NaN NaN NaN 1   NaN 1   NaN NaN NaN NaN
    NaN NaN NaN 1   NaN NaN NaN NaN 1   NaN NaN NaN 1   NaN NaN NaN
    NaN NaN NaN 1   NaN NaN NaN 1   NaN NaN NaN NaN 1   NaN NaN NaN
    NaN NaN NaN NaN 1   NaN 1   NaN NaN NaN NaN 1   NaN NaN NaN NaN
    NaN NaN NaN NaN 1   1   NaN NaN NaN NaN NaN 1   NaN NaN NaN NaN
    NaN NaN NaN NaN 1   1   1   NaN NaN 1   1   NaN NaN NaN NaN NaN
    NaN NaN NaN 1   NaN NaN NaN 1   1   NaN NaN NaN NaN NaN NaN NaN
    NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
    NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
    NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN];
%==========================================================================
