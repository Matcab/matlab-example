function obj_OUT = setID(obj_IN, value_IN)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: setID.m
% PATH    : ..\class\common\@cIdentifiable
%==========================================================================
% ABSTRACT: Set id
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      21/07/2011  Creation
%	Mathieu CABANES      	AROB@S      04/01/2013  Migration to MATLAB
%                                                   2011b
%	Mathieu CABANES         AROB@S      26/02/2014  Quality update & speed
%                                                   optimization
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cIdentifiable object
%   value_IN 	: integer of the ID
%==========================================================================
% OUTPUT:
%   obj_OUT  	: updated object
%==========================================================================
% EXCEPTION:
%   ClassCastException
%==========================================================================

% Manage input argument
% ---------------------
if ~isInteger(value_IN) || ~isscalar(value_IN); throw(...
        ClassCastException('Integer required as input')); end;

% Initialize object
% -----------------
obj_OUT = obj_IN;

% Set value
% ---------
obj_OUT.ID = value_IN;
%==========================================================================
