function obj_OUT = setElement(obj_IN, value_IN)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: setElement.m
% PATH    : ..\class\common\@cGenericData
%==========================================================================
% ABSTRACT: Set Element
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      21/07/2011  Creation
%	Mathieu CABANES         AROB@S      22/01/2013  Migration to MATLAB
%                                                   2011b
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cGenericData object
%   value_IN  	: value to set
%==========================================================================
% OUTPUT:
%   obj_OUT 	: updated object
%==========================================================================
% EXCEPTION:
%   ClassCastException
%==========================================================================

% Manage input argument
% ---------------------
if ~isa(value_IN, class(obj_IN.element))

    throw(ClassCastException([class(obj_IN.element), ...
        ' required as element type.']));

end

% Initialize output
% -----------------
obj_OUT = obj_IN;

% Set elements
% ------------
obj_OUT.element = value_IN;

% Update element
% --------------
obj_OUT = obj_OUT.updateInfos();
%==========================================================================
