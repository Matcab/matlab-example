function obj_OUT = setDisplayedName(obj_IN, value_IN)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: setDisplayedNames.m
% PATH    : ..\common\@cInfos
%==========================================================================
% ABSTRACT: Set displayed name
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu GUERIN          AROB@S      02/03/2012  Creation
%	Mathieu CABANES         AROB@S      04/01/2013  Migration to MATLAB
%                                                   2011b
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cInfos object
%   value_IN  	: value to set   
%==========================================================================
% OUTPUT:
%   obj_OUT    	: updated object
%==========================================================================
% Manage input argument
% ---------------------
cast_exception = ClassCastException('String required as input');
if ~ischar(value_IN); throw(cast_exception); end;

% Initialize output object
% ------------------------
obj_OUT = obj_IN;

% Set value
% ---------
obj_OUT.displayedName = value_IN;

% Update element
% --------------
obj_OUT = updateInfos(obj_OUT);
%==========================================================================
