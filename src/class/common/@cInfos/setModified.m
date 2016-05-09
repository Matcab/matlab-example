function obj_OUT = setModified(obj_IN, value_IN)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: setModified.m
% PATH    : ..\common\@cInfos
%==========================================================================
% ABSTRACT: Set modified status
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES       	AROB@S      19/12/2012  Creation
%	Mathieu CABANES         AROB@S      03/01/2013  Migration to MATLAB
%                                                   2011b
%	Michel OLPHE GALLIARD 	AROB@S      26/02/2014  Quality update & speed
%                                                   optimization
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
if ~islogical(value_IN); throw(ClassCastException(...
        'Logical value required as input')); end;

% Initialize output object
% ------------------------
obj_OUT = obj_IN;

% Set value
% ---------
obj_OUT.modified = value_IN;

% Update element
% --------------
obj_OUT = updateInfos(obj_OUT);
%==========================================================================
