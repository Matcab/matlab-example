function obj_OUT = setModificationDate(obj_IN, value_IN)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: setModificationDate.m
% PATH    : ..\common\@cInfos
%==========================================================================
% ABSTRACT: Set modification date
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      21/07/2011  Creation
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
%   obj_IN    	: cInfos object
%   value_IN  	: value to set
%==========================================================================
% OUTPUT:
%   obj_OUT  	: updated cInfos object
%==========================================================================

% Manage input argument
% ---------------------
if ~ischar(value_IN); throw(ClassCastException(...
        'String required as input')); end;

% Initialize output object
% ------------------------
obj_OUT = obj_IN;

% Update the modification date
% ----------------------------
obj_OUT.modification = value_IN;
%==========================================================================
