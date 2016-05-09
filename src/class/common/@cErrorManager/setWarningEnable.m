function obj_OUT = setWarningEnable(obj_IN, value_IN)
%==========================================================================
% VOLVO GTT 2014
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: setWarningEnable.m
% PATH: ..\common\@cErrorManager
%==========================================================================
% ABSTRACT: Set the error
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES         AROB@S      25/02/2014  Creation
%	Mathieu CABANES         AROB@S      26/02/2014  Quality update & speed
%                                                   optimization
%
%   <NAME>       	<COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cErrorManager object
%   value_IN    : Warning enability status
%==========================================================================
% OUTPUT:
%   obj_OUT     : Updated cErrorManager object
%==========================================================================

% Manage input arguments
% ----------------------
if ~islogical(value_IN); throw(ClassCastException(...
        'logical required as input')); end;

% Initialize output variable
% --------------------------
obj_OUT = obj_IN;

% Define new warning enability status
% -----------------------------------
obj_OUT.warning_enable = value_IN;
%==========================================================================
