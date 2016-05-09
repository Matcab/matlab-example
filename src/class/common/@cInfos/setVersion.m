function obj_OUT = setVersion(obj_IN, value_IN)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: setVersion.m
% PATH    : ..\common\@cInfos
%==========================================================================
% ABSTRACT: Set version
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      21/07/2011  Creation
%	Mathieu CABANES         AROB@S      04/01/2013  Migration to MATLAB
%                                                   2011b
%	Mathieu CABANES         AROB@S      26/02/2014  Quality update & speed
%                                                   optimization
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN    	: cInfos object
%   value_IN 	: version value to set
%==========================================================================
% OUTPUT:
%   obj_OUT 	: updated object
%==========================================================================

% Manage input arguments
% ----------------------
if ~isnumeric(value_IN) || length(value_IN)>1; throw(ClassCastException(...
        'Scalar value required as input')); end;

% Initialize object
% -----------------
obj_OUT = obj_IN;

% set value
% ---------
obj_OUT.version = value_IN;

% Update cInfos
% -------------
obj_OUT = updateInfos(obj_OUT);
%==========================================================================
