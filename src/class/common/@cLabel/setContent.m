function obj_OUT = setContent(obj_IN, value_IN)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: setContent.m
% PATH    : ..\common\@cLabel
%==========================================================================
% ABSTRACT: Set label content
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES         AROB@S      12/03/2013  Creation
%	Mathieu CABANES         AROB@S      26/02/2014  Quality update & speed
%                                                   optimization
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cLabel object
%   value_IN  	: value to set
%==========================================================================
% OUTPUT:
%   obj_OUT    	: updated object
%==========================================================================

% Manage input argument
% ---------------------
if ~ischar(value_IN); throw(ClassCastException(...
        'String required as input')); end;

% Initialize output object
% ------------------------
obj_OUT = obj_IN;

% Set value
% ---------
obj_OUT.content = value_IN;
%==========================================================================
