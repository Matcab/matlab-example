function obj_OUT = setComment(obj_IN, value_IN)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: setComment.m
% PATH    : ..\common\@cInfos
%==========================================================================
% ABSTRACT: Set comment
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
%   obj_IN   	: cInfos object
%   value_IN   	: value to set
%==========================================================================
% OUTPUT:
%   obj_OUT    	: updated object
%==========================================================================

% Manage input
% ------------
if ~ischar(value_IN); throw(ClassCastException(...
        'String required as input')); end;

% Initialize output object
% ------------------------
obj_OUT = obj_IN;

% Set value
% ---------
obj_OUT.comment = value_IN;

% Update cInfos
% -------------
obj_OUT = updateInfos(obj_OUT);
%==========================================================================
