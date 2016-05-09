function value_OUT = getDropCallback(obj_IN)
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% TEMPLATE MATLAB
%==========================================================================
% FILENAME: getDropCallback.m
% PATH    : $TEMPLATE_HOME$\src\class\common\@cDropNDrop
%==========================================================================
% ABSTRACT: Drag and drop: get the drop callback
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
%==========================================================================
% OUTPUT:
%   value_OUT	: cell array containing all drag callback
%==========================================================================
value_OUT = obj_IN.drop_callback;
%==========================================================================

