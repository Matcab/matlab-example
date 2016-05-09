function obj_OUT = setDropCallback(obj_IN, value_IN)
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% TEMPLATE MATLAB
%==========================================================================
% FILENAME: setDropCallback.m
% PATH    : $TEMPLATE_HOME$\src\class\common\@cDragNDrop
%==========================================================================
% ABSTRACT: Drag and drop: define drop callback
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
%   value_IN	: cell array containing all drag callback
%==========================================================================
% OUTPUT:
%   obj_OUT     : Updated cDragNDrop object
%==========================================================================

% Manage input arguments
% ----------------------
if ~iscell(value_IN) && ~all(cell2mat(cellfun(@(x)(isa(x, ...
        'function_handle')), value_IN, 'UniformOutput', false)))
    
    throw(ClassCastException(...
        'input argument should be a cell array of function handles')); 

end

% Initialize objects
% ------------------
obj_OUT = obj_IN;

% Define Drag handles
% -------------------
obj_OUT.drop_callback = value_IN;
%==========================================================================
