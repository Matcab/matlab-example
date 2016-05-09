function obj_OUT = setAuthor(obj_IN, value_IN)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: setAuthor.m
% PATH    : ..\common\@cInfos
%==========================================================================
% ABSTRACT: Set author
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu GUERIN          AROB@S      19/04/2012  Creation
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
%   obj_IN      : cInfos object
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
obj_OUT.author = value_IN;

% Update element
% --------------
obj_OUT = updateInfos(obj_OUT);
%==========================================================================
