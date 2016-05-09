function value_OUT = isMultipleError(obj_IN)
%==========================================================================
% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: isMultipleError.m
% PATH: ..\common\@cErrorManager
%==========================================================================
% ABSTRACT: Indicate if multiple error has been catched
%==========================================================================
% REVISION HISTORY:
%   AUTHOR      	COMPANY     DATE        COMMENT
%	Mathieu CABANES	AROB@S      23/10/2013  Class creation
%
%   <NAME>       	<COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cErrorManager object
%==========================================================================
% OUTPUT:
%   value_OUT  	: logical indicating how many errors has been catched
%==========================================================================

% Initialize output
% -----------------
value_OUT = false;

% Define the error
% ----------------
current_errors = obj_IN.getError('all');

if length(current_errors)>1; value_OUT = true; end;
%==========================================================================
