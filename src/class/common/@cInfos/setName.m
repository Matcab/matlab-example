function obj_OUT = setName(obj_IN, value_IN)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: setName.m
% PATH    : ..\common\@cInfos
%==========================================================================
% ABSTRACT: Set name
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

% Define the name
% ---------------
if isempty(strrep(value_IN,' ',''))

    % empty name
    obj_OUT.name = '';

else
    
    % Set value
    obj_OUT.name = value_IN;

end

% Update element
% --------------
obj_OUT = updateInfos(obj_OUT);
%==========================================================================
