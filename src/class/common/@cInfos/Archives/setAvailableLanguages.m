function obj_OUT = setAvailableLanguages(obj_IN, value_IN)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: setAvailableLanguages.m
% PATH    : ..\common\@cInfos
%==========================================================================
% ABSTRACT: Set comment
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES         AROB@S      24/04/2013  Creation
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN   	: cInfos object
%   value_IN   	: value to set
%==========================================================================
% OUTPUT:
%   obj_OUT    	: updated object
%==========================================================================
% Manage input
% ------------
cast_exception = ClassCastException('cell required as input');
if ~iscell(value_IN); throw(cast_exception); end;

% Initialize output object
% ------------------------
obj_OUT = obj_IN;

% Set value
% ---------
obj_OUT.available_languages = value_IN;

% Update cInfos
% -------------
obj_OUT = updateInfos(obj_OUT);
%==========================================================================
