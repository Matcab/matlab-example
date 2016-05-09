function obj_OUT = setDropValidDrag(obj_IN, value_IN)
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% TEMPLATE MATLAB
%==========================================================================
% FILENAME: setDropValidDrag.m
% PATH    : $TEMPLATE_HOME$\src\class\common\@cDragNDrop
%==========================================================================
% ABSTRACT: Drag and drop: define drop valid drag handles
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
%   value_IN	: cell array containing all drop valid drag handles
%==========================================================================
% OUTPUT:
%   obj_OUT     : Updated cDragNDrop object
%==========================================================================

% Manage input arguments
% ----------------------
if ~isempty(value_IN) && ~iscell(value_IN) && ~all(cell2mat(cellfun(@(x)(...
        ishandle(x)), value_IN, 'UniformOutput', false)))
    
    throw(ClassCastException(['input argument should be a cell array ', ...
        'of objects handles or empty'])); 

end

% Initialize objects
% ------------------
obj_OUT    = obj_IN;
valid_drag = cell(1, length(obj_OUT.drop_handles));

% Check handles accordign to drag handles
% ---------------------------------------
if isempty(value_IN)
    
    for i_handle = 1:length(obj_OUT.drop_handles)
        
        valid_drag{i_handle} = obj_OUT.drag_handles;
    
    end
    
else

    for i_handle = 1:length(obj_OUT.drop_handles)
    
        if i_handle <= length(value_IN)
        
            valid_drag{i_handle} = value_IN(ismember(value_IN{i_handle}, ...
                obj_OUT.drop_handles));

        else
            
            valid_drag{i_handle} = obj_OUT.drag_handles;
            
        end
        
    end
    
end

% Define Drag handles
% -------------------
obj_OUT.drop_valid_drag = valid_drag;
%==========================================================================
